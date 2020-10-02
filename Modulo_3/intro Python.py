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

variable = 10
print(variable)
del variable
print(variable)

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

print(dict[4])

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



#----------------------------------------------------------------------------------
#                             SENTENCIAS BÁSICAS
#----------------------------------------------------------------------------------
    
# While 

count = 0
while (count < 9):
   print('Contador: ', count)
   count = count + 1

# qué pasa si agregamos ELSE? 
   

count = 0
while count < 10:
   print(count, " es menor que 10")
   count = count + 1
else:
   print(count, " no es menor que 10") # sin el else llega hasta el 9no


    
# If

if 10>3:
    print("Verdadero")
else:
    print("Falso")

if 10>15:
    print("Verdadero")
elif 10>5:
    print("Verdadero")    
else:
    print("Falso") # recordar elif funciona como "or" con varias condiciones


# For
    
for x in [10, 20, 30, "Calle", "Arbusto", [1,2,3]]:
    print(x)
    
for x in range(1, 10, 2):  # rango de 1 a 10, pero de a 2 unidades. (1,3,5,7,9)
    for y in range(1, 10, 2):
        print(x*y)

for x in range(1, 10, 4):
    for y in range(1, 10, 4):
        if x*y > 20:
            break # sin el else, el bucle se detiene aquí
        else: 
            print(x*y)
        
for x in range(1, 10, 4):
    for y in range(1, 10, 4):
        if x*y >20:
            print(x*y) 
        else:
            pass # indica que no haga nada, y que pase a la siguiente instrucción
    
listas_anidadas = [ [1, 2, 3], [4, 5, 6], [7, 8, 9]]
for list in listas_anidadas:
    print(list)
    for x in list:
        print(x)    
        
#----------------------------------------------------------------------------------
#                                 FUNCIONES
#----------------------------------------------------------------------------------

''' Sintaxis

def nombre( parametros ):
   expresion = 'sintaxis de la función'
   return [expresion]
   
'''

# Funciones sin argumentos
def fx():
    print("Esto es una función")

fx()


# Funciones con argumentos
def f_args(arg1, arg2):
    print(str(arg1), str(arg2))
    return # el return es opcional

f_args("Yanina", "Juan")


# Funciones con argumentos y loops
def f_notas(alumno, notas):
    print("Notas de " + alumno) # 1er paso para generar un título
    for item in notas.keys():
        print(item + ": " + str(notas[item])) # 2do paso para asignar calificación

notas = {"Economia": 8, "Matematica": 9, "Finanzas": 10, "Otra Materia": 10}
alumno = "Yanina"

f_notas(alumno, notas)


# Función lambda 
arg=1; arg2=2
sum = lambda arg1, arg2: arg1 + arg2; # lambda es una fución anónima, cuya entrada es hasta :
sum(10,20)

# alternativamente ...
total = 0;
def suma( arg1, arg2 ):
   total = arg1 + arg2;
   print("Dentro de la funcion: ", total)

suma(10,20)   


def suma_return( arg1, arg2 ):
   total = arg1 + arg2;
   return total

suma_return(10,20) 



## @ DESAFÍO 3

'''

1) Obtener una lista que contenga la suma acumulada de los siguientes números: 10, 15, 25, 45, 3, 1, 7
2) Cuantos números primos hay en el rango comprendido entre 1150 y 2580

Un número es primo si tiene exactamente dos divisores: el 1 y él mismo (pista: el número 2 es el primer nro primo).    
# int() sirve convertir en número entero, "integer".

'''



#----------------------------------------------------------------------------------
#
#                               NUMPY
#
#----------------------------------------------------------------------------------

# pip install numpy

import numpy as np

# Numpy es una biblioteca para Python que facilita el trabajo con arrays (vectores y matrices),
# https://docs.scipy.org/doc/numpy-1.13.0/reference/routines.math.html

np.arange(0.0, 1.0, 0.1) # silimar al range que utilizamos anteriormente, pero para arrays
x = np.arange(0.0, 1.0, 0.1) # de otra forma ...
        
np.arange(15).reshape(3, 5) # le agregamos la opción del número de filas/columnas.

array = np.array([0.5,1.5,3,3.4,5.3,4.5,76,2.5,2,5.1])

