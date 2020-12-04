from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes

def Paso2(t_emisor,t_receptor,t_ra,KAT,KBT,KAB):
    """ Descifra el mensaje del paso 1/3, y devuelve los campos"""
    # Descifro los datos con AES GCM
    msg_TB = []
    msg_TB.append(t_emisor)
    msg_TB.append(KAB.hex())
    json_BT = json.dumps(msg_TB)

    aes_engine_bob = funciones_aes.iniciarAES_GCM(KBT)
    tb_cifrado, tb_mac, tb_nonce = funciones_aes.cifrarAES_GCM(aes_engine_bob,json_BT.encode("utf-8"))

    msg_TA = []
    msg_TA.append(t_ra.hex())
    msg_TA.append(t_receptor)
    msg_TA.append(KAB.hex())
    msg_TA.append(tb_cifrado.hex())
    msg_TA.append(tb_mac.hex())
    msg_TA.append(tb_nonce.hex())
    json_AT = json.dumps(msg_TA)

    aes_engine_alice = funciones_aes.iniciarAES_GCM(KAT)
    ta_cifrado, ta_mac, ta_nonce = funciones_aes.cifrarAES_GCM(aes_engine_alice,json_AT.encode("utf-8"))

    return ta_cifrado, ta_mac, ta_nonce


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

# Crear el socket de escucha de Alice (5550)
print("Esperando a Alice...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5550)
socket.escuchar()

# Paso 2) 
mensaje = socket.recibir()
KAB =funciones_aes.crear_AESKey()
t_emisor, t_receptor, t_ra = json.loads(mensaje.decode("utf-8","ignore"))
t_ra = bytearray.fromhex(t_ra)
ta_cifrado, ta_mac, ta_nonce = Paso2(t_emisor,t_receptor,t_ra,KAT,KBT,KAB)
socket.enviar(ta_cifrado)
socket.enviar(ta_mac)
socket.enviar(ta_nonce)

# T termina su trabajo :-)
socket.cerrar()

print("Cerrando T correctamente")
