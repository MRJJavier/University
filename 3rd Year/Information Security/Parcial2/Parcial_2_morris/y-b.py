from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class_2 import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

#Implementar protocolo Yahalom

# Lee clave KBT
KBT = open("KBT.bin", "rb").read()


# Crear el socket de escucha de Alice (5551)
print("Esperando a Alice...")
socket_Alice = SOCKET_SIMPLE_TCP('127.0.0.1', 5551)
socket_Alice.escuchar_esperar()
socket_Alice.escuchar_aceptar()

# Crear el socket de conexion con Trent (5553)
print("Creando conexion con Trent...")
socket_Trent = SOCKET_SIMPLE_TCP('127.0.0.1', 5553)
socket_Trent.conectar()

#Paso 2: B -> T: Ekbt{A,Na,Nb}
B = "Bob"
Nb = get_random_bytes(16)
json1_AB = socket_Alice.recibir()
msg1_AB = json.loads(json1_AB.decode("utf-8","ignore"))
A, Na = msg1_AB
Na = bytearray.fromhex(Na)

#Creo Ekbt{A,Na,Nb}
msg_BT = [A,Na.hex(),Nb.hex()]
json_BT = json.dumps(msg_BT)
aes_engine_BT = funciones_aes.iniciarAES_GCM(KBT)
cifrado, cifrado_mac, cifrado_nonce = funciones_aes.cifrarAES_GCM(aes_engine_BT,json_BT.encode("utf-8"))

#Envio B,Ekbt{A,Na,Nb} y cierro conexion con Trent
socket_Trent.enviar(B.encode("utf-8"))
socket_Trent.enviar(cifrado)
socket_Trent.enviar(cifrado_mac)
socket_Trent.enviar(cifrado_nonce)
socket_Trent.cerrar()

#Paso 4. A -> B: Ekbt{A,KAB},Ekab{Nb}
#Recibo Ekbt{A,KAB},Ekab{Nb} y cierro conexion con Alice
cifrado_TAB = socket_Alice.recibir()
cifrado_mac_TAB = socket_Alice.recibir()
cifrado_nonce_TAB = socket_Alice.recibir()
cifrado2_AB = socket_Alice.recibir()
cifrado2_mac_AB = socket_Alice.recibir()
cifrado2_nonce_AB = socket_Alice.recibir()
socket_Alice.cerrar()

#Descifro Ekbt{A,KAB}
datos_descifrado_TAB = funciones_aes.descifrarAES_GCM(KBT,cifrado_nonce_TAB,cifrado_TAB,cifrado_mac_TAB)
json_TAB = datos_descifrado_TAB.decode("utf-8","ignore")
msg_TAB = json.loads(json_TAB)
t_A, KAB = msg_TAB
KAB = bytearray.fromhex(KAB)

#Descifro Ekab{Nb}
datos_descifrado2_AB = funciones_aes.descifrarAES_GCM(KAB,cifrado2_nonce_AB,cifrado2_AB,cifrado2_mac_AB)
NB = datos_descifrado2_AB.decode("utf-8","ignore")
t_Nb = bytearray.fromhex(NB)

#Realizo la comprobacion de las A
if t_A != A:
    print("Error los A son distintos")
    sys.exit()
#Realizo la comprobacion de los Nb
if t_Nb != Nb:
    print("Error los Nb son distintos")
    sys.exit()

#Cierro Bob
print("Bob ha terminado su trabajo :)")