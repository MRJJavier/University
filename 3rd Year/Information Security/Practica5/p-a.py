from Crypto.Hash import SHA256, HMAC
import base64
import json
import sys
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes
from Crypto.Random import get_random_bytes

def Paso1(emisor, receptor, ra):
    """ Cifra el mensaje del paso 1, y devuelve el cifrado """
    # Codifica el contenido (los campos binarios en una cadena) y contruyo el mensaje JSON
    msg_TE = []
    msg_TE.append(emisor)
    msg_TE.append(receptor)
    msg_TE.append(ra.hex())
    json_ET = json.dumps(msg_TE)
    print(emisor + "->" + receptor + " (descifrado): " + json_ET)

    return json_ET.encode("utf-8")

def Paso3(receptor, emisor, KAT, t_cifrado, t_mac, t_nonce):
    """ Descifra el mensaje del paso 2, y devuelve los campos"""
    # Descifro los datos con AES GCM
    datos_descifrado_AT = funciones_aes.descifrarAES_GCM(KAT, t_nonce, t_cifrado, t_mac)

    # Decodifica el contenido: K1, K2, Nb
    json_AT = datos_descifrado_AT.decode("utf-8" ,"ignore")
    print(emisor + "->" + receptor +" (descifrado): " + json_AT)
    msg_AT = json.loads(json_AT)
    t_ra,t_receptor,KAB,tb_cifrado,tb_mac,tb_nonce = msg_AT
    KAB = bytearray.fromhex(KAB)
    tb_cifrado = bytearray.fromhex(tb_cifrado)
    tb_mac = bytearray.fromhex(tb_mac)
    tb_nonce = bytearray.fromhex(tb_nonce)
    return t_ra,t_receptor,KAB,tb_cifrado,tb_mac,tb_nonce

def Paso5(receptor, emisor, KAB, t_cifrado, t_mac, t_nonce):
    """ Descifra el mensaje del paso 2, y devuelve los campos"""
    # Descifro los datos con AES GCM
    t_rb = funciones_aes.descifrarAES_GCM(KAB, t_nonce, t_cifrado, t_mac)
    print(emisor + "->" + receptor +" (descifrado): " + t_rb.hex())
    # Decodifica el contenido: K1, K2, Nb

    t_rb = int.from_bytes(t_rb,"big") - 1
    t_rb = (t_rb).to_bytes(16,"big")
    
    aes_engine = funciones_aes.iniciarAES_GCM(KAB)
    ab_cifrado,ab_mac,ab_nonce = funciones_aes.cifrarAES_GCM(aes_engine,t_rb)

    return ab_cifrado,ab_mac,ab_nonce

# Lee clave KAT
KAT = open("KAT.bin", "rb").read()

# Crear el socket de conexion con T (5550)
print("Creando conexion con T...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5550)
socket.conectar()

# Paso 1) 
ra = get_random_bytes(16)
mensaje = Paso1("Alice", "bob", ra)
socket.enviar(mensaje)

# Paso 3) 
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
socket.cerrar()
t_ra,t_receptor,KAB,tb_cifrado,tb_mac,tb_nonce = Paso3("Alice", "Bob", KAT, cifrado, cifrado_mac, cifrado_nonce)
t_ra = bytearray.fromhex(t_ra)
# Compara que el nonce sea el mismo en el origen y la respuesta
if (ra != t_ra):
    print("El nonce es incorrecto")
    sys.exit()

# Conexion con Bob
print("Conectandose con Bob...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket.conectar()
socket.enviar(tb_cifrado)
socket.enviar(tb_mac)
socket.enviar(tb_nonce)

# Paso 5)
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
ab_cifrado,ab_mac,ab_nonce = Paso5("Alice","Bob",KAB,cifrado,cifrado_mac,cifrado_nonce)
socket.enviar(ab_cifrado)
socket.enviar(ab_mac)
socket.enviar(ab_nonce)

# Termina la comunicacion
socket.cerrar()
print("Cerrando A correctamente")