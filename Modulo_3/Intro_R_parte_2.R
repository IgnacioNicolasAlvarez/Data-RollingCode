# Chequeo d�nde estoy ubicad@
getwd()

# vamos a utlizar un dataset del Gobierno de la Ciudad de Buenos Aires >>> Sistema �nico de Atenci�n Ciudadana (SUACI)
# https://data.buenosaires.gob.ar


df <-
  read.csv(
    "./Modulo_3/gcba_suaci_barrios.csv",
    na = "NA",
    sep = ',',
    stringsAsFactors = TRUE
  )



# de otra forma...
#df <- read.csv('AAAAAA.csv', sep=',',header= T, dec='.',na.strings = "NA")

# Me fijo si la importaci�n fue como DATAFRAME, su dimensi�n y una vista general

class(df)

dim(df)

head(df, 20)

# Reviso la estructura de las variables de mi df

str(df)

# Para tener estad�stica descriptiva de las variables de mi df (se puede hacer atributo x atributo)

summary(df)

summary(df$total)

# Para conocer los diferentes niveles de una variable categ�rica:

levels(df$RUBRO) # cuando la variable es un factor.

table(df$RUBRO)  # para resto de las variables y con su # correspondiente.

# >>> ejercicio >>> Probar con el resto de variables...

#############################################################################################################
#### JOINS ENTRE TABLAS ####
#############################################################################################################

# install.packages("tidyverse")

# invoco librer�as a utilizar:

library(tidyverse)

# Nos traemos la tabla que tiene las comunas de cada barrio (unimos por barrio)

df_comunas <-
  read_delim('Modulo_3/gcba_suaci_comunas.csv', delim = ';')

str(df_comunas)

df_comunas$BARRIO <- as.character(df_comunas$BARRIO)

# Unimos el df_comunas a nuestro df, para agregar la variable "comuna"

df <- left_join(df, df_comunas)

head(df)
# >>> ejercicio >>> Probar lo mismo pero con MERGE
df <-
  merge(
    x = df,
    y = df_comunas,
    by.x = 'BARRIO',
    by.y = 'BARRIO',
    all.x = T,
    all. = F
  )
#############################################################################################################
#### MANIPULACI�N DE DATOS ####
#############################################################################################################

# tidyverse tiene 8 paquetes sumamente �tiles para la manupulaci�n de datos:
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
# filter -- para quedarnos con los registros que cumplan tal o cual condici�n
# arrange -- para ordenar las filas respecto de un indice o valores de alguna fila
# mutate -- para modificar las columnas del df o bien agreagr nuevas
# summarise -- para realizar operaciones agrupadas, de los valores de las columnas

#### SELECT()

select(df, BARRIO, total)

select(df, PERIODO:TIPO_PRESTACION)

select(df,-total)

# incorporamos nuestra consulta sobre el df, a un nuevo df:

df_seleccion <- select(df,-total)

#### FILTER()

filter(df, BARRIO == 'BOEDO')

df_boedo <- filter(df, BARRIO == 'BOEDO')

df_boedo_reclamo <-
  filter(df, BARRIO == 'BOEDO' & TIPO_PRESTACION != 'RECLAMO')

df_periodos <- filter(df, PERIODO >= 201401)

df_periodos <- filter(df, PERIODO >= 201501 | PERIODO == 201301)


# borramos los df reci�n creados:

rm(df_seleccion)
rm(df_boedo)
rm(df_boedo_reclamo)
rm(df_periodos)


#### ARRANGE()

arrange(df, PERIODO) # ordena

df_periodos_asc <- arrange(df, PERIODO)

df_periodos_desc <- arrange(df, desc(PERIODO))

df_periodos_desc_barrio <- arrange(df, desc(PERIODO), BARRIO)


# borramos los df reci�n creados:

rm(df_periodos_asc)
rm(df_periodos_desc)
rm(df_periodos_desc_barrio)


#### MUTATE()

mutate(df, descripcion = paste0(df$RUBRO, "-", df$TIPO_PRESTACION))

df_mutate <-
  mutate(df, descripcion = paste0(df$RUBRO, "-", df$TIPO_PRESTACION))

df_mutate_mes <- mutate(df, mes = substr(PERIODO, 5, 6))


rm(df_mutate)
rm(df_mutate_mes)

