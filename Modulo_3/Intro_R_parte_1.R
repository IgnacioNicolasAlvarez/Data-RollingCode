###############################################################################################
###############################################################################################
###############################################################################################

                             ### MANIPULACIÓN DE DATOS EN R ###

###############################################################################################
###############################################################################################
###############################################################################################


## Empezamos por fijar el directorio de trabajo (wd):

getwd() # Chequeo el Working directory

setwd("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python") #fijo el directorio donde voy a trabajar

dir.create('Clase R') # Creo una carpeta con el nombre "Clase R"

#setwd("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/Clase R") #vuelvo a fijar el directorio

dir() # Veo arhivos en el wd


## Definicion de Workspace

# El Workspace es el espacio en donde estamos trabajando. Cualquier objeto (vectores, matrices, data.frames)
# que se vayan creando, quedaran guardados aqui.
# Cuando cerramos el programa, este nos pregunta si queremos guardar una "Imagen" del Workspace. Si le damos
# aceptar, entonces se crearan dos archivos: un .RData y un .Rhistory. El primero, contiene todos los objetos
# creados y, el segundo, todos los comandos corridos durante la ultima sesion.

ls() # Veo todos los objetos creados que se encuentran vigentes dentro del workspace


###################################
###### Tipos de OBJETOS en R ######
###################################

#Tipos de datos er R:

# numeric / integer
# character
# logical (True / False)


# Los princpales objetos son:

# vectores
# factores
# listas
# data.frames
# matrices


# Cada uno de los anteriores objetos pueden tener atributos, que nos 
# permiten describir el objeto. Algunos ejemplos pueden ser:

# names, dimnames
# dimensiones (matrices, arrays, data.frames)
# class (ej. numeric, integers)
# length
# otros

## numeric / integer 
x <- 1 
y <- 4

# Especial numbers -> Inf, -Inf, NaN (Not a Number)
x / 0 # Inf
-1 / 0 # -Inf
0 / 0 # NaN
log(-1) # NaN

## character
x <- 'Hola'

## logical
x <- T #aqui la T va sin comillas y corresponde a TRUE (verdadero)
x == T 



###################################################
##################### VECTORES ####################
###################################################

##### VECTORES (R opera componente a componente) #####

vector = c(1,2,3,4,5,6) # con c() concatenamos compnentes
vector

length(vector) # para saber el tamaño del vector 

2*vector + 1

vector^2

log(vector)

exp(vector)

#vector con caracter o texto:
dias = c('lunes', 'martes', 'miercoles', 'jueves', 'viernes')
dias

2*dias + 1 # Que va a ocurrir?

### Algunas funciones con vectores utiles:

rep('R',3)  # Repetir elemento una cantidad arbitraria de veces.

rep(0,7) # Repetir un número una cantidad arbitraria de veces.

seq(1,10) # Genero una secuencia que va comienza en 1 y termina en 10, de 1 a 1 por default.

1:10 # Tambien se puede lograr de esta manera ":"

seq(0,1, by = 0.1)  # Genero una secuencia que va comienza en 1 y termina en 10, de 10% o 0.1.

### INDICES -> Acceder a los elementos de un vector '[]'

vector
vector[3] #buscamos el 3er lugar. El índice es el 3 que esta dentro de los corchetes
vector[-3] #buscamos todos los componentes, excepto el 3ero.
vector[c(1,2)] #me traigo los dos primeros elementos.

### >>> ejercicio: probar con vector de 5 nombres cualesquiera.


### Operaciones entre vectores:

x <- runif(100) #función para generar números aleatorios decimales.
y <- runif(100, min=0, max=2)

x / y
x * y 
x - y
x + y

x <- sample(100) #función para generar números aleatorios enteros.
y <- sample(1:200, 100 , replace = F)

x / y
x * y 
x - y
x + y


### Podemos forzar el tipo de datos/objetos -> as.character(), as.integer(), as.numeric(), as.factor()

x <- (1:10)
x <- as.character(1:10) # puedo volver texto a un número entero.
x
x <- as.integer(x)
x
x <- as.integer('hola') # error, no puedo volver número entero a un texto.


### Valores Faltantes -> is.na() ; is.nan()

x <- rep(c(5:10,NA,NaN), 2)

is.na(x) # devuelve un vector logico T or F (incluye NaN)

is.nan(x) # devuelve un vector logico T or F (incluye NaN)

