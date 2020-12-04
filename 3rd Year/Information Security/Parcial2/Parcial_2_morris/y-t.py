from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class_2 import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

#Implementar protocolo Yahalom

# Crear Clave KAT, guardar a fichero
KAT = funciones_aes.crear_AESKey()
FAT = open("KAT.bin", "wb")
FAT.write(KAT)
FAT.close()
 
# Crear Clave KBT, guardar a fichero
KBT = funciones_aes.crear_AESKey()
FBT = open("KBT.bin", "wb")
FBT.write(KBT)
FBT.close()

# Crear Clave KAB
KAB = funciones_aes.crear_AESKey()

# Crear el socket de escucha de Alice (5553)
print("Esperando a Bob...")
socket_Bob = SOCKET_SIMPLE_TCP('127.0.0.1', 5553)
socket_Bob.escuchar_esperar()
socket_Bob.escuchar_aceptar()

#Paso 3. T -> A: Ekat{B,Kab,Na,Nb}, Ekbt{A,Kab}
#Recibo B,Ekbt{A,Na,Nb} y cierro conexion con Bob
B = socket_Bob.recibir()
B = B.decode("utf-8","ignore")
cifrado = socket_Bob.recibir()
cifrado_mac = socket_Bob.recibir()
cifrado_nonce = socket_Bob.recibir()
socket_Bob.cerrar()

#Descifro Ekbt{A,Na,Nb}
datos_descifrar_BT = funciones_aes.descifrarAES_GCM(KBT,cifrado_nonce,cifrado,cifrado_mac)
json_BT = datos_descifrar_BT.decode("utf-8","ignore")
msg_BT = json.loads(json_BT)
A, Na, Nb = msg_BT
Na = bytearray.fromhex(Na)
Nb = bytearray.fromhex(Nb)

#Creo Ekat{B,Kab,Na,Nb}
aes_engine_TAA = funciones_aes.iniciarAES_GCM(KAT)
msg_TAA = [B,KAB.hex(), Na.hex(), Nb.hex()]
json_TAA = json.dumps(msg_TAA)
cifrado_TAA, cifrado_mac_TAA, cifrado_nonce_TAA = funciones_aes.cifrarAES_GCM(aes_engine_TAA,json_TAA.encode("utf-8"))

#Creo Ekbt{A,Kab}
aes_engine_TAB = funciones_aes.iniciarAES_GCM(KBT)
msg_TAB = [A, KAB.hex()]
json_TAB = json.dumps(msg_TAB)
cifrado_TAB, cifrado_mac_TAB, cifrado_nonce_TAB = funciones_aes.cifrarAES_GCM(aes_engine_TAB,json_TAB.encode("utf-8"))

# Crear el socket de conexion con Alice (5552)
print("Creando conexion con Alice...")
socket_Alice = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)

#Envio Ekat{B,Kab,Na,Nb}, Ekbt{A,Kab} y cierro conexion con Alice
socket_Alice.conectar()
socket_Alice.enviar(cifrado_TAA)
socket_Alice.enviar(cifrado_mac_TAA)
socket_Alice.enviar(cifrado_nonce_TAA)
socket_Alice.enviar(cifrado_TAB)
socket_Alice.enviar(cifrado_mac_TAB)
socket_Alice.enviar(cifrado_nonce_TAB)
socket_Alice.cerrar()

#Cierro Trent
print("Trent ha terminado su trabajo :)")

