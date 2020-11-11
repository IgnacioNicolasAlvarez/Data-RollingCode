############################################################################################################
############################################################################################################
############################################################################################################

### EXPLORACIÓN Y LIMPIEZA DE DATOS ###

############################################################################################################
############################################################################################################
############################################################################################################

# Chequeo dónde estoy ubicadO

getwd()
setwd("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python")


# Levanto la Base

df_comunas <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_suaci_comunas_ejercicios.csv", sep = ',', header = TRUE)

# llamo a la librería

library(tidyverse)

# podemos revisar la estructura y algunas estadisticas descriptivas del df

str(df_comunas)

summary(df_comunas)

# Levanto otro dataset para tener la población de cada comuna

df_poblacion <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_pob_comunas_17.csv", sep = ',', header = TRUE)


# También revisamos qué tiene el df:

str(df_poblacion)

summary(df_poblacion)


# Creamos un nuevo df con agrupamiento para ver cantidad de cconsultas

casos_por_comuna <- df_comunas %>% 
                    group_by(COMUNA) %>% 
                    summarise(suma_contactos = sum(total))

casos_por_comuna


# voy a unir mis dos df para trabajar:

casos_por_comuna <- left_join(casos_por_comuna,df_poblacion)


# ¿ qué te preguntarías sobre este nuevo dataframe?

# Graficar la/las relaciones existentes para entender la información. 
# Podes crear tantos gráficos como opciones de formato se te ocurran.



# Creamos otro df, agregando más información (TIPO_PRESTACIÓN)

casos_por_comuna_y_tipo <- df_comunas %>% 
                           group_by(COMUNA, TIPO_PRESTACION) %>% 
                           summarise(suma_contactos = sum(total) ) %>% 
                           left_join(df_poblacion)

casos_por_comuna_y_tipo


# ¿qué preguntas te harías a partir de este nuevo df?

# Graficar las relaciones que más te interese conocer entre las variables.
# Poder usar gráfico de dispersión, de barras, histogramas, etc, con el formato que prefieras hacer.

# Crear un nuevo dataframe, que contenga el periodo, tipo de prestación y  cantidad de contactos por mes.
# A partir de este nuevo df, analizar y graficar lo que plantees respecto a la relación entre estas variables. 