# ¿ Cuantos NA or NaN hay ?
sum(is.na(x)) #4
sum(is.nan(x)) #2

### distrubuciones

rnorm(5,mean=0,sd=1)
?rnorm
rexp(5, rate = 2)


# histograma dstribución normal
hist(rnorm(100,mean=0,sd=1))

hist(rnorm(100,mean=0,sd=1), main='Histograma')


###################################################
##################### FACTORES ####################
###################################################

# Los factores, que pueden ser ordenados o no ordenados, 
#se utilizan para representar variables categóricas.

x <- c('Mujer', 'Hombre', 'Mujer')
x <- factor(x) #observar en Environment cómo cambia la variable.
x 
as.numeric(x) # si transformamos en número (continua representando niveles)


# Ej: 1 = Mujer ; 2 = Hombre
x <- sample(1:2, 100, replace = T)
x <- factor(x)

# definimos etiquetas
x <- factor(x, levels = c('1','2'), labels = c('Mujer', 'Hombre'))
x


###################################################
##################### MATRICES ####################
###################################################

matriz <- matrix(vector,ncol=2) #transpone de acuerdo a la cantidad de columnas.
matriz

2*matriz + 1  #operamos elemento a elemento dentro de la matriz.


# operaciones entre matrices:

A <- matrix(1:9,ncol=3)
A
B <- matrix(1:9, ncol=3, byrow = T) #particiona la secuencia sin transponer.
B

dim(A)
dim(B) # chequeo la dimensión de mi matriz.

# ¿podrías escribir A y B de otra forma?
#A <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3)

A%*%c(1,0,1) #operador de producto de dos matrices. Recordar el tamaño en este caso 3x3*3x1

A*B #lo hace vector columna a vector columna
A%*%B # producto matricial

# concatenar elementos
rbind(A,B) # 6x3 #lo hace acopland filas (rows)
cbind(A,B) # 3x6 #lo hace acoplando columnas (columns)

# Acceder a los elementos de una matriz '[filas,columnas]'
A[1,1]     # el elemento de la posición 1,1.
A[1:2,2:3] # los elementos de las posición 1 a 2, 2 a 3.


###################################################
##################### LISTAS ######################
###################################################

# A diferencia de los vectores o matrices, las listas pueden contener elementos de distinto tipo.

lista <- list(x = c('M','F','M'), y = 1:100)
lista

# seleccionamos dentro de la lista:

lista[1] # -> lista
lista[[1]] # Utilizamos el doble corchete [[]] para acceder al contenido concreto de una lista.
lista[[1]][2] # accedemos al segundo elemento del primer componente de la lista.



########################################################
##################### DATA.FRAMES ######################
########################################################

# Los data frame se usan para almacenar datos en forma de tablas (filas / columnas), como vimos en SQL
# Los data frame pueden almacenar objetos/datos de distinto tipo: numéricos, carácter,etc
# a diferencia de las matrices donde todos los elementos tenían que ser enteros o numéricos.

# creamos un data.frame

cp <- c('A001', 'A002', 'F087' , 'A006')
edad <- c(26,35,21,43)
altura <- c(1.76,1.65,1.78,1.98)
datos <- data.frame(cp,edad,altura)
datos
str(datos) #revisamos la estructura del df

summary(datos)

plot(datos) # este gráfico de dispersión no nos muestra una correlación posible!

plot(datos$altura,datos$edad, xlab = 'altura', ylab = 'edad', main = 'Ejemplo Dispersión', col = 'blue')


## Ejercicios:

# (1) Genera un vector con 7 nombres de tus compañeros, y otro vector con el género de los mismos.

# (2) Chequear cuántas hombres y cuántas mujeres hay 

# (3) Cuál es el nombre y género de el 2do y del último compañero en tus vectores?

# (4) Crear un data frame que contenga como primer variable genero y luego el nombre de cada persona.

# (5) Revisar la estructura del df.¿Qué otra variable de utilidad agregaría rápidamente? 


## Vemos un ejemplo con una base de R:

data(mtcars) #cargo el data.frame mtcars 
mtcars
View(mtcars)

## Estructura general

# General
str(mtcars) 

# Dimension
dim(mtcars) 

nrow(mtcars) #número de filas (row)
ncol(mtcars) #número de columnas

# tipo de objeto
class(mtcars)

# Nombre de variables/atributos/campos
names(mtcars)
 