np.zeros((3,4)) # matriz de zeros

np.ones((3,4)) # matiz de unos

np.random.random((2,3)) # matriz con números aleatorios

np.ones((3,4)) * 2; np.ones((3,4)) - 1

np.ones((3,4)) + np.ones((3,4))

np.ones((3,4)) + np.ones((3,4)) * 2

np.sum(array)
np.sum(array, dtype=np.int32) # describe el tipo de dato, en este caso un número entero de 4bytes

np.prod([[1.,2.],[3.,4.]])
np.cumsum(np.array([[1,2,3], [4,5,6]]))

 
#----------------------------------------------------------------------------------
#
#                               SERIES Y DATAFRAMES
#
#----------------------------------------------------------------------------------

# pip install pandas

import pandas as pd

# http://pandas.pydata.org/pandas-docs/stable/

# Python Data Analysis Library (alias Pandas). La biblioteca Pandas provee estructuras 
# de datos, genera gráficos de alta calidad con matplotlib y se integra de buena forma
# con otras bibliotecas que usan arrays de NumPy. Permite trabajar de manera fácil y eficiente
# con dataframes y series de datos.

#----------------------------------------------------------------------------------
#                        DATASETS y LECTURA DE DATOS
#----------------------------------------------------------------------------------

# Guardo en variables los data sets a utilizar

dataset_glp  = "http://datos.minem.gob.ar/dataset/63ab43cc-7055-4969-87d3-6a969f1d5386/resource/e0853d15-124c-423a-bc1b-dca18e5a9449/download/ventas-de-comercializadores-de-glp.csv"
dataset_personas = "https://infra.datos.gob.ar/catalog/otros/dataset/2/distribution/2.21/download/nombres-2015.csv"
dataset_propiedades = "https://storage.googleapis.com/properati-data-public/uy_properties.csv.gz"


# Definición del dataframe
def create_dataframe(dataset):
    df = pd.read_csv(dataset, index_col=False)
    return df

def create_serie(dataset, index):
    df = pd.read_csv(dataset, index_col=False)
    s = df[df.columns[index]]
    return s

df = create_dataframe(dataset)

#----------------------------------------------------------------------------------
#                                     SERIES
#----------------------------------------------------------------------------------


# Creación y definición de series

''' Sintaxis

s = pd.Series(data)

'''

s = pd.Series(np.random.randn(20))                                              # Serie de números aleatorios
s = pd.Series(np.random.randn(5), index=['a', 'b', 'c', 'd', 'e'])              # Cambio el índice de la serie


# Conversión de tipos

s = pd.Series(np.random.randn(20), dtype="float"); s
s.astype("int")


# Evaluación

s = create_serie(dataset_glp, 11) # 11vo es el lugar de la columna de la tabla, que elegimos.

s.describe()
s.values
s.shape[0] # recordsar que el 0 es la 1era columna de la serie.
s.isnull()
s.name = "precio"
s.name

s = pd.Series(['a', 'a', 'b','b', 'b', 'c'])
s.describe()

s = create_serie(dataset_glp, 11)


# Selección

s[0]
s[0:10]
s[s>2300]
s[(s>2300) & (s<4000)]
s[s>s.mean(axis=0)] # ejes sobre los que reliza el cálculo
s.mean()

# Funciones 

s.abs() # devuelve los componentes en valor absoluto.
s.all() # para verificar si todos los elementos son distintos a cero.
s[s>0][0:3].append(s[s>0][4:10]).reset_index() # reseteamos el inidce porque es como quitar algunas filas con el iltro anterior.


s.add(10)     # sumo 10 a cada fila de la serie
s.divide(10)  
s.multiply(5)
s.pow(2)

s.max()
s.min()
s.mean()
s.median()
s.sum()
s.quantile(0.5)
s.sample(100)
s.var()

def potencia_2(x):
    return x**2   # similar a pow()

s.apply(potencia_2) # usamos apply para aplicar una fución cuando trabajamos con series.

def restar_valor(x, valor):
    return x-valor

s.apply(restar_valor, args=(5,))


# Conversiones de series

