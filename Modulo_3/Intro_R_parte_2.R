############################################################################################################
############################################################################################################
############################################################################################################

                               ### EXPLORACIÓN Y LIMPIEZA DE DATOS ###

############################################################################################################
############################################################################################################
############################################################################################################

# Chequeo dónde estoy ubicad@
getwd()
setwd("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python")


# vamos a utlizar un dataset del Gobierno de la Ciudad de Buenos Aires >>> Sistema Único de Atención Ciudadana (SUACI)
# https://data.buenosaires.gob.ar


df <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_suaci_barrios.csv", na ="NA")

# de otra forma...
#df <- read.csv('AAAAAA.csv', sep=',',header= T, dec='.',na.strings = "NA")

# Me fijo si la importación fue como DATAFRAME, su dimensión y una vista general

class(df)

dim(df)

head(df,20)

# Reviso la estructura de las variables de mi df

str(df)

# Para tener estadística descriptiva de las variables de mi df (se puede hacer atributo x atributo)

summary(df)

summary(df$total)

# Para conocer los diferentes niveles de una variable categórica:

levels(df$RUBRO) # cuando la variable es un factor.

table(df$RUBRO)  # para resto de las variables y con su # correspondiente.

# >>> ejercicio >>> Probar con el resto de variables...

#############################################################################################################
                                       #### JOINS ENTRE TABLAS ####
#############################################################################################################

#install.packages("tidyverse")

# invoco librerías a utilizar:

library(tidyverse)

# Nos traemos la tabla que tiene las comunas de cada barrio (unimos por barrio)

df_comunas <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_suaci_comunas.csv", sep = ';', header = TRUE)

str(df_comunas)

df_comunas$BARRIO <- as.character(df_comunas$BARRIO)

# Unimos el df_comunas a nuestro df, para agregar la variable "comuna"

df <- left_join(df,df_comunas)

# >>> ejercicio >>> Probar lo mismo pero con MERGE

#############################################################################################################
                                        #### MANIPULACIÓN DE DATOS ####
#############################################################################################################

# tidyverse tiene 8 paquetes sumamente útiles para la manupulación de datos:
# ggplot2, 
# dplyr, 
# tidyr, 
# readr, 
# purr, 
# tibble, 
# stringr, 
# forcats.

# dentro de dplyr, podemos invocar las siguientes funciones:
# select -- para elegir los campos/atributos que queremos
# filter -- para quedarnos con los registros que cumplan tal o cual condición
# arrange -- para ordenar las filas respecto de un indice o valores de alguna fila
# mutate -- para modificar las columnas del df o bien agreagr nuevas
# summarise -- para realizar operaciones agrupadas, de los valores de las columnas

#### SELECT()

select(df, BARRIO,total)

select(df, PERIODO:TIPO_PRESTACION)

select(df, -total)

# incorporamos nuestra consulta sobre el df, a un nuevo df:

df_seleccion <- select(df, -total)

#### FILTER()

filter(df, BARRIO == 'BOEDO')

df_boedo <- filter(df, BARRIO == 'BOEDO')

df_boedo_reclamo <- filter(df, BARRIO == 'BOEDO' & TIPO_PRESTACION != 'RECLAMO')

df_periodos <- filter(df, PERIODO >= 201401)

df_periodos <- filter(df, PERIODO >= 201501| PERIODO == 201301)


# borramos los df recién creados:

rm(df_seleccion)
rm(df_boedo)
rm(df_boedo_reclamo)
rm(df_periodos)


#### ARRANGE()

arrange(df,PERIODO)

df_periodos_asc <- arrange(df,PERIODO)

df_periodos_desc <- arrange(df, desc(PERIODO))

df_periodos_desc_barrio <- arrange(df, desc(PERIODO),BARRIO)


# borramos los df recién creados:

rm(df_periodos_asc)
rm(df_periodos_desc)
rm(df_periodos_desc_barrio)


#### MUTATE()

mutate(df, descripcion = paste0(df$RUBRO,"-",df$TIPO_PRESTACION))

df_mutate <- mutate(df, descripcion = paste0(df$RUBRO,"-",df$TIPO_PRESTACION))

df_mutate_mes <- mutate(df, mes = substr(PERIODO,5,6))


rm(df_mutate)
rm(df_mutate_mes)

# >>> ejercicio >>> Probar lo mismo pero sumando a un nuevo df, la variable "año".
# >>> ejercicio >>> Crear una variable que contenga tipo_prestacion y el año.
# >>> ejercicio >>> eliminar todos los df creados posteriormente.


#### SUMMARISE() -- GROUP BY()

summarise(df, mean(total))

summarise(df, promedio = mean(total), max_periodo= max(PERIODO))


# incorporamos el group by como en SQL

grupos_barrios <- group_by(df, BARRIO)

df_resumen <- summarise(grupos_barrios, mean(total))

