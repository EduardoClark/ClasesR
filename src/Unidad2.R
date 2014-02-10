#######################
### Capacitación R
### Autor: Eduardo Clark
### Fecha: Febrero 2014
### Unidad 2
#######################

##################### Sección A #################################


#Para nuestros efectos la unidad básica de datos que usaremos en R será el vector y la unidad de agregación que define nuestras bases sera el Data.Frame.
#Empecemos por ver la estructura de los datos que hemos cargado


#Un vector es una serie de valores todos con una estructura similar.
#Pueden ser números enteros, números con decimal, caracteres (cadenas), fechas,  etc… 

#Un dataframe es una serie de vectores  donde cada fila corresponde a una observación ordenada.


ObjetoNumerico <- 1 
ObjetoCaracter <- "Hello World"  ### Los caracteres van entre comillas "xxxxx"
ObjetoFactor <- as.factor(c("Hello World", "FOO"))
VectorNumerico <- 1:26
VectorCaracter <- letters
Lista1 <- list(ObjetoNumerico, ObjetoCaracter, ObjetoFactor) #### Las listas de diferente tipo y tamaño
DF <- data.frame(Numeros=VectorNumerico, Letras=VectorCaracter) #### Un data frame puede incluir vectores de diferentes tipos pero todos necesitan tener la misma longitud
VectorNumerico2 <- 26:1
DF$Numeros2 <- VectorNumerico2 ### El signo "$" se usa para asignar o llamar un objeto dentro de un DF
DF$Numeros3 <- (DF$Numeros + DF$Numeros2)  / 2 
DF$MenorA13 <- c(TRUE, FALSE)
Lista1[2] ### Los corchetes se usan para llamar a un objecto dentro de una lista o DF. Se usa el numero del objeto

# Maneras de acceder a los valores de un objeto

DF$Letras ### $ selecciona columnas de un DF por nombre
DF[2] ### Selecciona columnas de un DF por numero de Columna
VectorCaracter[3] ### En un vector [X] selecciona el elemento X
DF[[2]][3] ###[[X]][Y] Seleciona el elemento Y en la Columna X de un DF
DF$Letras[3]

DF[2,2] ##Para un DF podemos encontrar los valores usando coordenadas [Fila, Columna] 
DF[2,] ## Fila 2
DF[,2] ## Columna 2

DF$Letras <- as.character(DF$Letras)
DF[2,2] <- "Prueba"
DF
DF$Numeros[DF$Numeros > 10] <- 100
DF$Numeros[DF$Numeros == 9] <- 5
DF

data.entry(DF)

remove(list=ls()) # Remueve los objetos guardados en el espacio de trabajo

#Resumiendo:
# R esta basando en objetos, estos pueden ser de varios tipos
#     - Vectores (numericos, caracteres, factores, logicos)
#     - listas, incluyen objetos de distintos tipos sin importar las dimensiones
#     - DataFrames, incluyen objetos(vectores) de distintos tipos pero con la misma longitud
#     - Matrices, muy parecidos a los DFs pero con objetos numericos unicamente


##################### Sección B #################################

#Lo más importante para el análisis de datos son, lógicamente, los datos iniciales.
#Para empezar, primero tenemos que cargarlos a nuestro espacio de trabajo.

#El formato más común de datos es el conocido como CSV (Valores Delimitados por Comas). 
#Básicamente un documento de texto. Una de las maneras más eficientes para almacenar datos

##Muchas opciones pero 3 basicas
ArmaDeFuego <- read.csv("data/MuertesArmasDeFuego.csv") ###Para archivos .csv
ArmaDeFuego1 <- read.table("data/MuertesArmasDeFuego") ### Para mucho tipo de archivos, por ejemplo .dat
#Paises <-  ldply(readHTMLTable(doc="http://en.wikipedia.org/wiki/List_of_countries", encoding="utf-8")[1])

##Opciones de lectura
read.table()
read.csv()
read.csv("", header=FALSE) #Cuando la base no tiene nombres de columnas
read.csv("", sep="-") # Cuando el separador no es una coma, aquí espeficamos que es
read.csv("")


#Pero siempre encontraremos por ahí otros formatos. 
#Por ejemplo: xls, dta, dbf, sav

read.xls()
read.dta()
read.dbf()
read.spss()

remove(ArmaDeFuego1, Paises)

##################### Sección C #################################

#Uno de los atractivos de R es poder guardar cualquier resultado de una operación
#como un objeto

#Basicas

MediaEdad <- mean(ArmaDeFuego$age_in_units, na.rm=TRUE) ### Saquemos la media de edad de las actas de defunción
MedianaAnioNacimiento <- median(ArmaDeFuego$year_birth) ### Saquemos la mediana de año de defunción


#### Podemos crear un nuevo marco de datos en el cual vemos el promedio de edad de defuncíon en cada estado
MediaEdadXEstado <- ldply(tapply(X=as.numeric(ArmaDeFuego$age_in_units), INDEX=ArmaDeFuego$abbrev, mean))
MediaEdadXEstado <- arrange(MediaEdadXEstado, MediaEdadXEstado$.id)
colnames(MediaEdadXEstado) <- c("Estado", "EdadMediaDefuncion")


MatrixEstadistica <- read.delim("Data/MatrizEstadistica.csv")
head(MatrixEstadistica)
View(MatrixEstadistica)

MatrixEstadistica <- merge(MatrixEstadistica, MediaEdadXEstado,by=1, all.x=TRUE, all.y=FALSE)

