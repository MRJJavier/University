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

def descifraPasos1y3(emisor, KET, t_cifrado, t_mac, t_nonce):
    """ Descifra el mensaje del paso 1/3, y devuelve los campos"""
    # Descifro los datos con AES GCM
    datos_descifrado_ET = funciones_aes.descifrarAES_GCM(KET, t_nonce, t_cifrado, t_mac)

    # Decodifica el contenido: Alice, Na
    json_ET = datos_descifrado_ET.decode("utf-8" ,"ignore")
    print(emisor + "->T (descifrado): " + json_ET)
    msg_ET = json.loads(json_ET)

    # Extraigo el contenido, y lo devuelvo
    t_KA, t_KB, t_ne = msg_ET
    t_KA = bytearray.fromhex(t_KA)
    t_KB = bytearray.fromhex(t_KB)
    t_ne = bytearray.fromhex(t_ne)
    return t_KA, t_KB, t_ne

def cifraCTR(K1, K2, text):
    """ Cifra el mensaje del paso 1, y devuelve el cifrado """

    aes_engine = funciones_aes.iniciarAES_CTR(K1)
    t_cifrado, nonce = funciones_aes.cifrarAES_CTR(aes_engine,text.encode("utf-8"))

    h = HMAC.new(K2, text.encode("utf-8"), digestmod=SHA256)
    HMAC_M = h.hexdigest()

    # Codifica el contenido (los campos binarios en una cadena) y contruyo el mensaje JSON
    msg_TE = []
    msg_TE.append( t_cifrado.hex() )
    msg_TE.append( nonce.hex() )
    msg_TE.append( HMAC_M )
    json_ET = json.dumps(msg_TE)

    # Cifra los datos con AES GCM

    return json_ET.encode("utf-8")

def descifraPasos5(cifrado, K1, K2):
    
    msg_ET = json.loads(cifrado.decode("utf-8","ignore"))
    ciphertext, nonce, HMAC_k2 = msg_ET

    text = funciones_aes.descifrarAES_CTR( K1, bytes.fromhex(nonce), bytes.fromhex(ciphertext) )
    h = HMAC.new(K2, text, digestmod=SHA256)
    HMAC_M = h.hexdigest()
    if (HMAC_k2 == HMAC_M):
        return text
    else:
        return "Error"

# Lee clave KBT
KBT = open("KBT.bin", "rb").read()

# Crear el socket de conexion con T (5551)
print("Creando conexion con T...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5551)
socket.conectar()

# Paso 1) B->T: KAT(Alice, Na) en AES-GCM
t_n = get_random_bytes(16)
cifrado, cifrado_mac, cifrado_nonce = cifraPaso1("B", "T", KBT, "Bob", t_n)
socket.enviar(cifrado)
socket.enviar(cifrado_mac)
socket.enviar(cifrado_nonce)

# Paso 2) T->B: KBT(K1, K2, Nb) en AES-GCM
# A empezar a resolver!!!!!!!
cifrado = socket.recibir()
cifrado_mac = socket.recibir()
cifrado_nonce = socket.recibir()
t_KA, t_KB, t_ne = descifraPasos1y3("B", KBT, cifrado, cifrado_mac, cifrado_nonce)

if(t_ne != t_n):
    raise ValueError("Los nonces son distintos")

# Espero a Alice para el paso 5)
print("Esperando a Alice...")
socket= SOCKET_SIMPLE_TCP('127.0.0.1', 5552)
socket.escuchar()

# Paso 5) A->B: KAB(Nombre) en AES-CTR con HMAC
cifradoJSon = socket.recibir()
texto = descifraPasos5(cifradoJSon,t_KA,t_KB)
print(texto)
# Paso 6) B->A: KAB(Apellido) en AES-CTR con HMAC
socket.enviar(cifraCTR(t_KA,t_KB,"Apellido"))
# Termina la comunicacion
socket.cerrar()