df_resumen <- summarise(grupos_barrios, n(), mean(total))

arrange(df_resumen, BARRIO)

rm(grupos_barrios)
rm(df_resumen)

# >>> ejercicio >>> agrupar por tipo de reclamo, y obtener la suma por cada tipo de ellos.

#### OPERADOR %>% 

# Podemos realizar las mismas operaciones anteiores, pero juntas, mediante el operador pipe %>%.

df_seleccion <- df %>% select(-total) # SELECT

df_boedo_reclamo <- df %>% filter(BARRIO == 'BOEDO' & TIPO_PRESTACION != 'RECLAMO') # FILTER

df_periodos_barrio <-  df %>%  arrange(desc(PERIODO), BARRIO) # ARRANGE

df_mutate <- df %>%  mutate(descripcion = paste0(df$RUBRO,"-",df$TIPO_PRESTACION)) # MUTATE

df_grupos_barrios <-  df %>% group_by(BARRIO)  %>% summarise(media = mean(total))


## todo en una sola operación:

df_nuevo <- df %>%  mutate(descripcion = paste0(df$RUBRO,"-",df$TIPO_PRESTACION)) %>%
                    filter(BARRIO == 'BOEDO' ) %>%
                    select(PERIODO, descripcion, BARRIO) %>%
                    arrange(desc(PERIODO))


rm(df_nuevo)


df_nuevo <- df %>%  mutate(descripcion = paste0(df$RUBRO,"-",df$TIPO_PRESTACION)) %>%
                    filter(BARRIO == c('BOEDO','LINIERS','FLORESTA')) %>%
                    group_by(BARRIO)  %>% 
                    summarise(media = mean(total)) %>%
                    arrange(desc(media))



rm(df_seleccion)
rm(df_boedo_reclamo) 
rm(df_periodos_barrio)
rm(df_mutate)
rm(df_grupos_barrios)


# >>> ejercicio >>>  generar otro df, utilizando todas las funciones y el operador %>% ... 
# el select podría contener PERIODO, RUBRO Y TOTAL. 


############ NULOS/MISSING VALUES/VALORES FALTANTES ############

# na o NA (not available)

# chequeamos por variable...

is.na(df$COMUNA)

table(is.na(df$COMUNA))


# chequeamos todas las variables del df:

is.na(df)

table(is.na(df))

apply(is.na(df), 2, sum) # hace la operacion, sobre las columnas c(1,2)


# para realizar operaciones teniendo en cuenta los nulos:

mean(df$COMUNA)

mean(na.omit(df$COMUNA))

mean(df$COMUNA, na.rm=T)

mean(na.exclude(df$COMUNA))      


# Si quiero reemplazar nulos por cero o algun valor:

df$COMUNA[is.na(df$COMUNA)] <- 0

df$COMUNA[is.na(df$COMUNA)] <- 999

df$COMUNA_OK <- df$COMUNA

df$COMUNA_OK[is.na(df$COMUNA_OK)] <- mean(df$COMUNA, na.rm = TRUE)


# forma más genérica para todo el df

df <- df %>% mutate_if(is.integer, ~replace(., is.na(.), 0)) # en este caso el ~ indica función anónima

df <- df  %>% mutate_if(is.numeric, ~replace(., is.na(.), 0)) # el .x o . nos indican la variable 


# para el caso de barrios, resolvemos de la siguiente manera:

table(df$BARRIO)

df <- df %>% mutate(BARRIO_OK = case_when( BARRIO == ' ' ~ "SIN NOMBRE",
                                           BARRIO == "ERRORNOHAYRESULTA" ~ "SIN NOMBRE",
                                           BARRIO == "ERRORNOHAYRESULTADOS" ~ "SIN NOMBRE",
                                           TRUE ~ BARRIO))



############################################################################################################
                                        #### VISUALIZACIÓN ####
############################################################################################################

# Vamos a usar la base de datos mpg - miremos de qué se trata este dataframe

data(mpg)

mpg

?mpg # abre la documentación sobre mpg abajo a la derecha, donde se explica qué es cada variable.

head(mpg, 10) # nos muestra el tipo de dato variable por variable

# manufacturer -- fabricante
# model -- modelo
# displ -- cilindrada
# year -- año de manufactura
# cyl -- n° cilindros
# trans -- tipo de transmisión
# drv -- tracción (delantera/trasera/4wd)
# cty -- millas (ciudad)
# hwy -- millas (autopista)
# fl -- combustible
# class -- clase


#  PREGUNTA: ¿Los autos con motores grandes usan más nafta que los autos con motores chicos? 
# ¿Cómo es la relación entre el tamaño del motor y el consumo de nafta? ¿Es positiva, Negativa, Lineal?

# Creamos un gráfico de dispersión usando mpg que incluya el tamaño del motor (displ) en el eje de las x 
# y cantidad de millas por galón (hwy) en el eje de las y. 

