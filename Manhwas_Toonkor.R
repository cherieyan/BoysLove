#### TOONKOR.la####

library ('rvest')
paginaCOREANA<-("https://toonkor.la/%EB%AC%B4%EB%A3%8C%EC%9B%B9%ED%88%B0?fil=%EC%84%B1%EC%9D%B8")

# Inicializando la var de archivo con el nombre de la página a utilizar

# Leyendo el html del archivo
webpageCOREANA <- read_html(paginaCOREANA)

# Extraccion del texto contenido en la clase section-item 
contenidoCOREANO <- html_nodes(webpageCOREANA,'.section-item')

#Visualizando el contenido
print (contenidoCOREANO)

#Extrayendo contenido de la clase toon_gen
tagsCOREANO <- html_nodes(webpageCOREANA,'.toon_gen')

#Pasando a texto el contenido
categoriaCOREANO <- html_text(tagsCOREANO)

#Quitando signo \r\n
categoriaCOREANO <- gsub("\r\n","",categoriaCOREANO)

#Cambiando / por -
categoriaCOREANO <- gsub("/","-",categoriaCOREANO)

#Cambiando - por " "
categoriaCOREANO <- gsub("-"," ",categoriaCOREANO)

#Quitando espacios " "
categoriaCOREANO <- gsub((" "),"",categoriaCOREANO)

#Separando palabras por " "
categoriass <- strsplit(categoriaCOREANO," ")

#Haciendo una lista con palabras
unlistCategoria <- unlist(categoriass)

#Haciendo tabla
tablaCATEGORIA <- table(unlistCategoria)

#Uniendo informacion
dfCATEGORIA <- data.frame(tablaCATEGORIA)

#Contando frecuencia
categoriass <- unique(categoriass)


