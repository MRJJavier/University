"""
Codigo APENDICE A
"""
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
from Crypto.Signature import pss
from Crypto.Hash import SHA256

def crear_RSAKey():
    key = RSA.generate(2048)

    return key

def guardar_RSAKey_Privada(fichero, key, password):
    key_cifrada = key.export_key(passphrase=password, pkcs=8, protection="scryptAndAES128-CBC")
    file_out = open(fichero, "wb")
    file_out.write(key_cifrada)
    file_out.close()

def cargar_RSAKey_Privada(fichero, password):
    key_cifrada = open(fichero, "rb").read()
    key = RSA.import_key(key_cifrada, passphrase=password)

    return key

def guardar_RSAKey_Publica(fichero, key):
    key_pub = key.publickey().export_key()
    file_out = open(fichero, "wb")
    file_out.write(key_pub)
    file_out.close()

def cargar_RSAKey_Publica(fichero):
    keyFile = open(fichero, "rb").read()
    key_pub = RSA.import_key(keyFile)

    return key_pub

def cifrarRSA_OAEP(cadena, key):
    datos = cadena.encode("utf-8")
    engineRSACifrado = PKCS1_OAEP.new(key)
    cifrado = engineRSACifrado.encrypt(datos)

    return cifrado

def descifrarRSA_OAEP(cifrado, key):
    engineRSADescifrado = PKCS1_OAEP.new(key)
    datos = engineRSADescifrado.decrypt(cifrado)
    cadena = datos.decode("utf-8")

    return cadena

def firmarRSA_PSS(texto, key_private):
    h = SHA256.new(texto.encode("utf-8")) # Ya veremos los hash la semana que viene
    print(h.hexdigest())
    signature = pss.new(key_private).sign(h)

    return signature

def comprobarRSA_PSS(texto, firma, key_public):
    h = SHA256.new(texto.encode("utf-8")) # Ya veremos los hash la semana que viene
    print(h.hexdigest())
    verifier = pss.new(key_public)
    try:
        verifier.verify(h, firma)
        return True
    except (ValueError, TypeError):
        return False

def guardar_En_Fichero(fichero,texto):
    file_out = open(fichero, "wb")
    file_out.write(texto)
    file_out.close()

def cargar_De_Fichero(fichero):
    keyFile = open(fichero, "rb").read()
    return keyFile


#Ejercicio 1
path="/home/jj/Escritorio/Universidad/3ºCarrera/1ºCuatrimestre/SI/Practicas/P3/ApendiceA"
bobPriv=cargar_RSAKey_Privada(path+"bobpriv.txt","bobpriv")
alicePub=cargar_RSAKey_Publica(path+"alicepub.txt")
cifrado=cargar_De_Fichero(path+"alicecif.txt")
texto=descifrarRSA_OAEP(cifrado,bobPriv)
print(texto)
firmado=cargar_De_Fichero(path+"alicefir.txt")
esFirma=comprobarRSA_PSS(texto,firmado,alicePub)
print("¿Está firmado el texto? " + str(esFirma))