# >>> ejercicio >>> Probar lo mismo pero sumando a un nuevo df, la variable "a�o".
# >>> ejercicio >>> Crear una variable que contenga tipo_prestacion y el a�o.

df_mutate_anio <-
  df %>%
  mutate(anio = substr(PERIODO, 1, 4)) %>%
  mutate(tipo_prestacion_anio = paste0(TIPO_PRESTACION, "-", anio))

# >>> ejercicio >>> eliminar todos los df creados posteriormente.

rm(df_mutate_anio)

#### SUMMARISE() -- GROUP BY()

summarise(df, mean(total))

summarise(df,
          promedio = mean(total),
          max_periodo = max(PERIODO))



# incorporamos el group by como en SQL

grupos_barrios <- group_by(df, BARRIO)

df_resumen <- summarise(grupos_barrios, mean(total))

df_resumen <- summarise(grupos_barrios, n(), mean(total))

arrange(df_resumen, BARRIO)

rm(grupos_barrios)
rm(df_resumen)

# >>> ejercicio >>> agrupar por tipo de reclamo, y obtener la suma por cada tipo de ellos.

grupos_barrios <-
  group_by(df, df$TIPO_PRESTACION) %>%
  summarise(n())


#### OPERADOR %>%

# Podemos realizar las mismas operaciones anteiores, pero juntas, mediante el operador pipe %>%.

df_seleccion <- df %>% select(-total) # SELECT

df_boedo_reclamo <-
  df %>% filter(BARRIO == 'BOEDO' &
                  TIPO_PRESTACION != 'RECLAMO') # FILTER

df_periodos_barrio <-
  df %>%  arrange(desc(PERIODO), BARRIO) # ARRANGE

df_mutate <-
  df %>%  mutate(descripcion = paste0(df$RUBRO, "-", df$TIPO_PRESTACION)) # MUTATE

df_grupos_barrios <-
  df %>% group_by(BARRIO)  %>% summarise(media = mean(total))


## todo en una sola operaci�n:

df_nuevo <-
  df %>%  mutate(descripcion = paste0(df$RUBRO, "-", df$TIPO_PRESTACION)) %>%
  filter(BARRIO == 'BOEDO') %>%
  select(PERIODO, descripcion, BARRIO) %>%
  arrange(desc(PERIODO))


rm(df_nuevo)


df_nuevo <-
  df %>%  mutate(descripcion = paste0(df$RUBRO, "-", df$TIPO_PRESTACION)) %>%
  filter(BARRIO == c('BOEDO', 'LINIERS', 'FLORESTA')) %>%
  group_by(BARRIO)  %>%
  summarise(media = mean(total)) %>%
  arrange(desc(media))



rm(df_seleccion)
rm(df_boedo_reclamo)
rm(df_periodos_barrio)
rm(df_mutate)
rm(df_grupos_barrios)


# >>> ejercicio >>>  generar otro df, utilizando todas las funciones y el operador %>% ...
# el select podr�a contener PERIODO, RUBRO Y TOTAL.

df_2 <- df %>%
  select(PERIODO, total, RUBRO) %>%
  filter(total > 500) %>%
  group_by(RUBRO) %>%
  summarise(median = median(total))

############ NULOS/MISSING VALUES/VALORES FALTANTES ############

# na o NA (not available)

# chequeamos por variable...

is.na(df$COMUNA)

table(is.na(df$COMUNA))


# chequeamos todas las variables del df:

is.na(df)

table(is.na(df))

apply(is.na(df), 2, sum) # 2 aplica sobre columnas, 1 sobre filas


# para realizar operaciones teniendo en cuenta los nulos:

mean(df$COMUNA)

mean(na.omit(df$COMUNA))

mean(df$COMUNA, na.rm = T)

mean(na.exclude(df$COMUNA))


# Si quiero reemplazar nulos por cero o algun valor:

df$COMUNA[is.na(df$COMUNA)] <- 0

df$COMUNA[is.na(df$COMUNA)] <- 999

df$COMUNA_OK <- df$COMUNA

df$COMUNA_OK[is.na(df$COMUNA_OK)] <- mean(df$COMUNA, na.rm = TRUE)


# forma m�s gen�rica para todo el df

df <-
  df %>% mutate_if(is.integer, ~ replace(., is.na(.), 0)) # en este caso el ~ indica funci�n an�nima

df <-
  df  %>% mutate_if(is.numeric, ~ replace(., is.na(.), 0)) # el .x o . nos indican la variable


