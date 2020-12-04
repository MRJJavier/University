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

# Lee clave KAT
KAT = open("KAT.bin", "rb").read()

# Abre una conexion a T
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5555)
socket.conectar()

# A: Crear campos, Paso 1-1
a_alice = "Alice"
a_bob = "Bob"
a_random = get_random_bytes(8)

# A: msg_a_t = Alice, Bob, Ra
msg_a_t = ["Alice", "Bob", a_random.hex()]
json_a_t = json.dumps(msg_a_t)

# A->T: msg_a_t, Paso 1-2
print("A->T: " + json_a_t)
socket.enviar(json_a_t.encode("utf-8"))

# T->A: E_AT(Ra, Bob, K_AB, E_BT(K_AB, Alice))
# A: Descifrar msg_t_a
t_cifrado = socket.recibir()
t_mac = socket.recibir()
t_nonce = socket.recibir()
json_t_a = funciones_aes.descifrarAES_GCM(KAT, t_nonce, t_cifrado, t_mac).decode("utf-8" ,"ignore")
print("T->A (Clear): " + json_t_a)
msg_t_a = json.loads(json_t_a)

# A: Comprobar campos de msg_t_a
t_random, t_bob, KAB, t_cifrado, t_mac, t_nonce = msg_t_a
t_random = bytearray.fromhex(t_random)
KAB = bytearray.fromhex(KAB)
if a_random != t_random:
    print("ERROR: Nonce Equivocado")
    socket.cerrar()
    exit()
if a_bob != t_bob:
    print("ERROR: Receptor incorrecto")
    socket.cerrar()
    exit()

# Hemos terminado con la conexion con T, podemos cerrar el socket
socket.cerrar()

# Ahora conectamos con Bob
print("Conecto a Bob")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 6666)
socket.conectar()

# Paso 3
socket.enviar(bytearray.fromhex(t_cifrado))
socket.enviar(bytearray.fromhex(t_mac))
socket.enviar(bytearray.fromhex(t_nonce))
print("A->B: Mensaje Cifrado")

# Paso 4
t_cifrado = socket.recibir()
t_mac = socket.recibir()
t_nonce = socket.recibir()
b_random = funciones_aes.descifrarAES_GCM(KAB, t_nonce, t_cifrado, t_mac)
b_random_num = int.from_bytes(b_random, byteorder='big')
print("B->A (Clear): {} ({})".format(b_random, b_random_num)) # Una forma nueva (python 3.X) de imprimir valores 

b_random_1_num = b_random_num - 1
b_random_1 = b_random_1_num.to_bytes(16, byteorder='big')

aes_engine = funciones_aes.iniciarAES_GCM(KAB)
t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,b_random_1)
print("A->B (Clear): {} ({})".format(b_random_1, b_random_1_num)) # Una forma nueva (python 3.X) de imprimir valores 
socket.enviar(t_cifrado)
socket.enviar(t_mac)
socket.enviar(t_nonce)

# Canal seguro
# Recibir nombre
t_cifrado = socket.recibir()
t_mac = socket.recibir()
t_nonce = socket.recibir()
nombre = funciones_aes.descifrarAES_GCM(KAB, t_nonce, t_cifrado, t_mac).decode("utf-8" ,"ignore")
print("B->A (Clear): " + nombre)
# Enviar nombre
nombre = "Yo soy Alice"
aes_engine = funciones_aes.iniciarAES_GCM(KAB)
t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,nombre.encode("utf-8"))
print("A->B (Clear): " + nombre)
socket.enviar(t_cifrado)
socket.enviar(t_mac)
socket.enviar(t_nonce)

# Fin de las comunicaciones
socket.cerrar()