s.drop_duplicates().reset_index()
s.dropna().reset_index()
s.equals(s)
s.sort_index()
s.sort_values()
s.take([10,20]) #[indices]
s.between(10000, 20000, inclusive=True)

pd.Series(pd.date_range('2017-01-01', periods=10))
pd.Series(5, index=pd.date_range('2017-01-01', periods=10))

# Convierto a datadrame y lista

s.to_frame()
s.tolist() 

# Exporto a CSV
s.to_csv("path", sep=";")


## @ DESAFÍO 4

'''

1) Cuantas veces se pagó el precio máximo
2) Cual es la diferencia porcentual entre el precio máximo y el promedio
3) Armar una lista con los deciles de precios
    
'''

min_price = s.min()
x = s[s==s.min()].reset_index()
x.describe()
x.shape[0]

 


#----------------------------------------------------------------------------------
#                                  DATAFRAMES
#----------------------------------------------------------------------------------

# Crear dataset

df = create_dataframe(dataset_personas)[0:10000] # qué pasa si no corto el df?

# Evaluación

df.describe()
df.axes         
df.values
df.shape
df.size

# Selección

df[df.cantidad >= 2100]
df[df["cantidad"] >= 2100]

df.loc[0,'nombre']                       # [indice, atributo] - Selección por etiqueta
df.loc[1:10, ['cantidad', 'nombre']]


df.loc[:,]
df.loc[0:10,'nombre':'anio']
df.loc[0:10,['nombre','cantidad','anio']] # de otra forma ...


df.loc[df.cantidad > 1000,'nombre':'anio']      # [condicion, atributos]
df.loc[df.loc[:,'cantidad'] > 1000, 'cantidad']
df.loc[df.nombre == 'Emma','nombre':'anio']

df.iloc[:,2]        # [indice, atributo] - Selección por indice de columna -- abreviación de localización de enteros.
df.iloc[0:4,]

# Query

df.query("nombre == 'Benjamin'")
df.query("cantidad >= 1000")
df.query("cantidad >= 1000 and nombre == 'Benjamin'")

srch_nombres= ['Emma', 'Thiago ']
df.query('@srch_nombres in nombre') # "decorador": símbolo usado para para llamar a variables dentro de dataframe query de pandas.


srch_nombres= ['Emma', 'Thiago']
srch_cantidad=1500
df.query('@srch_nombres in nombre and cantidad > @srch_cantidad')

df.query('cantidad > @srch_cantidad').nombre
df.query('cantidad > @srch_cantidad').nombre + str("_altos")

df.nombre.str.contains('Ben*') # nombres que comienzan con "Ben"
df[df['nombre'].str.contains('Ben*')] # (***)


# Asignación

df['flag'] = ''
df['Ben_True'] = False
df = df.iloc[:,[0,1,2,4]]

# utiliazmos la sentencia (***)
df.loc[df['nombre'].str.contains('Ben*'),'Ben_True'] = True # Completamos el flag "Ben_True" (selección-variable)

df['cant_true'] = False

df.loc[df.cantidad > df.cantidad.mean(), 'cant_true'] = True


# Creación de dataframe a aprtir de filtros

df['cant_true'] = False
df['cond_auto'] = False
df.loc[df.cantidad > 2500,['cant_true']] = True
df.loc[df.cantidad > 1500,['cond_auto']] = True


nombres_y = pd.DataFrame(df.loc[(df.cant_true) & (df.cond_auto), 'nombre']); 
nombres_o = df.loc[(df.cant_true) | (df.cond_auto), 'nombre'];
nombres_v = df.loc[((df.cant_true) | (df.cond_auto)) & (df.cantidad > 2000), 'nombre']; 

df = create_dataframe(dataset_personas)[0:10000]


# Encontrar valores cercanos

aValue = 1900
df.loc[(df.cantidad-aValue).abs().argsort()] # hace la diferencia absoluta y luego ordena de menor a mayor por default
df_prox = pd.DataFrame(df.loc[(df.cantidad-aValue).abs().argsort()].to_records()) # pd.DataFrame.to_records() para reordenar el df (reset_index)
df_prox["cantidad"][0]


# Group By y Tablas dinamicas

df = create_dataframe(dataset_propiedades)

df.axes
df.head()
df = df.fillna(value=0)