# para el caso de barrios, resolvemos de la siguiente manera:

table(df$BARRIO)

df <-
  df %>% mutate(
    BARRIO_OK = case_when(
      BARRIO == ' ' ~ "SIN NOMBRE",
      # el then es el ~
      BARRIO == "ERRORNOHAYRESULTA" ~ "SIN NOMBRE",
      BARRIO == "ERRORNOHAYRESULTADOS" ~ "SIN NOMBRE",
      TRUE ~ BARRIO
    )
  )



############################################################################################################
#### VISUALIZACI�N ####
############################################################################################################

# Vamos a usar la base de datos mpg - miremos de qu� se trata este dataframe

data(mpg)

mpg

? mpg # abre la documentaci�n sobre mpg abajo a la derecha, donde se explica qu� es cada variable.

head(mpg, 10) # nos muestra el tipo de dato variable por variable

# manufacturer -- fabricante
# model -- modelo
# displ -- cilindrada
# year -- a�o de manufactura
# cyl -- n� cilindros
# trans -- tipo de transmisi�n
# drv -- tracci�n (delantera/trasera/4wd)
# cty -- millas (ciudad)
# hwy -- millas (autopista)
# fl -- combustible
# class -- clase


#  PREGUNTA: �Los autos con motores grandes usan m�s nafta que los autos con motores chicos?
# �C�mo es la relaci�n entre el tama�o del motor y el consumo de nafta? �Es positiva, Negativa, Lineal?

# Creamos un gr�fico de dispersi�n usando mpg que incluya el tama�o del motor (displ) en el eje de las x
# y cantidad de millas por gal�n (hwy) en el eje de las y.

# Existen muchos tipos de capas para ggplot. Los m�s usuales son geom_point, geom_line, geom_histogram, geom_bar y geom_boxplot


ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) + 
  theme(axis.text.x = element_text(angle = 45))
# aes: referencias est�ticas (en ingl�s)

# Funciona si pruebo otras formas como:??

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy))

# o como:??

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme(axis.text.x = element_text(angle = 45))


# >>> ejercicio >>>  Hac� un gr�fico de dispersi�n de hwy versus cyl

ggplot(data = mpg) +
  geom_point(aes(x = cyl, y = hwy)) 


#### Agregado de atributos est�ticos a distintas variables

# Usando colores para identificar las distintas clases de veh�culos (class)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, color = class))

# Tambi�n pod�s usar distintos niveles de transparencias

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, alpha = class))

# O distintas formas (ojo! SUV no aparece en el gr�fico, se qued� sin forma)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, shape = class))

# En lugar de pintar por clase, pinto todos los puntos de un mismo color

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), color = "blue")

# >>> ejercicio >>>  Por qu� en el siguiente gr�fico los puntos no son azules? C�mo lo arreglar�as?

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), color = "blue") # porque color esta dentro del aes()

# Qu� pasa si us�s la variable cty (variable continua) para el atributo est�tico color?

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, color = cty))

#  >>> ejercicio >>>  Prob� lo mismo con alpha y shape. C�mo se comparan estos gr�ficos a cuando
# usaste la variable categ�rica class?

ggplot(data = mpg) +
  geom_point(aes(
    x = displ,
    y = hwy,
    size = cty,
    alpha = cty,
    color = class
  ))

#  >>> ejercicio >>>  Qu� hace el atributo est�tico stroke? Con qu� formas funciona?
# Mostr� un ejemplo. Pista: Us� el comando ?geom_point
ggplot(data = mpg) +
  geom_point(aes(
    x = displ,
    y = hwy,
    stroke = 2
  ))
### Generamos gr�ficos sin gglplot

# primero, veamos los par�metros seteados del plot. Son todas las caracteristicas de los graficos que
# estan seteadas por default:

par()

# valor por default de los margenes del plot:

par(mar = c(5.1, 4.1, 4.1, 2.1))

plot(mpg$displ, mpg$hwy)


# podemos mejorarlo, usando los mimmos simbolos para los puntos (?pch):

plot(mpg$displ, mpg$hwy, pch = 19, cex = 0.75)

# de esta forma agregamos una grilla al plot:

grid(col = "grey")

# otra opcion es hacerlo dentro de la misma sentencia del plot:

plot(mpg$displ, mpg$hwy, pch = 19, cex = 0.75, grid())


