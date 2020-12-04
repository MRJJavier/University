# Aqui teneis la practica con un estilo distinto a las practicas que se han ido entregando hasta ahora (sin usar funciones)
# ...Pero podeis ver que el protocolo lo implementa igualmente :-)

# OJO! Para sistemas criptográficos, habría que utilizar un generador de numeros aleatorios criptograficos
# Ver https://docs.python.org/3.9/library/secrets.html#module-secrets

from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from Crypto.Random import get_random_bytes
import base64
import json
from socket_class import SOCKET_SIMPLE_TCP
import funciones_aes

# Lee clave KBT
KBT = open("KBT.bin", "rb").read()

# Crea el socket servidor y escucha
print("Creando socket y escuchando...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 6666)
socket.escuchar()

# A->B: E_BT(K_AB, Alice)
t_cifrado = socket.recibir()
t_mac = socket.recibir()
t_nonce = socket.recibir()
json_a_b = funciones_aes.descifrarAES_GCM(KBT, t_nonce, t_cifrado, t_mac).decode("utf-8" ,"ignore")
print("A->B (Clear): " + json_a_b)
msg_a_b = json.loads(json_a_b)

# B: Guarda K_AB, Alice; crea Rb aleatorio (Un int de 16 bytes (128 bits))
# En python 3, el tipo int no tiene límite de tamaño
# Ver https://www.python.org/dev/peps/pep-0237/ y https://docs.python.org/3/library/functions.html#int
KAB, a_alice = msg_a_b
KAB = bytearray.fromhex(KAB)
# Voy a considerar que el "numero" está en big endian (lo que se utiliza en los sistemas de red)
b_random = get_random_bytes(16)
b_random_num = int.from_bytes(b_random, byteorder='big')

# B->A: E_BA(Rb)
aes_engine = funciones_aes.iniciarAES_GCM(KAB)
t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,b_random)
print("B->A (Clear): {} ({})".format(b_random, b_random_num)) # Una forma nueva (python 3.X) de imprimir valores 
socket.enviar(t_cifrado)
socket.enviar(t_mac)
socket.enviar(t_nonce)

# A->B: E_BA(Rb-1)
t_cifrado = socket.recibir()
t_mac = socket.recibir()
t_nonce = socket.recibir()
b_random_1 = funciones_aes.descifrarAES_GCM(KAB, t_nonce, t_cifrado, t_mac)
b_random_1_num = int.from_bytes(b_random_1, byteorder='big')
print("A->B (Clear): {} ({})".format(b_random_1, b_random_1_num)) # Una forma nueva (python 3.X) de imprimir valores 

# Comprobar
if (b_random_1_num + 1) == (b_random_num):
    print("Canal seguro establecido")
    # Enviar nombre
    nombre = "Yo soy Bob"
    aes_engine = funciones_aes.iniciarAES_GCM(KAB)
    t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,nombre.encode("utf-8"))
    print("B->A (Clear): " + nombre)
    socket.enviar(t_cifrado)
    socket.enviar(t_mac)
    socket.enviar(t_nonce)
    # Recibir nombre
    t_cifrado = socket.recibir()
    t_mac = socket.recibir()
    t_nonce = socket.recibir()
    nombre = funciones_aes.descifrarAES_GCM(KAB, t_nonce, t_cifrado, t_mac).decode("utf-8" ,"ignore")
    print("A->B (Clear): " + nombre)
    # Fin de las comunicaciones
    socket.cerrar()
else:
    print("ERROR en el challenge response")
    socket.cerrar()
