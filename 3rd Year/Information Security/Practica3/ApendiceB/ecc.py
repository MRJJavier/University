"""
Codigo APENDICE B
"""
from Crypto.PublicKey import ECC
from Crypto.Hash import SHA256
from Crypto.Signature import DSS

# Ver https://pycryptodome.readthedocs.io/en/latest/src/public_key/ecc.html
# Ver https://pycryptodome.readthedocs.io/en/latest/src/signature/dsa.html

def crear_ECCKey():
    # Use 'NIST P-256'
    key= ECC.generate(curve='P-256')
    return key

def guardar_ECCKey_Privada(fichero, key, password):
    # ...
    key_cifrada = key.export_key(format='DER',passphrase=password, use_pkcs8=True, protection="scryptAndAES128-CBC")
    file_out = open(fichero, "wb")
    file_out.write(key_cifrada)
    file_out.close()

def cargar_ECCKey_Privada(fichero, password):
    # ...
    key_cifrada = open(fichero, "rb").read()
    key = ECC.import_key(key_cifrada, passphrase=password)

    return key

def guardar_ECCKey_Publica(fichero, key):
    # ...
    key_pub = key.public_key().export_key(format='DER')
    file_out = open(fichero, "wb")
    file_out.write(key_pub)
    file_out.close()

def cargar_ECCKey_Publica(fichero):
# ...
    keyFile = open(fichero, "rb").read()
    key_pub = ECC.import_key(keyFile)

    return key_pub

# def cifrarECC_OAEP(cadena, key):
# El cifrado con ECC (ECIES) aun no está implementado
# Por lo tanto, no se puede implementar este método aun en la versión 3.9.0
    #return cifrado

# def descifrarECC_OAEP(cifrado, key):
# El cifrado con ECC (ECIES) aun no está implementado
    # Por lo tanto, no se puede implementar este método aun en la versión 3.9.0
    #return cadena

def firmarECC_PSS(texto, key_private):
    # ...
    h = SHA256.new(texto.encode("utf-8")) # Ya veremos los hash la semana que viene
    print(h.hexdigest())
    signer = DSS.new(key_private,'fips-186-3')
    signature =signer.sign(h)

    return signature

def comprobarECC_PSS(texto, firma, key_public):
    # ...
    h = SHA256.new(texto.encode("utf-8")) # Ya veremos los hash la semana que viene
    print(h.hexdigest())
    verifier = DSS.new(key_public,'fips-186-3')
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

print("Ejercicio 2")
path="/home/jj/Escritorio/Universidad/3ºCarrera/1ºCuatrimestre/SI/Practicas/P3/ApendiceB"
print("Claves Alice")
aliceKey=crear_ECCKey()
guardar_ECCKey_Privada(path+"alicepriv.txt",aliceKey,"alicepriv")
guardar_ECCKey_Publica(path+"alicepub.txt",aliceKey.public_key())
print("Claves Bob")
bobKey=crear_ECCKey()
guardar_ECCKey_Privada(path+"bobpriv.txt",bobKey,"bobpriv")
guardar_ECCKey_Publica(path+"bobpub.txt",bobKey.public_key())