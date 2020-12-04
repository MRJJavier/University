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

# Crea el socket servidor y escucha
print("Creando socket y escuchando...")
socket = SOCKET_SIMPLE_TCP('127.0.0.1', 5555)
socket.escuchar()

# A->T: Alice, Bob, Ra
datos = socket.recibir()
json_a_t = datos.decode("utf-8", "ignore")
print("A->T: " + json_a_t)
msg_a_t = json.loads(json_a_t)

# T: Guarda Alice, Bob, Ra ; Crea K_AB, Paso 2-1
t_alice, t_bob, t_random = msg_a_t
t_random = bytearray.fromhex(t_random)
key_a_b = get_random_bytes(16)

# T: msg_t_a = Ra, Bob, K_AB, E_BT(K_AB, Alice), Paso 2-2
msg_t_a = [t_random.hex(), t_bob, key_a_b.hex()]
msg_t_b = [key_a_b.hex(), t_alice]
json_t_b = json.dumps(msg_t_b)
aes_engine = funciones_aes.iniciarAES_GCM(KBT)
t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,json_t_b.encode("utf-8"))
msg_t_a.append(t_cifrado.hex())
msg_t_a.append(t_mac.hex())
msg_t_a.append(t_nonce.hex())

# T->A: E_AT(msg_t_a), Paso 2-3
json_t_a = json.dumps(msg_t_a)
aes_engine = funciones_aes.iniciarAES_GCM(KAT)
t_cifrado, t_mac, t_nonce = funciones_aes.cifrarAES_GCM(aes_engine,json_t_a.encode("utf-8"))

print("T->A (Clear): " + json_t_a)
socket.enviar(t_cifrado)
socket.enviar(t_mac)
socket.enviar(t_nonce)

# Terminamos nuestra tarea
socket.cerrar()