df.price.describe()
df.price.describe().map('{:,.2f}'.format) # especificamos 2 dígitos de precisión y f representa el número decimal (float point number)


df.groupby('property_type', as_index=False).mean() # probar qué pasa con index True.
df.groupby(['property_type','rooms'], as_index=False).mean()
df.groupby(['property_type','rooms'], as_index=False)['price'].mean()
df.groupby(['operation_type','property_type'], as_index=False)['price'].mean()


# otra forma de agrupar, ordenar y calcular datos en con la función pivot de pandas.
# para la opearción que realizamos sobre x columna, utilizamos la librería numpy.
# DataFrame.pivot_table(values=None, index=None, columns=None, aggfunc='mean', fill_value=None, margins=False, dropna=True)

pd.pivot_table(df, index=['operation_type'], columns= ['property_type'], values = 'price', aggfunc=np.mean)
pd.pivot_table(df, index=['operation_type'], columns=['property_type'], values='price', aggfunc=np.mean).fillna(value=0)
pd.pivot_table(df, index=['operation_type'], columns=['property_type','rooms'], values='price', aggfunc=np.mean).fillna(value=0)
pd.pivot_table(df, index=['operation_type'], columns=['rooms'], values='price', aggfunc=[np.max, np.mean]).fillna(value=0)

# exporto mi df a csv
df.to_csv("C:\\Users\\yanin\\Desktop\\props.csv", sep=";", decimal=",")

df_ejem_0= df[df['price']< df['price'].quantile(0.99)]
df_ejem = df[(df['price']< df['price'].quantile(0.99)) & (df['price'] > df['price'].quantile(0.01))] 
(df.size-df_ejem.size)/df.size


# Concatenado y unificación
# creamos un df a partir de un diccionario de listas: {nombre_lista : contenido de lista[]}

df1 = pd.DataFrame({'A': ['A0', 'A1', 'A2', 'A3'],'B': ['B0', 'B1', 'B2', 'B3'],'C': ['C0', 'C1', 'C2', 'C3'],'D': ['D0', 'D1', 'D2', 'D3']},index=[0, 1, 2, 3])
df2 = pd.DataFrame({'A': ['A4', 'A5', 'A6', 'A7'],'B': ['B4', 'B5', 'B6', 'B7'],'C': ['C4', 'C5', 'C6', 'C7'],'D': ['D4', 'D5', 'D6', 'D7']},index=[4, 5, 6, 7])
df3 = pd.DataFrame({'A': ['A8', 'A9', 'A10', 'A11'],'B': ['B8', 'B9', 'B10', 'B11'],'C': ['C8', 'C9', 'C10', 'C11'],'D': ['D8', 'D9', 'D10', 'D11']},index=[8, 9, 10, 11])

df1.append(df2) # una forma de unir

frames = [df1, df2, df3] # de otra forma, creando una lista primero, luego concateno.
result = pd.concat(frames)
result2 = pd.concat([df1,df2,df3]) # de otra forma...


df2 = pd.DataFrame({'E': ['E1', 'E2', 'E3', 'E4'],'F': ['F1', 'F2', 'F3', 'F4'],'G': ['G1', 'G2', 'G3', 'G4'],'H': ['H1', 'H2', 'H3', 'H4']},index=[0, 1, 2, 3])
frames = [df1, df2]
pd.concat(frames, axis=1) # axis=1 para que la concatenación se haga sobre el eje horizontal/columnas


# Otras funciones

df.apply(pd.to_numeric, errors='ignore') # coerción para datos no numéricos y con apply lo hace columna a columna, ignorando en los casos que no se pueda convertir (nan).
df.rename(columns={'price': 'precio'}, inplace=True)
df.axes


## @ DESAFÍO 5

'''

Del siguiente dataset https://data.cityofchicago.org/api/views/tt4n-kn4t/rows.csv?accessType=DOWNLOAD&bom=true&query=select+*
          
    - Obetner el departamento que en promedio resulta el mejor y peor pago
    - Obetner el empleo mejor y peor pago  
    - Obetner el departamento con mayor número de empleados  
    - ¿En qué área conviene trabajar?¿Que evaluarías? 
 
'''   


