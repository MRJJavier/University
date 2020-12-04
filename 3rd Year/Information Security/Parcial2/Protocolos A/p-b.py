from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

def cifraPaso1(emisor, receptor, KET, E, t_ne):
    """ Cifra el mensaje del paso 1, y devuelve el cifrado """
    # Codifica el contenido (los campos binarios en una cadena) y contruyo el mensaje JSON
    msg_TE = []
    msg_TE.append(E)
    msg_TE.append(t_ne.hex())
    json_ET = json.dumps(msg_TE)
    print(emisor + "->" + receptor + " (descifrado): " + json_ET)

    # Cifra los datos con AES GCM
    aes_engine = funciones_aes.iniciarAES_GCM(KET)
    t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,json_ET.encode("utf-8"))

    return t_cifrado, t_mac, t_nonce

# Lee clave KBT
KBT = open("KBT.bin", "rb").read()

# Crear el socket de conexion con T (5551)
print("Creando conexion con T...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5551)
socket.conectar()

# Paso 1) B->T: KAT(Alice, Na) en AES-GCM
t_n = get_random_bytes(16)
msg_TB = ["Bob", t_n.hex()]
json_BT = json.dumps(msg_TB)
aes_engine = funciones_aes.iniciarAES_GCM(KBT)
cifrado, cifrado_mac, cifrado_nonce = funciones_aes.cifrarAES_GCM(aes_engine,json_BT.encode("utf-8"))
socket.enviar(cifrado)
socket.enviar(cifrado_mac)
socket.enviar(cifrado_nonce)
# Paso 2) T->B: KBT(K1, K2, Nb) en AES-GCM
# A empezar a resolver!!!!!!!
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
socket.cerrar()
datos_descifrado_TB = funciones_aes.descifrarAES_GCM(KBT,cifrado_nonce,cifrado,cifrado_mac)
json_TB = datos_descifrado_TB.decode("utf-8","ignore")
msg_TB = json.loads(json_TB)
t_k1, t_k2, t_nb = msg_TB
t_k1 = bytearray.fromhex(t_k1)
t_k2 = bytearray.fromhex(t_k2)
t_nb = bytearray.fromhex(t_nb)

if t_nb != t_n:
    print("Error: nonce equivocado")
    exit()
# Espero a Alice para el paso 5)
print("Esperando a Alice...")
socket_Alice = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket_Alice.escuchar()
# Paso 5) A->B: KAB(Nombre) en AES-CTR con HMAC
cifrado = socket_Alice.recibir()
cifrado_hmac = socket_Alice.recibir()
cifrado_nonce = socket_Alice.recibir()
datos_descifrado_AB = funciones_aes.descifrarAES_CTR(t_k1,cifrado_nonce,cifrado)
hash_engine_AB = HMAC.new(t_k2,digestmod=SHA256)
hash_engine_AB.update(datos_descifrado_AB)
try:
    hash_engine_AB.verify(cifrado_hmac)
except ValueError:
    print("Bob verify error")
    exit()
# Paso 6) B->A: KAB(Apellido) en AES-CTR con HMAC
mensaje_BA = "Apellidos"
mensaje_BA = mensaje_BA.encode("utf-8")
aes_engine_BA = funciones_aes.iniciarAES_CTR(t_k1)
cifrado, cifrado_nonce = funciones_aes.cifrarAES_CTR(aes_engine_BA,mensaje_BA)
hash_engine_BA = HMAC.new(t_k2,digestmod=SHA256)
hash_engine_BA.update(mensaje_BA)
cifrado_hmac = hash_engine_BA.digest()
socket_Alice.enviar(cifrado)
socket_Alice.enviar(cifrado_hmac)
socket_Alice.enviar(cifrado_nonce)
# Termina la comunicacion
print("Cerrando Bob. El canal fue creado con exito")
socket_Alice.cerrar()
