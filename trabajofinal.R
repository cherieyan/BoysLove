#### TOONKOR.la####

library ('rvest')
paginaCHINA<-("https://toonkor.la/%EB%AC%B4%EB%A3%8C%EC%9B%B9%ED%88%B0?fil=%EC%84%B1%EC%9D%B8")

# Inicializando la var de archivo con el nombre de la página a utilizar

# Leyendo el html del archivo
webpageCOREANA <- read_html(paginaCHINA)

# Extraccion del texto contenido en la clase section-item 
contenidoCHINO <- html_nodes(webpageCOREANA,'.section-item')

#Visualizando el contenido
print (contenidoCHINO)

#Extrayendo contenido de la clase toon_gen
tagsCHINO <- html_nodes(webpageCOREANA,'.toon_gen')

#Pasando a texto el contenido
categoriaCHINA <- html_text(tagsCHINO)
#Quitando signo \r\n
categoriaCHINA <- gsub("\r\n","",categoriaCHINA)

#Cambiando / por -
categoriaCHINA <- gsub("/","-",categoriaCHINA)
#Cambiando - por " "
categoriaCHINA <- gsub("-"," ",categoriaCHINA)
#Quitando espacios " "
categoriaCHiNA <- gsub((" "),"",categoriaCHINA)
#Separando palabras por " "
categoriass <- strsplit(categoriaCHINA," ")
#Haciendo una lista con palabras
unlistCategoria <- unlist(categoriass)
#Haciendo tabla
tablaCATEGORIA <- table(unlistCategoria)
#Uniendo informacion
dfCATEGORIA <- data.frame(tablaCATEGORIA)
#Contando frecuencia
categoriass <- unique(categoriass)