# Existen muchos tipos de capas para ggplot. Los más usuales son geom_point, geom_line, geom_histogram, geom_bar y geom_boxplot


ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy)) # aes: referencias estéticas (en inglés)

# Funciona si pruebo otras formas como:??

ggplot(data = mpg) + geom_point(aes(x = displ, y = hwy))

# o como:??

ggplot(data = mpg) 
  + geom_point(mapping = aes(x = displ, y = hwy))


# >>> ejercicio >>>  Hacé un gráfico de dispersión de hwy versus cyl


#### Agregado de atributos estéticos a distintas variables

# Usando colores para identificar las distintas clases de vehículos (class)

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, color = class))

# También podés usar distintos niveles de transparencias

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, alpha = class))

# O distintas formas (ojo! SUV no aparece en el gráfico, se quedó sin forma)

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, shape = class))

# En lugar de pintar por clase, pinto todos los puntos de un mismo color

ggplot(data = mpg) + 
  geom_point( aes(x = displ, y = hwy), color = "blue")

# >>> ejercicio >>>  Por qué en el siguiente gráfico los puntos no son azules? Cómo lo arreglarías?

ggplot(data = mpg) + 
  geom_point( aes(x = displ, y = hwy, color = "blue"))

# Qué pasa si usás la variable cty (variable continua) para el atributo estético color?

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, color = cty))

#  >>> ejercicio >>>  Probá lo mismo con alpha y shape. Cómo se comparan estos gráficos a cuando
# usaste la variable categórica class?

#  >>> ejercicio >>>  Qué hace el atributo estético stroke? Con qué formas funciona?
# Mostrá un ejemplo. Pista: Usá el comando ?geom_point

### Generamos gráficos sin gglplot

# primero, veamos los parámetros seteados del plot. Son todas las caracteristicas de los graficos que
# estan seteadas por default:

par()

# valor por default de los margenes del plot:

par(mar=c(5.1, 4.1, 4.1, 2.1))

plot(mpg$displ,mpg$hwy)


# podemos mejorarlo, usando los mimmos simbolos para los puntos (?pch):

plot(mpg$displ,mpg$hwy,pch=19,cex=0.75)

# de esta forma agregamos una grilla al plot:

grid(col = "grey")

# otra opcion es hacerlo dentro de la misma sentencia del plot:

plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid())


# faltan los labels:

plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy")


# podemos agregarle un titulo?

plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy",main = "datos mpg")


# usando colores para diferentes "class" de autos

plot(mpg$displ[mpg$class!="2seater"],mpg$hwy[mpg$class!="2seater"],pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy")
points(mpg$displ[mpg$class=="2seater"],mpg$hwy[mpg$class=="2seater"],pch=19,cex=1,col="red")


# Para datos categóricos, una forma fácil de hacer un gráfico para cada categoría con ggplot:

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


# revisamos las variables involucradas:

table(mpg$class)

table(mpg$displ)

table(mpg$hwy)

length(mpg$class)


# podemos cambiar los parámetros del gráfico:

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy), color= 'blue') + 
  facet_wrap(~ class, nrow = 3)


# si probamos con otra variante de la funcion facet_grid:
ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Que significan las celdas vacias en el gráfico? teniendo en cuenta que:

# displ -- cilindrada
# cyl -- n° cilindros
# drv -- tracción (delantera/trasera/4wd)
# hwy -- millas (autopista)


# analizamos las variables drv y cyl

table(mpg$drv,mpg$cyl)

# si solo queremos distinguir por una variable: qué hace el "." (punto)? >> permite eligir por filas o columnas

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ .)


# si queremos buscar ayuda de la funcion
?facet_wrap


## Otra forma de graficar la misma información con ggplot:


# Primero el grafico de puntos que ya conocemos:

ggplot(data = mpg) + 
  geom_point( aes(x = displ, y = hwy))

# y ahora otro tipo de gráfico:

ggplot(data = mpg) + 
  geom_smooth( aes(x = displ, y = hwy))

# se pueden dibujar conjuntamente:

ggplot(data = mpg) + 
  geom_point( aes(x = displ, y = hwy)) +
  geom_smooth( aes(x = displ, y = hwy)) # el area gris nos marca el intervalo de confianza.


# los puntos x e y usados son los mismos pero los objetos geométricos son diferentes.
# geom_smooth hace algo con los datos, está aplicando un método para obtener una curva suave
# Por defecto usa el método loess (regresión local) para n chicas y gam (modelo general aditivo) para n grande.


# veamos otra opción de esta función (agregando linetype = drv)

ggplot(data = mpg) + 
  geom_smooth(aes(x = displ, y = hwy, linetype = drv))

# qué está haciendo?

table(mpg$drv)