# faltan los labels:

plot(
  mpg$displ,
  mpg$hwy,
  pch = 19,
  cex = 0.75,
  grid(),
  xlab = "displ",
  ylab = "hwy"
)


# podemos agregarle un titulo?

plot(
  mpg$displ,
  mpg$hwy,
  pch = 19,
  cex = 0.75,
  grid(),
  xlab = "displ",
  ylab = "hwy",
  main = "datos mpg"
)


# usando colores para diferentes "class" de autos

plot(
  mpg$displ[mpg$class != "2seater"],
  mpg$hwy[mpg$class != "2seater"],
  pch = 19,
  cex = 0.75,
  grid(),
  xlab = "displ",
  ylab = "hwy"
)
points(mpg$displ[mpg$class == "2seater"],
       mpg$hwy[mpg$class == "2seater"],
       pch = 19,
       cex = 1,
       col = "red")


# Para datos categ�ricos, una forma f�cil de hacer un gr�fico para cada categor�a con ggplot:

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap( ~ class, nrow = 2)


# revisamos las variables involucradas:

table(mpg$class)

table(mpg$displ)

table(mpg$hwy)

length(mpg$class)


# podemos cambiar los par�metros del gr�fico:

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy), color = 'blue') +
  facet_wrap( ~ class, nrow = 3)


# si probamos con otra variante de la funcion facet_grid:
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# Que significan las celdas vacias en el gr�fico? teniendo en cuenta que:

# displ -- cilindrada
# cyl -- n� cilindros
# drv -- tracci�n (delantera/trasera/4wd)
# hwy -- millas (autopista)


# analizamos las variables drv y cyl

table(mpg$drv, mpg$cyl)

# si solo queremos distinguir por una variable: qu� hace el "." (punto)? >> permite eligir por filas o columnas

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ .)


# si queremos buscar ayuda de la funcion
? facet_wrap


## Otra forma de graficar la misma informaci�n con ggplot:


# Primero el grafico de puntos que ya conocemos:

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy))

# y ahora otro tipo de gr�fico:

ggplot(data = mpg) +
  geom_smooth(aes(x = displ, y = hwy))

# se pueden dibujar conjuntamente:

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  geom_smooth(aes(x = displ, y = hwy)) # el area gris nos marca el intervalo de confianza.


# los puntos x e y usados son los mismos pero los objetos geom�tricos son diferentes.
# geom_smooth hace algo con los datos, est� aplicando un m�todo para obtener una curva suave
# Por defecto usa el m�todo loess (regresi�n local) para n chicas y gam (modelo general aditivo) para n grande.


# veamos otra opci�n de esta funci�n (agregando linetype = drv)

ggplot(data = mpg) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv))

# qu� est� haciendo?

table(mpg$drv)

# podemos marcar los diferentes puntos usando diferentes colores:

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(aes(
    x = displ,
    y = hwy,
    linetype = drv,
    color = drv
  ))

# est� trazando una curva suave para cada grupo de datos de acuerdo a la clase drv.


# no hace falta escribir la misma informacion varias veces:

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# y tambien podemos simplificar el c�digo que distingue puntos:

