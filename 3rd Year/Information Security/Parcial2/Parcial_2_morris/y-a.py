from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class_2 import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

#Implementar protocolo Yahalom

# Lee clave KAT
KAT = open("KAT.bin", "rb").read()

# Crea el socket de escucha con Trent (5552)
socket_Trent = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket_Trent.escuchar_esperar()

# Crear el socket de conexion con Bob (5551)
print("Creando conexion con Bob...")
socket_Bob = SOCKET_SIMPLE_TCP('127.0.0.1', 5551)
socket_Bob.conectar()

# Paso 1. A -> B: A,Na
# Creo A,Na y envio
A = "Alice"
Na = get_random_bytes(16)
msg1_AB =  [A,Na.hex()]
json1_AB = json.dumps(msg1_AB)
socket_Bob.enviar(json1_AB.encode("utf-8"))

#Paso 3. T -> A: Ekat{B,Kab,Na,Nb}, Ekbt{A,Kab}
#Recibo Ekat{B,Kab,Na,Nb}, Ekbt{A,Kab} y cierro conexion con Trent
socket_Trent.escuchar_aceptar()
cifrado_TAA = socket_Trent.recibir()
cifrado_mac_TAA = socket_Trent.recibir()
cifrado_nonce_TAA = socket_Trent.recibir()
cifrado_TAB = socket_Trent.recibir()
cifrado_mac_TAB = socket_Trent.recibir()
cifrado_nonce_TAB = socket_Trent.recibir()
socket_Trent.cerrar()

#Descifro Ekat{B,Kab,Na,Nb}
datos_descifrar_TAA = funciones_aes.descifrarAES_GCM(KAT,cifrado_nonce_TAA,cifrado_TAA,cifrado_mac_TAA)
json_TAA = datos_descifrar_TAA.decode("utf-8","ignore")
msg_TAA = json.loads(json_TAA)
B, KAB, t_Na, Nb = msg_TAA
KAB = bytearray.fromhex(KAB)
t_Na = bytearray.fromhex(t_Na)
Nb = bytearray.fromhex(Nb)

#Realizo la comprobacion de los Na
if t_Na != Na:
    print("Error los Na son distintos")
    sys.exit()

#Paso 4. A -> B: Ekbt{A,KAB},Ekab{Nb}
#Creo Ekab{Nb}
aes_engine2_AB = funciones_aes.iniciarAES_GCM(KAB)
NB = Nb.hex()
cifrado2_AB, cifrado2_mac_AB, cifrado2_nonce_AB = funciones_aes.cifrarAES_GCM(aes_engine2_AB,NB.encode("utf-8"))

#Envio Ekbt{A,KAB},Ekab{Nb} y cierro conexion con Bob
socket_Bob.enviar(cifrado_TAB)
socket_Bob.enviar(cifrado_mac_TAB)
socket_Bob.enviar(cifrado_nonce_TAB)
socket_Bob.enviar(cifrado2_AB)
socket_Bob.enviar(cifrado2_mac_AB)
socket_Bob.enviar(cifrado2_nonce_AB)
socket_Bob.cerrar()

#Cierro Alice
print("Alice ha terminado su trabajo :)")
