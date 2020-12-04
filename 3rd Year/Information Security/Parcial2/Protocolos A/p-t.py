from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes

def descifraPasos1y3(emisor, KET, t_cifrado, t_mac, t_nonce):
    """ Descifra el mensaje del paso 1/3, y devuelve los campos"""
    # Descifro los datos con AES GCM
    datos_descifrado_ET = funciones_aes.descifrarAES_GCM(KET, t_nonce, t_cifrado, t_mac)

    # Decodifica el contenido: Alice, Na
    json_ET = datos_descifrado_ET.decode("utf-8" ,"ignore")
    print(emisor + "->T (descifrado): " + json_ET)
    msg_ET = json.loads(json_ET)

    # Extraigo el contenido, y lo devuelvo
    t_emisor, t_ne = msg_ET
    t_ne = bytearray.fromhex(t_ne)
    return t_emisor, t_ne

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

# Crear el socket de escucha de Bob (5551)
print("Esperando a Bob...")
socket_Bob = SOCKET_SIMPLE_TCP('127.0.0.1', 5551)
socket_Bob.escuchar()

# Crea la respuesta para B y A: K1 y K2
K1 = funciones_aes.crear_AESKey()
K2 = funciones_aes.crear_AESKey()

# Paso 1) B->T: KBT(Bob, Nb) en AES-GCM
cifrado = socket_Bob.recibir()
cifrado_mac = socket_Bob.recibir()
cifrado_nonce = socket_Bob.recibir()
datos_descifrado_BT = funciones_aes.descifrarAES_GCM(KBT,cifrado_nonce,cifrado,cifrado_mac)
json_BT = datos_descifrado_BT.decode("utf-8","ignore")
msg_BT = json.loads(json_BT)
t_emisor, t_nb = msg_BT
t_nb = bytearray.fromhex(t_nb)

# Paso 2) T->B: KBT(K1, K2, Nb) en AES-GCM
# A empezar a resolver!!!!!!!
aes_engine_TB = funciones_aes.iniciarAES_GCM(KBT)
msg_TB = [K1.hex(),K2.hex(),t_nb.hex()]
json_TB = json.dumps(msg_TB)
cifrado, cifrado_mac, cifrado_nonce = funciones_aes.cifrarAES_GCM(aes_engine_TB,json_TB.encode("utf-8"))
socket_Bob.enviar(cifrado)
socket_Bob.enviar(cifrado_mac)
socket_Bob.enviar(cifrado_nonce)
socket_Bob.cerrar()
# Crear el socket de escucha de Alice (5550)
print("Esperando a Alice...")
socket_Alice = SOCKET_SIMPLE_TCP('127.0.0.1', 5550)
socket_Alice.escuchar()
# Paso 3) A->T: KAT(Alice, Na) en AES-GCM
cifrado = socket_Alice.recibir()
cifrado_mac = socket_Alice.recibir()
cifrado_nonce = socket_Alice.recibir()
datos_descifrado_AT = funciones_aes.descifrarAES_GCM(KAT,cifrado_nonce,cifrado,cifrado_mac)
json_AT = datos_descifrado_AT.decode("utf-8","ignore")
msg_AT = json.loads(json_AT)
t_emisor, t_na = msg_AT
t_na = bytearray.fromhex(t_na)
# Paso 4) T->A: KAT(K1, K2, Na) en AES-GCM
aes_engine_TA = funciones_aes.iniciarAES_GCM(KAT)
msg_TA = [K1.hex(),K2.hex(),t_na.hex()]
json_TA = json.dumps(msg_TA)
cifrado, cifrado_mac, cifrado_nonce = funciones_aes.cifrarAES_GCM(aes_engine_TA,json_TA.encode("utf-8"))
socket_Alice.enviar(cifrado)
socket_Alice.enviar(cifrado_mac)
socket_Alice.enviar(cifrado_nonce)
socket_Alice.cerrar()
# T termina su trabajo :-)
print("Trent ha terminado su trabajo :)")
