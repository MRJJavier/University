from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

# Lee clave KAT
KAT = open("KAT.bin", "rb").read()

# Crear el socket de conexion con T (5551)
print("Creando conexion con T...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5550)
socket.conectar()

# Paso 1) B->T: KAT(Alice, Na) en AES-GCM
t_n = get_random_bytes(16)
msg_TA = ["Alice", t_n.hex()]
json_AT = json.dumps(msg_TA)
aes_engine = funciones_aes.iniciarAES_GCM(KAT)
cifrado, cifrado_mac, cifrado_nonce = funciones_aes.cifrarAES_GCM(aes_engine,json_AT.encode("utf-8"))
socket.enviar(cifrado)
socket.enviar(cifrado_mac)
socket.enviar(cifrado_nonce)
# Paso 2) T->B: KBT(K1, K2, Nb) en AES-GCM
# A empezar a resolver!!!!!!!
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
socket.cerrar()
datos_descifrado_TA = funciones_aes.descifrarAES_GCM(KAT,cifrado_nonce,cifrado,cifrado_mac)
json_TA = datos_descifrado_TA.decode("utf-8","ignore")
msg_TA = json.loads(json_TA)
t_k1, t_k2, t_na = msg_TA
t_k1 = bytearray.fromhex(t_k1)
t_k2 = bytearray.fromhex(t_k2)
t_na = bytearray.fromhex(t_na)

if t_na != t_n:
    print("Error: nonce equivocado")
    exit()
# Espero a Alice para el paso 5)
print("Creando conexion con Bob...")
socket_Bob = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket_Bob.conectar()
# Paso 5) A->B: KAB(Nombre) en AES-CTR con HMAC
mensaje_AB = "Nombre"
mensaje_AB = mensaje_AB.encode("utf-8")
aes_engine_AB = funciones_aes.iniciarAES_CTR(t_k1)
cifrado,cifrado_nonce = funciones_aes.cifrarAES_CTR(aes_engine_AB,mensaje_AB)
hash_engine_AB = HMAC.new(t_k2, digestmod=SHA256)
hash_engine_AB.update(mensaje_AB)
cifrado_hmac = hash_engine_AB.digest()
socket_Bob.enviar(cifrado)
socket_Bob.enviar(cifrado_hmac)
socket_Bob.enviar(cifrado_nonce)
# Paso 6) B->A: KAB(Apellido) en AES-CTR con HMAC
cifrado = socket_Bob.recibir()
cifrado_hmac = socket_Bob.recibir()
cifrado_nonce = socket_Bob.recibir()
datos_descifrado_BA = funciones_aes.descifrarAES_CTR(t_k1,cifrado_nonce,cifrado)
hash_engine_BA = HMAC.new(t_k2,digestmod=SHA256)
hash_engine_BA.update(datos_descifrado_BA)
try:
    hash_engine_BA.verify(cifrado_hmac)
except ValueError:
    print("Alice verify error")
    exit()
# Termina la comunicacion
print("Cerrando Alice. El canal fue creado con exito")
socket_Bob.cerrar()
