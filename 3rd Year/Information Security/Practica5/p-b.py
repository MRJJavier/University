from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

def Paso4(receptor,KBT, tb_cifrado,tb_mac,tb_nonce,rb):
    """ Cifra el mensaje del paso 1, y devuelve el cifrado """
    # Codifica el contenido (los campos binarios en una cadena) y contruyo el mensaje JSON
   
    json_BT = funciones_aes.descifrarAES_GCM(KBT, tb_nonce, tb_cifrado, tb_mac)
    json_BT = json_BT.decode("utf-8","ignore")
    msg_TB = json.loads(json_BT)
    emisor,KAB = msg_TB
    KAB = bytearray.fromhex(KAB)
    print(emisor + "->" + receptor + " (descifrado): " + json_BT)

    # Cifra los datos con AES GCM
    aes_engine = funciones_aes.iniciarAES_GCM(KAB)
    t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,rb)

    return KAB,t_cifrado, t_mac, t_nonce

def Paso6(KAB,t_cifrado,t_mac,t_nonce):
    t_rb = funciones_aes.descifrarAES_GCM(KAB,t_nonce,t_cifrado,t_mac)
    t_rb = int.from_bytes(t_rb,"big") + 1
    t_rb = (t_rb).to_bytes(16,"big")
    return t_rb

# Lee clave KBT
KBT = open("KBT.bin", "rb").read()

# Espero a Alice para el paso 4)
# Crear el socket de escucha de Alice (5550)
print("Esperando a Alice...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket.escuchar()
# Paso 4)
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
rb = get_random_bytes(16)
KAB,t_ab_cifrado,t_ab_cifrado_mac,t_ab_cifrado_nonce = Paso4("Bob",KBT, cifrado,cifrado_mac,cifrado_nonce,rb)
socket.enviar(t_ab_cifrado)
socket.enviar(t_ab_cifrado_mac)
socket.enviar(t_ab_cifrado_nonce)

# Paso 6)
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
# Termina la comunicacion
socket.cerrar()
t_rb = Paso6(KAB,cifrado,cifrado_mac,cifrado_nonce)

if(rb!=t_rb):
    print("El nonce es incorrecto")
    sys.exit()

print("Cerrando B correctamente")
