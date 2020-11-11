#############################################################################################################
#############################################################################################################
#############################################################################################################
                                     
                                ### EJERCICIOS INTRODUCCIÓN A R ###

##############################################################################################################
##############################################################################################################
##############################################################################################################

## Empezamos por fijar el directorio de trabajo (wd):

getwd() # Chequeo el Working directory

 #fijo el directorio donde voy a trabajar
bank <- read.csv('./Modulo_3/ejercicios R/bank.csv', header = T, sep = ';')


# invoco librerías a utilizar:

library(tidyverse)
library(data.table)
# ¿cuántas columnas y filas tiene el df? es un df?

ncol(bank)
nrow(bank)

# ¿Qué estructura tiene el df?

str(bank)

# renombrar las variables, a partir de las siguientes definiciones:

# el dataset corresponde a una campaña de marketing de un banco Portugues, basasa en llamadas telefónicas.
# Muy frecuentemente se necesitó más de un contacto con el mismo cliente, para saber si el cliente suscribiría
# un depósito plazo fijo en el banco o no.


# Variables:
  column_names <- c(
    'edad',
    'trabajo_tipo',
    'estado_civil',
    'educación_nivel',
    'credito_en_mora',
    'balance_prom_anual',
    'credito_hipotecario',
    'credito_personal',
    'tipo_contacto',
    'ultimo_dia_mes_contacto',
    'ultimo_mes_anio_contacto',
    'seg_duracion_contacto',
    'cant_contactos_en_campania',
    'dias_desde_ultimo_contacto',
    'cant_contactos_antes_campania',
    'resultado_campania_previa',
    'target'
  )
  
  
  names(bank) <- column_names
  
# 1 - age: edad
# 2 - job : trabajo-tipo de trabajo.
# 3 - marital : estado civil.
# 4 - education: educación-nivel educativo.
# 5 - default: tiene un crédito en mora
# 6 - balance: balance promedio anual, en euros. 
# 7 - housing: tiene préstamo hipotecario.
# 8 - loan: tiene préstamo personal.
# 9 - contact: tipo de contancto que tuvo. 
# 10 - day: ultimo día del mes en que fue contactado.
# 11 - month: último mes del año en que fue contactado.
# 12 - duration: duración del último contacto, en segundos.
# 13 - campaign: cantidad de contactos realizados durante esa campaña y para ese cliente.
# 14 - pdays: numero de dias pasados luego de la última vez que el cliente fue contactado en una campaña previa.
# 15 - previous: numero de contactos realizados antes de la actual campaña y para ese cliente.
# 16 - poutcome: resultado de la campaña de mnarketing previa.
# 17 - y: el cliente suscrubió o no un plazo fijo.


# Observar la estadística descriptiva del dataset.
summary(bank)
# Podrías chequear también còmo de distribuyen algunas o todas las variables.

hist(bank$edad)


ggplot(data = bank) + 
  geom_bar(aes(x = trabajo_tipo)) + 
  theme(axis.text.x = element_text(angle = 90))
# Qué proporciòn de personas suscribieron un plazo fijo? (lo hacemos utilziando la variable "y")

x <- bank %>% filter(target == 'yes')

nrow(x)/nrow(bank)

ggplot(data = bank) + 
  geom_bar(aes(x = target))

# Mover la variable "y" al principio del df

bank_y <- select(bank, target)
bank <- select(bank, -target)

bank <- cbind(bank_y, bank)

rm(bank_y)

# crear un nuevo df que sómo contenga edad, estado civil, duracion del llamado y la variable y

df_edad_estadocivil_duracion_target <-
  select(bank,
         c('edad', 'estado_civil', 'seg_duracion_contacto', 'target'))

head(df_edad_estadocivil_duracion_target)

# Crear un nuevo df, que contenga a los clientes que tuvieron una conversación cuya duración superó los 5min.

limite_5min <- 60 * 5

df_mas_5min <- 
  bank %>% 
    filter(seg_duracion_contacto > limite_5min)

# Observas más suscripción de plazo fijo en este nuevo dataframe comparado con el original?

x <- df_mas_5min %>% filter(target == 'yes')

nrow(x)/nrow(df_mas_5min)

ggplot(data = df_mas_5min) + 
  geom_bar(aes(x = target))

# A partir de este nuevo df, analizar la distribución de las características de los clientes. ¿Qué proporción
# son hombres/mujeres? ¿cómo se distribuye el estado civil? ¿cuántos casados tienen menos de 50 años? 
# ¿cuántos divorciados tienen menos de 40? sobre esta úlñtima muestra, qué proporción susucrubió plazo fijo?

# ¿cómo se distribuye el estado civil?

ggplot(data = df_mas_5min) + 
  geom_bar(aes(x = target, fill = estado_civil))

# ¿cuántos casados tienen menos de 50 años?

table(df_mas_5min$estado_civil)

df_casados_5min <- df_mas_5min %>% filter(estado_civil == 'married' &
                                            edad < 50)

ggplot(data = df_casados_5min) + 
  geom_bar(aes(x = target))

# A partir del df original, qué porcentaje de clientes suscribieron un plazo fijo, dado el estado civil del cliente?

ggplot(data = bank, aes(x = factor(estado_civil))) +
  geom_bar(aes(fill = target))

x <- bank %>% 
  group_by(estado_civil) %>% 
  count(target) %>%
  mutate(prop = n/sum(n))

ggplot(x, aes(x = estado_civil, y = prop)) +
  geom_col(aes(fill = target)) +
  geom_text(
    aes(
      label = scales::percent(prop),
      y = prop,
      group = target
    )
  )



#divorciados menos a 40


x <- bank %>% 
  filter(estado_civil == 'divorced' & edad < 40) %>%
  group_by(estado_civil) %>% 
  count(target) %>%
  mutate(prop = n/sum(n))

ggplot(x, aes(x = estado_civil, y = prop)) +
  geom_col(aes(fill = target)) +
  geom_text(
    aes(
      label = scales::percent(prop),
      y = prop,
      group = target
    )
  )
  # A partir del df original, qué porcentaje de clientes suscribieron un plazo fijo, dado la edad > 30 años versus menores de 30? 

# ¿Cuál es la duración promedio del último contacto, agrupada por la variable "y"?


# ¿Cuál es la duración promedio del último contacto, y la edad promedio, agrupada por la variable "y"?

# ¿Qué proporción de clientes con mora, suscribieron un plazo fijo? Esto cambia respecto a los que no estan en mora?

# ¿ Hay alguna relacion entre la edad y la duracion de la ultima llamada ? (realizar un Scatterplot)

ggplot(bank, aes(x = target, y = edad)) +
  geom_violin() +
  coord_flip()

# Demostrar graficamente que a mayor duracion en la ultima llamada, mayor es la posibilidad de que el cliente suscriba el deposito a plazo.

# Dibujar con histograma, la disrtibución de la variable edad.

### PROBAR CON DISTINTAS OPCIONES PARA EDITAR EL GRÁFICO ###