# podemos marcar los diferentes puntos usando diferentes colores:

ggplot(data = mpg) + 
  geom_point(aes(x = displ, y = hwy, color=drv)) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv,color=drv))

# está trazando una curva suave para cada grupo de datos de acuerdo a la clase drv.


# no hace falta escribir la misma informacion varias veces:

ggplot(data = mpg,aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# y tambien podemos simplificar el código que distingue puntos:

ggplot(data = mpg, aes(x = displ, y = hwy, color=drv)) + 
  geom_point() +
  geom_smooth()


# podemos hacer el ajuste sólo para un subconjunto de los datos:

ggplot(data = mpg,aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # qué hace el se=FALSE?


# graficamos solo los puntos que vamos a usar para hacer el ajuste:

ggplot(data = filter(mpg, class == "subcompact"), aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# podemos graficar puntos y curvas del mismo color?

ggplot(data = filter(mpg, class == "subcompact"),aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class),color="red") + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE,color="red")


# Ejercicio: qué hace este codigo?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# como hacemos para que no haya legend en el grafico?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = FALSE,show.legend = FALSE)

# que hace el argumento "se"
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = TRUE,show.legend = FALSE)


# GRÁFICOS DE BARRAS!

# Utilizamos la base de datos "diamantes"

data(diamonds)
diamonds

# Miramos la estructura del data frame:

str(diamonds)

# gráfico de barras de la variable cut:

ggplot(data = diamonds) + 
  geom_bar(aes(x = cut))

# podemos ver esta información?

table(diamonds$cut)

# cómo haríamos el mismo gráfico en R base?

a <- table(diamonds$cut)

# podemos cambiar el tamaño de los ticks

bar <- barplot(a, main="Variable cut (diamonds)", las=2, cex.names=0.75,xlab="", ylab="frecuencia", cex.axis=0.7)
# las = 2 nos deja las etiquetas de eje x de forma vertical y del eje y en forma horizontañ

# podemos agregarle información del valor de cada barra

text(bar[,1],1000,a,cex=0.7)


# >>> ejercicio >>> Podemos generar un conjunto de datos que nos interese y graficar las barras
# ejemplo...
# medios de transporte utilizados habitualmente

# una forma de cargar datos:
Rdatos <- tribble(
                  ~viaje, ~freq,
                  "auto", 16,
                  "pie",  4,
                  "cole", 12,
                  "tren", 10,
                  "subte",20
                )

# qué gráfico obtenemos? 

ggplot(data = Rdatos) +
  geom_bar(aes(x = viaje, y = freq), stat = "identity") # cuando estamos utlizando dos variables. Por default es "bin"
# bin sirve apra contar/ count de unan variable

# Volviendo a Diamonds, Otro tipo de gráfico que resume informacion de las variables:
# qué hace esta sentencia?

ggplot(data = diamonds) + 
        stat_summary(
          mapping = aes(x = cut, y = depth),
          fun.ymin = min,
          fun.ymax = max,
          fun.y = median()
        )

# min, max, median son funciones de R:
summary(diamonds$depth[diamonds$cut=="Fair"])
summary(diamonds$depth[diamonds$cut=="Good"])

# cómo podemos cambiar mediana por media?

# A veces queremos hacer un grafico a partir de una tabla de doble entrada (dos categorias)
# por ejemplo nos interesa cut y clarity de los diamantes

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# veamos la tabla que está graficando:

table(diamonds$cut,diamonds$clarity)

#de otra forma:

tabla <- table(diamonds$cut,diamonds$clarity)
bar <- barplot(tabla,main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# qué pasó con los colores si no le decimos nada?

bar <- barplot(ta,col=topo.colors(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# qué hace la función topo.colors()?: 
topo.colors(5)

# otra opcion para crear paleta de colores:
rainbow(5)

# por qué el argumento que le damos es 5?

bar <- barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# si queremos ver los posibles valores de cut y clarity:
rownames(ta)
colnames(ta)

# revisar qué es ta, y su estructura!

# tenemos que agregarle un legend a mano:

bar <- barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.5,col=rainbow(5),fill=rainbow(5))

# si queremos guardar el gráfico en un pdf desde la consola:

pdf("diamantes.pdf")
bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.5,col=rainbow(5),fill=rainbow(5))
dev.off()

# si le queremos agregar label al eje x

bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="cut",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.6,fill=rainbow(5))

# también podemos graficar en barritas para cada categoría

bar <- barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="cut",ylab="frecuencia",cex.axis=0.7,beside=T)
legend("topright",leg=rownames(ta),cex=0.6,fill=rainbow(5))


# y como veiamos en R base, tambien tenemos la opcion en ggplot de varias lineas verticales, usando
# tambien el argumento position

ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = clarity), position = "dodge")

# veamos una normalizacion usando el argumento position = "fill":
ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = clarity), position = "fill")