#----------------------------------------------------------------------------------
#
#                               MATPLOTLIB
#
#----------------------------------------------------------------------------------

# pip install matplotlib

import matplotlib.pyplot as plt

# https://matplotlib.org/devdocs/


# Histograma

df_ejem['price'].describe()
plt.hist(df_ejem.price)
plt.hist(df_ejem.price, bins='auto')
plt.hist(df_ejem.price, bins='auto', range=[2500,5000])


# Gráfico de lineas

t = np.arange(len(df_ejem.price))                 # Valores eje X
s = df_ejem.price.sort_values(ascending=True)     # Valores eje Y
plt.plot(t, s)

plt.xlabel('Etiqueta eje X')
plt.ylabel('Etiqueta eje Y')
plt.title('Titulo')
plt.grid(False)
plt.show()


# Gráficos de barras

x = df.groupby('property_type', as_index=False)['price'].mean()
ejex = df.groupby('property_type', as_index=False)['price'].mean().property_type.tolist()
ejey = df.groupby('property_type', as_index=False)['price'].mean().price.tolist()

y_pos = np.arange(len(ejex))
 
plt.bar(y_pos, ejey, align='center')
plt.xticks(y_pos, ejex) # reemplaza ua etiqueta por otra
plt.xlabel('Tipos')
plt.ylabel('Precio')
plt.title('Propiedades')
plt.show()


plt.barh(y_pos, ejey, align='center')
plt.yticks(y_pos, ejex)
plt.ylabel('Tipos')
plt.xlabel('Precio')
plt.title('Propiedades')
plt.show()






#----------------------------------------------------------------------------------
#
#                     AYUDA A DESAFÍOS
#
#----------------------------------------------------------------------------------


## @ DESAFÍO 1
    
from datetime import date 
from dateutil import relativedelta

hoy = datetime.now()
florencia = datetime(1980,5,20)
claudio = datetime(1984,8,6)

(hoy - claudio).years
dif_hoy = hoy - claudio
dif_hoy.days/365

(claudio - florencia).days
dif_edad = relativedelta.relativedelta(claudio, florencia).years


## @ DESAFÍO 2

cotizaciones.values()
cotizaciones = list(cotizaciones.values())
cotizaciones.sort()
cotizaciones

inicio = len(cotizaciones)-4
fin =  len(cotizaciones)
cotizaciones[inicio:fin]

cotizaciones[0:4]


## @ DESAFÍO 3

def cum_sum(lista):
    suma=0
    lista_acum = []
    for num in lista:
        suma = suma + num
        lista_acum.append(suma)
    return lista_acum

cum_sum([10, 15, 25, 45, 3, 1, 7])




def num_primo(numero):    
    validador = 1
    
    if (numero == 2): 
        validador = 1
    else:    
        for num in range(2,numero,1):
            division = numero / num
            entero_division = int(division) 
            if (division - entero_division) > 0:
                validador = 1
            else:
                validador = 0
                break
    return validador


num_primo(17)


contar = 0
x = range(1150,2581,1)
for nums_validar in x:
    if (num_primo(nums_validar))==1:
        contar = contar + 1
    print(contar)

        

## @ DESAFÍO 4
        
s = create_serie(dataset_glp, 11)
max_price = s.max()
s[s==s.max()]

mean_price = s.mean()

(max_price / mean_price) * 100

deciles =  []
for i in np.arange(0.1, 1.1, 0.1):
    deciles.append(s.quantile(i))
    
    
## @ DESAFÍO 5
    
url = "https://data.cityofchicago.org/api/views/tt4n-kn4t/rows.csv?accessType=DOWNLOAD&bom=true&query=select+*"
df= pd.read_csv(url, index_col=False)
df.rename(columns={'Department': 'departamento', 'Annual Salary': 'salario', 'Hourly Rate': 'salario_Hora'}, inplace=True)
df['salario'] = df['salario'].fillna(0)

df.reindex()
for i in range(0,len(df)):
    if type(df.loc[i,'salario']) == str:
        df.loc[i,'salario'] = float(df.loc[i,'salario'][1:])
    else:
        pass
    
df['salario'] = df['salario'].astype("float")
df.groupby("departamento").mean()
    