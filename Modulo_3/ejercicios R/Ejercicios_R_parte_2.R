############################################################################################################
############################################################################################################
############################################################################################################

### EXPLORACI�N Y LIMPIEZA DE DATOS ###

############################################################################################################
############################################################################################################
############################################################################################################

# Chequeo d�nde estoy ubicadO

getwd()
setwd("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python")


# Levanto la Base

df_comunas <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_suaci_comunas_ejercicios.csv", sep = ',', header = TRUE)

# llamo a la librer�a

library(tidyverse)

# podemos revisar la estructura y algunas estadisticas descriptivas del df

str(df_comunas)

summary(df_comunas)

# Levanto otro dataset para tener la poblaci�n de cada comuna

df_poblacion <- read.csv("C:/Users/yanin/Desktop/CURSO DATA-SCIENCE/intro a R y Python/gcba_pob_comunas_17.csv", sep = ',', header = TRUE)


# Tambi�n revisamos qu� tiene el df:

str(df_poblacion)

summary(df_poblacion)


# Creamos un nuevo df con agrupamiento para ver cantidad de cconsultas

casos_por_comuna <- df_comunas %>% 
                    group_by(COMUNA) %>% 
                    summarise(suma_contactos = sum(total))

casos_por_comuna


# voy a unir mis dos df para trabajar:

casos_por_comuna <- left_join(casos_por_comuna,df_poblacion)


# � qu� te preguntar�as sobre este nuevo dataframe?

# Graficar la/las relaciones existentes para entender la informaci�n. 
# Podes crear tantos gr�ficos como opciones de formato se te ocurran.



# Creamos otro df, agregando m�s informaci�n (TIPO_PRESTACI�N)

casos_por_comuna_y_tipo <- df_comunas %>% 
                           group_by(COMUNA, TIPO_PRESTACION) %>% 
                           summarise(suma_contactos = sum(total) ) %>% 
                           left_join(df_poblacion)

casos_por_comuna_y_tipo


# �qu� preguntas te har�as a partir de este nuevo df?

# Graficar las relaciones que m�s te interese conocer entre las variables.
# Poder usar gr�fico de dispersi�n, de barras, histogramas, etc, con el formato que prefieras hacer.

# Crear un nuevo dataframe, que contenga el periodo, tipo de prestaci�n y  cantidad de contactos por mes.
# A partir de este nuevo df, analizar y graficar lo que plantees respecto a la relaci�n entre estas variables. 

