from Crypto.Random import get_random_bytes
from Crypto.Cipher import DES, AES
from Crypto.Util.Padding import pad,unpad
from Crypto.Util import Counter
import base64

#Ejercicio 3
class AES_CIPHER_CBC:

    BLOCK_SIZE_AES = 16 # AES: Bloque de 128 bits
    
    def __init__(self, key):
        """Inicializa las variables locales"""
        self.key=key
        

    def cifrar(self, cadena, IV):
        """Cifra el parámetro cadena (de tipo String) con una IV específica, y devuelve el texto cifrado binario"""
        cipher = AES.new(self.key, AES.MODE_CBC,IV)
        return cipher.encrypt(pad(cadena.encode("utf-8"),type(self).BLOCK_SIZE_AES))

    def descifrar(self, cifrado, IV):
        """Descifra el parámetro cifrado (de tipo binario) con una IV específica, y devuelve la cadena en claro de tipo String"""
        
        descipher = AES.new(self.key, AES.MODE_CBC,IV)
        return unpad(descipher.decrypt(cifrado),type(self).BLOCK_SIZE_AES)

print("Ejercicio 3")
key = get_random_bytes(16) # Clave aleatoria de 128 bits
IV = get_random_bytes(16)  # IV aleatorio de 128 bits
datos = "Hola Mundo con AES en modo CBC"
d = AES_CIPHER_CBC(key)
cifrado = d.cifrar(datos, IV)
print(cifrado)
descifrado = d.descifrar(cifrado, IV)
print(descifrado)


############################
############################
############################

#Ejercicio 1
# Datos necesarios
print("Ejercicio 1")
key = get_random_bytes(16) # Clave aleatoria de 64 bits
IV = get_random_bytes(16)  # IV aleatorio de 64 bits para CBC
BLOCK_SIZE_AES = 16 # Bloque de 64 bits
data = "Hola amigos de la seguridad".encode("utf-8") # Datos a cifrar
data2 = "Hola amigas de la seguridad".encode("utf-8")
print(data)
print(data2)

# CIFRADO #######################################################################

# Creamos un mecanismo de cifrado AES en modo CBC con un vector de inicialización IV
cipher_aes = AES.new(key, AES.MODE_CBC, IV)

# Ciframos, haciendo que la variable "data” sea múltiplo del tamaño de bloque
ciphertext = cipher_aes.encrypt(pad(data,BLOCK_SIZE_AES))
ciphertext2 = cipher_aes.encrypt(pad(data2,BLOCK_SIZE_AES))
# Mostramos el cifrado por pantalla en modo binario y en modo base 64
print(ciphertext)
print(ciphertext2)
encoded_ciphertext = base64.b64encode(ciphertext)
print(encoded_ciphertext)
encoded_ciphertext2 = base64.b64encode(ciphertext2)
print(encoded_ciphertext2)

# DESCIFRADO #######################################################################

# Creamos un mecanismo de (des)cifrado AES en modo CBC con un vector de inicialización IV para CBC
# Ambos, cifrado y descifrado, se crean de la misma forma
decipher_aes = AES.new(key, AES.MODE_CBC, IV)

# Desciframos, eliminamos el padding, y recuperamos la cadena
new_data = unpad(decipher_aes.decrypt(ciphertext), BLOCK_SIZE_AES).decode("utf-8", "ignore")
new_data2 = unpad(decipher_aes.decrypt(ciphertext2), BLOCK_SIZE_AES).decode("utf-8", "ignore")

# Imprimimos los datos descifrados
print(new_data)
print(new_data2)

print("Ejercicio 2")
#Ejercicio2
half = BLOCK_SIZE_AES/2
NONCE=get_random_bytes(8)
NONCE2=get_random_bytes(BLOCK_SIZE_AES)
# CIFRADO #######################################################################
aes_cipher_ecb = AES.new(key,AES.MODE_ECB)
aes_cipher_ctr = AES.new(key,AES.MODE_CTR,nonce=NONCE)
aes_cipher_ofb = AES.new(key,AES.MODE_OFB,IV)
aes_cipher_cfb = AES.new(key,AES.MODE_CFB,IV)
aes_cipher_gcm = AES.new(key,AES.MODE_GCM,nonce=NONCE2,mac_len=16)


# DESCIFRADO #######################################################################
aes_decipher_ecb = AES.new(key, AES.MODE_ECB)
aes_decipher_ctr = AES.new(key, AES.MODE_CTR,nonce=NONCE)
aes_decipher_ofb = AES.new(key, AES.MODE_OFB,IV)
aes_decipher_cfb = AES.new(key, AES.MODE_CFB,IV)
aes_decipher_gcm = AES.new(key, AES.MODE_GCM,nonce=NONCE2,mac_len=16)

#DATA
print("ECB")
print(data)
ciphertext_ecb = aes_cipher_ecb.encrypt(pad(data,BLOCK_SIZE_AES))
print(ciphertext_ecb)
encoded_ciphertext_ecb = base64.b64encode(ciphertext_ecb)
print(encoded_ciphertext_ecb)
new_data_ecb = unpad(aes_decipher_ecb.decrypt(ciphertext_ecb), BLOCK_SIZE_AES).decode("utf-8", "ignore")
print(new_data_ecb)

print("\nCTR")
print(data)
ciphertext_ctr = aes_cipher_ctr.encrypt(pad(data,BLOCK_SIZE_AES))
print(ciphertext_ctr)
encoded_ciphertext_ctr = base64.b64encode(ciphertext_ctr)
print(encoded_ciphertext_ctr)
new_data_ctr = unpad(aes_decipher_ctr.decrypt(ciphertext_ctr), BLOCK_SIZE_AES).decode("utf-8", "ignore")
print(new_data_ctr)

print("\nOFB")
print(data)
ciphertext_ofb = aes_cipher_ofb.encrypt(pad(data,BLOCK_SIZE_AES))
print(ciphertext_ofb)
encoded_ciphertext_ofb = base64.b64encode(ciphertext_ofb)
print(encoded_ciphertext_ofb)
new_data_ofb = unpad(aes_decipher_ofb.decrypt(ciphertext_ofb), BLOCK_SIZE_AES).decode("utf-8", "ignore")
print(new_data_ofb)

print("\nCFB")
print(data)
ciphertext_cfb = aes_cipher_cfb.encrypt(pad(data,BLOCK_SIZE_AES))
print(ciphertext_cfb)
encoded_ciphertext_cfb = base64.b64encode(ciphertext_cfb)
print(encoded_ciphertext_cfb)
new_data_cfb = unpad(aes_decipher_cfb.decrypt(ciphertext_cfb), BLOCK_SIZE_AES).decode("utf-8", "ignore")
print(new_data_cfb)

print("\nGCM")
print(data)
ciphertext_gcm = aes_cipher_gcm.encrypt(pad(data,BLOCK_SIZE_AES))
print(ciphertext_gcm)
encoded_ciphertext_gcm = base64.b64encode(ciphertext_gcm)
print(encoded_ciphertext_gcm)
new_data_gcm = unpad(aes_decipher_gcm.decrypt(ciphertext_gcm), BLOCK_SIZE_AES).decode("utf-8", "ignore")
print(new_data_gcm)