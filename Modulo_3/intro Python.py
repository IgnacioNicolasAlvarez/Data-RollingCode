# -*- coding: utf-8 -*-
"""
Created on Sun Sep  6 18:45:59 2020

@author: yanin
"""

#----------------------------------------------------------------------------------
#
#                               INTRODUCCIÓN
#
#----------------------------------------------------------------------------------


#----------------------------------------------------------------------------------
#                                     SINTAXIS
#----------------------------------------------------------------------------------


print("Bienvenidos al curso de Python 3.8")




#----------------------------------------------------------------------------------
#                                     VARIABLES
#----------------------------------------------------------------------------------

# Python es un lenguaje no tipado. No requiere definir previamente la variable.

#Tipos, definiciones y asignaciones de variables

entero = 100
decimal = 1000.20
texto = "Yanina"

print(entero)
print(decimal)


a = b = c = 1
a,b,c = 1,2,"Yanina"



texto = "Recorte de texto" 
print(texto[2:5])

texto = "Recorte de texto"  + "y algo más"
print(texto)

type(texto)

# Fechas

from datetime import date, datetime, timedelta # Importo librería 
from dateutil import relativedelta
# importo el módulo dateutil, y crea referencia al objeto relativedelta 
# definido por ese módulo.
# relativedelta permite expresar otras unidades de tiempo adicionales a datetime



fecha = datetime(2019,12,29)                  # creación del objeto fecha
fecha_hoy = datetime.now() ; fecha_hoy        # creo un objeto de fecha con la fecha de hoy y la visualizo
fecha_hoy.strftime("%d/%m/%Y")                # Converito el formato de la fecha

fecha_pasadomañana = fecha_hoy + timedelta(days=2); fecha_pasadomañana     # Agrego dos días a la fecha
fecha_pasadomañana.strftime("%d/%m/%Y") # Cambio el formato de la fecha

string_a_fecha = datetime.strptime("2019-12-25", "%Y-%m-%d") # Convierto de string a fecha
string_a_fecha

diff_fecha = fecha_hoy - fecha_pasadomañana    # Calculo diferencia entre fechas
diff_fecha.days

relativedelta.relativedelta(fecha_pasadomañana, fecha_hoy).days     # Calculo diferencia entre fechas


fecha_hoy.day
fecha_hoy.month
fecha_hoy.year

# Conversión de tipos

int(10)
print(int("10") + 20)
str("Hola")
date(2020,9,9)

# Eliminar variable de la memoria

#del variable
del fecha_hoy


## @ DESAFÍO 1

'''
Si Florencia nació el  20/05/1980 y Claudio el día 06/08/1984.

1) Que edad tendrían al día de hoy
2) Cual es la diferencia de edad entre ellos 

Ayuda al final del script
    
'''


#----------------------------------------------------------------------------------
#                                 LISTAS Y DICCIONARIOS
#----------------------------------------------------------------------------------

lista = ['abcd', 150 , 54.12, 'María', 234.2 ]
print(lista)

# Sustraigo elementos de la lista
print(lista[1:3]) #recordar que arranca en el elemento 0

nueva_lista = lista[2:] #muestra desde el 2do lugar en adelante
print(nueva_lista)

# Concateno listas
print(lista[:2] + nueva_lista)

## funciones aplicadas a las listas

# Agrego un valor a la lista
lista.append(15) 
print(lista) 

# Agrego un valor a la lista en la posición 3
lista.insert(3, 15) 
print(lista) 

# Agrego una lista completa a la lista original
otra_lista = [100,20,30]
lista.extend(otra_lista)
print(lista)

# Elimino los elementos con valor 20 y 15 de la lista
lista.remove(20)
lista.remove(15)
print(lista)


# Cuenta la cantidad de elementos de la lista
len(lista)

# ordeno lista
otra_lista.sort()
otra_lista

# Anido listas
lista.append([1500,230, 432])
print(lista)
print(lista[3])
print(lista[3][1]) #del componente 3, me quedo con el 1er lugar después del 0


#Tuplas /Tuples -- No pueden ser actualizadas

# a diferencia de la lista, va con paréntesis y no tiene orden definido.
tupla =  ('abcd', 150 , 54.12, 'Lucas', 234.2)

print(tupla)
print(tupla[2])

# Diccionarios -- Secuencias de clave - valor -- {clave: valor}

dict = {}
dict['uno'] = "Valor 1"
dict[2]     = 2
dict[3] = "Valor 3"
dict['cuatro'] = 4

print(dict)

print(dict['uno'])          # Accedo por medio de la Key
print(dict[3])



print(dict.keys())
print(dict.values())

for elem in dict.keys():
    print(dict[elem])
    
list(dict.values())       # Convierto valores a lista
    


## @ DESAFÍO 2

'''

Con la lista de cotizaciones del precio de la acción de una Empresa 

1) Creá una lista con las 4 cotizaciónes más altas
2) Créa una lista con las 4 cotizaciones más bajas

'''

cotizaciones = { 
                '2018-03-22':131.45,
                '2018-03-21':133.4,
                '2018-03-20':130.6,
                '2018-03-19':127.5,
                '2018-03-16':132.25,
                '2018-03-15':132.3,
                '2018-03-14':131.9,
                '2018-03-13':132.25,
                '2018-03-12':135.55,
                '2018-03-09':129.7,
                '2018-03-08':125.15,
                '2018-03-07':125.55,
                '2018-03-06':127.8,
                '2018-03-05':124.05,
                '2018-03-02':122.95,
                '2018-03-01':123.7,
                '2018-02-28':129.1,
                '2018-02-27':126.8,
                '2018-02-26':129.05,
                '2018-02-23':130.75,
                '2018-02-22':134
                }

max_cotizaciones_4 = sorted(cotizaciones.items(), key=lambda x: x[1])[-4:]

min_cotizaciones_4 = sorted(cotizaciones.items(), key=lambda x: x[1])[:4]