# mpg = millas por galón 
# cyl = cilindros 
# disp = Mide el volumen del motor y representa el poder que genera el motor 
# hp = caballos de fuerza 
# drat = relación de eje trasero
# wt = peso (1000 lbs) 
# qsec = 1/4 milla de tiempo (Tiempo que se demora el carro en recorrer 1/4 de milla) 
# vs = motor(0= en forma de V , 1= recto) 
# am = Trasmisión (0=automático, 1=manual) 
# gear = número de engranajes de la trasmisión 
# carb = número de carburadores


## Seleccionar partes del data.frame

# Filas
head(mtcars, n = 10) # primeras 10 filas

tail(mtcars, n = 10) # ultimas 10 filas

mtcars[1, ] # primera fila 
mtcars['Mazda RX4',]  # primera fila

mtcars[c(1,10), ] # fila 1 y 10
mtcars[c(10,1),] # fila 1 y 10


# Columnas
mtcars[,'mpg'] # columna "mpg" del df

mtcars$mpg # columna "mpg" de otra forma

mtcars[,c('mpg','hp')] # si quiero consultar más de una columna o variable del df


## Summary 
summary(mtcars) # hace el resumen variable por variable del df.


## Expresiones condicionales -> ifelse()

mtcars$nueva <- ifelse(mtcars$mpg > 30, 1, 0) # prueba condiciones y devuelve un valor de acuerdo a si el argumento es T or F

mtcars$hp_v2 <- ifelse(mtcars$hp == 110, 1, 0) # cuando condicionamos con el "=", debe ser doble "=".

mtcars$prueba <- ifelse(mtcars$mpg > 30, NA, ifelse(mtcars$cyl == 6, -1, mtcars$mpg))


## funcion Sapply para contar la cantidad de nulos por columna

# primero generamos una función que suma todos los nulos
nulos <- function(x) {
  
  y <- sum(is.na(x))
  
  return(y)
}

sapply(X = mtcars, FUN = nulos) # invocamos la función sappy.

# si quiero eliminar los nulos de una variable en particular:
mtcars <- mtcars[!is.na(mtcars$mpg),]

# si quiero eliminar todas las filas nulas (de todas las variables)
mtcars <- na.omit(mtcars)


## ORDENAMIENTO

# Ordeno por la variable mpg -> order()

mtcars$mpg

# orderno 
a <- mtcars$mpg[order(mtcars$mpg)] 
a
sort(mtcars$mpg) # ordeno de otra manera, mismo resultado.


# orderno el data.frame
mtcars <- mtcars[order(mtcars$cyl, decreasing = T),] # de forma decreciente con dos variables. La 1era es la que manda en el orden.


## FILTRADO

# Filtro los autos que tengan un hp > 100
filtro_1 <- mtcars$hp > 100

mtcars[filtro_1,]

# Filtro los autos que tengan un hp > 100 y cyl == 6
filtro_2 <- mtcars$hp > 100 & mtcars$cyl == 6

mtcars[filtro_2,]

# Filtro los autos que tengan un (hp > 100 y cyl == 6) o que cyl == 4
filtro_3 <- (mtcars$hp > 100 & mtcars$cyl == 6) | mtcars$cyl == 4

mtcars[filtro_3,]


## IMPORTAR Y EXPORTAR ARCHIVOS A R Y DESDE R: -> read.table() ; read.csv() / write.table() ; write.csv()

data(mtcars)

write.table(x = mtcars, file = 'mtcars.txt', row.names = T, sep = '\t') # escribo un txt

write.csv(x = mtcars, file = 'mtcars.csv', row.names = T) # escribo un csv


rm(mtcars)

mtcars <- read.table(file = 'mtcars.txt', header = T, sep = '\t', stringsAsFactors = F)


# stringsAsFactors = FALSE se fija para prevenir que las variables character sean convertidas a factores,
# al tener un df con variabRFles numéricas y caracter.


## Ejercicios:

# (1) Con el df de mtcars, ¿podrías decir cuál es la mediana de la variable HP?

# (2) Crear un nuevo df, tomando las tres últimas variables de mtcars.

# (3) Con el último df creado, filtrar la variable carb > 2 o bien la variable am = 0.

# (4) Generar un nuevo df, tomando los ultimos 5 autos, y todas las variables/campos.

# (5) Exportar el último df creado.




### JOINS:

# generamos dos vectores, uno para los nombres de las provincias y otro para la distribución de prob. de ellas.

