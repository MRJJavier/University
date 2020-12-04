""" José Javier Morente Risco 3ºA """
#Funcion de cifrado CESAR
def cifradoCesarAlfabetoInglesMAY(cadena):
    # Definir la nueva cadena resultado
    resultado = ''
    # Realizar el "cifrado", sabiendo que A = 65, Z = 90, a = 97, z = 122
    i = 0
    while i < len(cadena):
        # Recoge el caracter a cifrar
        ordenClaro = ord(cadena[i])
        ordenCifrado = 32
        # Cambia el caracter a cifrar
        if (ordenClaro >= 65 and ordenClaro <= 90):
            ordenCifrado = (((ordenClaro - 65) + clave) % 26) + 65
        if(ordenClaro >= 97 and ordenClaro <= 122):
            ordenCifrado = (((ordenClaro - 97) + clave) % 26) + 97
        # Añade el caracter cifrado al resultado
        resultado = resultado + chr(ordenCifrado)
        i = i + 1
    # devuelve el resultado
    return resultado

#Funcion de descifrado CESAR
def descifradoCesarAlfabetoInglesMAY(cadena):
    # Definir la nueva cadena resultado
    resultado = ''
    # Realizar el "cifrado", sabiendo que A = 65, Z = 90, a = 97, z = 122
    i = 0
    while i < len(cadena):
        # Recoge el caracter a cifrar
        ordenClaro = ord(cadena[i])
        ordenCifrado = 32
        # Cambia el caracter a cifrar
        if (ordenClaro >= 65 and ordenClaro <= 90):
            ordenCifrado = (((ordenClaro - 65) - clave) % 26) + 65
        if(ordenClaro >= 97 and ordenClaro <= 122):
            ordenCifrado = (((ordenClaro - 97) - clave) % 26) + 97
        # Añade el caracter cifrado al resultado
        resultado = resultado + chr(ordenCifrado)
        i = i + 1
    # devuelve el resultado
    return resultado

#Pantalla CESAR
print("Cifrado CESAR")
#claroCESARMAY es el mensaje a cifrar
claroCESARMAY = 'VENI VIDI VINCI AURIA veni vidi vinci auria'
#clave es el código del cifrado
clave = 3
if (clave > 26 and clave > 0):
     clave = clave % 26
print(claroCESARMAY)
cifradoCESARMAY = cifradoCesarAlfabetoInglesMAY(claroCESARMAY)
print(cifradoCESARMAY)
descifradoCESARMAY = descifradoCesarAlfabetoInglesMAY(cifradoCESARMAY)
print(descifradoCESARMAY)
print()

#Funcion de cifrado MonoAlfabeto
def cifradoMonoAlfabetoInglesMAY(cadena,claveSecreta):
    # Definir la nueva cadena resultado
    resultado = ''
    # Realizar el "cifrado", sabiendo que A = 65, Z = 90, a = 97, z = 122
    i = 0
    j = 0
    while i < len(cadena):
        # Recoge el caracter a cifrar
        ordenClaro = ord(cadena[i])
        if j >= len(claveSecreta):
            j = j % len(claveSecreta)
        ordenClaveSecreta = ord(claveSecreta[j])
        ordenCSecreta = 0
        if(ordenClaveSecreta >= 65 and ordenClaveSecreta <= 90):
            ordenCSecreta = ordenClaveSecreta - 64
        if(ordenClaveSecreta >= 97 and ordenClaveSecreta <= 122):
            ordenCSecreta = ordenClaveSecreta - 96
        ordenCifrado = 32
        # Cambia el caracter a cifrar
        if (ordenClaro >= 65 and ordenClaro <= 90):
            ordenCifrado = (((ordenClaro - 65) + ordenCSecreta) % 26) + 65
        if(ordenClaro >= 97 and ordenClaro <= 122):
            ordenCifrado = (((ordenClaro - 97) + ordenCSecreta) % 26) + 97
        # Añade el caracter cifrado al resultado
        resultado = resultado + chr(ordenCifrado)
        i = i + 1
        if(ordenClaro != 32):
            j = j + 1
    # devuelve el resultado
    return resultado

#Funcion de descifrado MonoAlfabeto
def descifradoMonoAlfabetoInglesMAY(cadena,claveSecreta):
    # Definir la nueva cadena resultado
    resultado = ''
    # Realizar el "cifrado", sabiendo que A = 65, Z = 90, a = 97, z = 122
    i = 0
    j = 0
    while i < len(cadena):
        # Recoge el caracter a cifrar
        ordenClaro = ord(cadena[i])
        if j >= len(claveSecreta):
            j = j % len(claveSecreta)
        ordenClaveSecreta = ord(claveSecreta[j])
        ordenCSecreta = 0
        if(ordenClaveSecreta >= 65 and ordenClaveSecreta <= 90):
            ordenCSecreta = ordenClaveSecreta - 64
        if(ordenClaveSecreta >= 97 and ordenClaveSecreta <= 122):
            ordenCSecreta = ordenClaveSecreta - 96
        
        ordenCifrado = 32
        # Cambia el caracter a cifrar
        if (ordenClaro >= 65 and ordenClaro <= 90):
            ordenCifrado = (((ordenClaro - 65) - ordenCSecreta) % 26) + 65
        if(ordenClaro >= 97 and ordenClaro <= 122):
            ordenCifrado = (((ordenClaro - 97) - ordenCSecreta) % 26) + 97
        # Añade el caracter cifrado al resultado
        resultado = resultado + chr(ordenCifrado)
        i = i + 1
        if(ordenClaro != 32):
            j = j + 1
    # devuelve el resultado
    return resultado

#Pantalla MonoAlfabeto
print("Cifrado MONOALFABETICO")
claroMONOALFABETOMAY = 'HolA aMigOS'
cifradoClaveSecreta = 'CiFrA'
print(claroMONOALFABETOMAY)
print(cifradoClaveSecreta)
cifradoMONOALFABETOMAY = cifradoMonoAlfabetoInglesMAY(claroMONOALFABETOMAY,cifradoClaveSecreta)
print(cifradoMONOALFABETOMAY)
descifradoMONOALFABETOMAY = descifradoMonoAlfabetoInglesMAY(cifradoMONOALFABETOMAY,cifradoClaveSecreta)
print(descifradoMONOALFABETOMAY)
print()