ggplot(data = mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth()


# podemos hacer el ajuste s�lo para un subconjunto de los datos:

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # qu� hace el se=FALSE?


# graficamos solo los puntos que vamos a usar para hacer el ajuste:

ggplot(data = filter(mpg, class == "subcompact"), aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# podemos graficar puntos y curvas del mismo color?

ggplot(data = filter(mpg, class == "subcompact"), aes(x = displ, y = hwy)) +
  geom_point(aes(color = class), color = "red") +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE,
    color = "red"
  )


# Ejercicio: qu� hace este codigo?

ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

# como hacemos para que no haya legend en el grafico?

ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(show.legend = FALSE) +
  geom_smooth(se = FALSE, show.legend = FALSE)

# que hace el argumento "se"
ggplot(data = mpg,
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(show.legend = FALSE) +
  geom_smooth(se = TRUE, show.legend = FALSE)


# GR�FICOS DE BARRAS!

# Utilizamos la base de datos "diamantes"

data(diamonds)
diamonds

# Miramos la estructura del data frame:

str(diamonds)

# gr�fico de barras de la variable cut:

ggplot(data = diamonds) +
  geom_bar(aes(x = cut))

# podemos ver esta informaci�n?

table(diamonds$cut)

ggplot(data = diamonds) +
  geom_bar(aes(y = color, fill = cut)) +
  theme(legend.position = "top")

# c�mo har�amos el mismo gr�fico en R base?

a <- table(diamonds$cut)

# podemos cambiar el tama�o de los ticks

bar <-
  barplot(
    a,
    main = "Variable cut (diamonds)",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )
# las = 2 nos deja las etiquetas de eje x de forma vertical y del eje y en forma horizonta�

# podemos agregarle informaci�n del valor de cada barra

text(bar[, 1], 1000, a, cex = 0.7)


# >>> ejercicio >>> Podemos generar un conjunto de datos que nos interese y graficar las barras

head(diamonds)



# ejemplo...
# medios de transporte utilizados habitualmente

# una forma de cargar datos:
Rdatos <- tribble(~ viaje,
                  ~ freq,
                  "auto",
                  16,
                  "pie",
                  4,
                  "cole",
                  12,
                  "tren",
                  10,
                  "subte",
                  20)

# qu� gr�fico obtenemos?

ggplot(data = Rdatos) +
  geom_bar(aes(x = viaje, y = freq), stat = "identity") # cuando estamos utlizando dos variables. Por default es "bin"
# bin sirve apra contar/ count de unan variable

# Volviendo a Diamonds, Otro tipo de gr�fico que resume informacion de las variables:
# qu� hace esta sentencia?

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median()
  )

# min, max, median son funciones de R:
summary(diamonds$depth[diamonds$cut == "Fair"])
summary(diamonds$depth[diamonds$cut == "Good"])

# c�mo podemos cambiar mediana por media?

# A veces queremos hacer un grafico a partir de una tabla de doble entrada (dos categorias)
# por ejemplo nos interesa cut y clarity de los diamantes

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

# veamos la tabla que est� graficando:

table(diamonds$cut, diamonds$clarity)

#de otra forma:

tabla <- table(diamonds$cut, diamonds$clarity)
bar <-
  barplot(
    tabla,
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )

# qu� pas� con los colores si no le decimos nada?

bar <-
  barplot(
    ta,
    col = topo.colors(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )

# qu� hace la funci�n topo.colors()?:
topo.colors(5)

# otra opcion para crear paleta de colores:
rainbow(5)

# por qu� el argumento que le damos es 5?

bar <-
  barplot(
    ta,
    col = rainbow(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )

# si queremos ver los posibles valores de cut y clarity:
rownames(ta)
colnames(ta)

# revisar qu� es ta, y su estructura!

# tenemos que agregarle un legend a mano:

bar <-
  barplot(
    ta,
    col = rainbow(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )
legend(
  "topright",
  leg = rownames(ta),
  cex = 0.5,
  col = rainbow(5),
  fill = rainbow(5)
)

# si queremos guardar el gr�fico en un pdf desde la consola:

pdf("diamantes.pdf")
bar <-
  barplot(
    ta,
    col = rainbow(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "",
    ylab = "frecuencia",
    cex.axis = 0.7
  )
legend(
  "topright",
  leg = rownames(ta),
  cex = 0.5,
  col = rainbow(5),
  fill = rainbow(5)
)
dev.off()

# si le queremos agregar label al eje x

bar <-
  barplot(
    ta,
    col = rainbow(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "cut",
    ylab = "frecuencia",
    cex.axis = 0.7
  )
legend("topright",
       leg = rownames(ta),
       cex = 0.6,
       fill = rainbow(5))

# tambi�n podemos graficar en barritas para cada categor�a

bar <-
  barplot(
    ta,
    col = rainbow(5),
    main = "Diamantes",
    las = 2,
    cex.names = 0.75,
    xlab = "cut",
    ylab = "frecuencia",
    cex.axis = 0.7,
    beside = T
  )
legend("topright",
       leg = rownames(ta),
       cex = 0.6,
       fill = rainbow(5))


# y como veiamos en R base, tambien tenemos la opcion en ggplot de varias lineas verticales, usando
# tambien el argumento position

ggplot(data = diamonds) +
  geom_bar(aes(x = cut, fill = clarity), position = "dodge")

# veamos una normalizacion usando el argumento position = "fill":
ggplot(data = diamonds) +
  geom_bar(aes(x = cut, fill = clarity), position = "fill") +
  theme(axis.text.x = element_text(angle = 45))