distribucion_prov <- c(0.386,0.082,0.082,0.072,0.043,0.039,0.031,0.030,0.027,0.026,0.025,0.022,0.017,0.017,0.016,0.014,0.013,0.013,0.011,0.009,0.008,0.008,0.007,0.002)

tx_provincia <- c('Provincia de Buenos Aires','Córdoba','Santa Fe','CABA','Mendoza','TucumÁn','Entre Ríos','Salta','Misiones','Chaco','Corrientes','Santiago del Estero','San Juan','Jujuy','Río Negro','Neuquén','Formosa','Chubut', 'San Luis','Catamarca','La Rioja', 'La Pampa','Santa Cruz')


## Generamos un df para los clientes:

set.seed(123)

clientes <- data.frame(id = 1:10000, edad = floor(rnorm(1000, 30,5)), provincia = sample(1:24, 10000, replace = T, prob = distribucion_prov))

clientes$edad <- ifelse(clientes$edad < 18, 18, clientes$edad) # corrijo la edad para tomar mayores únicamente.


## Generamos un df para las provincias:

provincias <- data.frame(id = 1:23, tx_provincia)


## Busco los nombres de las provincias en al tabla prov -> merge()

# Inner Join

clientes2 <- merge(x = clientes, y = provincias, by.x = 'provincia', by.y = 'id', all = F)

table(clientes2$tx_provincia)

barplot(height = table(clientes2$tx_provincia), cex.axis = 0.5, las = 2)
# height: Vector o matriz de valores que describen las barras.
# cex.name = tamaño de etiqueta eje x.
# las=2 ubica las etiquetas perpendicular al eje x.


# Left Join

clientes2 <- merge(x = clientes, y = provincias, by.x = 'provincia', by.y = 'id', all.x = T)

table(clientes2$tx_provincia) 

barplot(height = table(clientes2$tx_provincia), cex.names = 0.5, las = 2)

# Right Join

clientes2 <- merge(x = clientes, y = provincias, by.x = 'provincia', by.y = 'id', all.y = T)

table(clientes2$tx_provincia, useNA = 'ifany') ; barplot(height = table(clientes2$tx_provincia, useNA = 'ifany'), cex.names = 0.5, las = 2)


## Agrego la provincia que falta -> rbind()

provincias <- rbind(provincias, data.frame(id = 24, tx_provincia = 'Tierra del Fuego'))
provincias


clientes2 <- merge(x = clientes, y = provincias, by.x = 'provincia', by.y = 'id', all = F)

table(clientes2$tx_provincia)

barplot(height = table(clientes2$tx_provincia), cex.names = 0.5, las = 2)

## Agrego un atributo mas a la tabla clientes, ej. deuda -> cbind()

clientes2 <- cbind(clientes2, data.frame(deuda = rnorm(10000,1500, 100)))

head(clientes2)


## Ejercicios:

# (1) Acotar el df de provincias, con el fin de tener sólo 19 de ellas.

provincias_acotado_19 <- data.frame(provincias[1:19])

# (2) Consultar un inner join y un left join con este nuevo df. Comparar la cantidad de casos respecto al ejemplo original.

clientes_inner <- merge(x = clientes, y = provincias_acotado_19, by.x = 'provincia', by.y = 'id', all.x = T)
clientes2_left <- merge(x = clientes, y = provincias_acotado_19, by.x = 'provincia', by.y = 'id')

# (3) Agregar una nueva columna de "Canitdad de Habitantes" que surjan de una distribución normal o la que prefiera.

provincias_acotado_19_con_hab <- cbind(provincias_acotado_19, data.frame(cant_hab = rnorm(19, 100000, 100)))


### Plots basicos: -> plot() ; hist() ; boxplot()

# Linea

plot(x = mtcars$mpg, type = 'l', main = 'MPG', xlab = '', ylab = 'MPG')
text(x = 1:32, y = mtcars$mpg, labels = row.names(mtcars), las = 2) # agregamos los nombres de los autos

# Dispersión

plot(x = mtcars$hp, y = mtcars$mpg, main = 'MPG vs HP', xlab = 'HP', ylab = 'MPG', col='red')

# Histograma

hist(x = mtcars$mpg, breaks = 6, main = 'Histograma de MPG', xlab = 'MPG')

# Boxplots

boxplot(mpg ~ cyl, data = mtcars, main = 'Boxplot MPG por CYL', xlab = 'CYL', ylab = 'MPG')


