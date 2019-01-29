### _NINEMANGA_ ###
library('rvest')

#Extraccion de los mangas de las primeras 100 paginas de resultados
resultMangas <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerdescargas<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  ConteMangas<-html_nodes(Leerdescargas, '.bookname')
  Linksmangas<-html_attr(ConteMangas,"href")
  resultMangas<-c(resultMangas, Linksmangas)
}

print(resultMangas)



#Extraccion de los titulos
titulos <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerlinks<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Contenido2<-html_nodes(Leerlinks, '.bookname')
  Linkmangas2<-html_text(Contenido2)
  titulos<-c(titulos, Linkmangas2)
}


#Extraccion de las visitas
views <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerlinks3<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Contenido3<-html_nodes(Leerlinks3, '.bookinfo > dd > span')
  Linkmangas3<-html_text(Contenido3)
  views<-c(views, Linkmangas3)
}

#Extraccion de los generos
Generos <-list()
for(i in 1:length(resultMangas)){
  print(paste("Link ->",resultMangas[[i]],sep=""))
  Descargas2<-read_html(resultMangas[[i]])
  ContGenero<-html_nodes(Descargas2,"[itemprop=genre]")
  genero2<-html_text(ContGenero)
  Generos<-c(Generos, genero2)
}



#Data frame de titulos
unlistTitulostitulos <- unlist(titulos)
tablatitulos<- table(unlistTitulostitulos)
titulosname <- as.data.frame(tablatitulos)


#Data frame de views
unlistTitulosviews <- unlist(views)
unlistTitulosviews <- gsub(",","",unlistTitulosviews)
unlistTitulosviews <- gsub("views","",unlistTitulosviews)

tablaviews<- table(as.numeric(unlistTitulosviews))
titulosviews <- as.data.frame(tablaviews)


# Generando data de titulos y views
DATOS <- data.frame(TITULO = unlistTitulostitulos, VISITAS = as.numeric(unlistTitulosviews))


#Data frame de generos
unlistTitulosgenero <- unlist(Generos)
unlistTitulosgenero <- gsub("Género","",unlistTitulosgenero)
unlistTitulosgenero <- gsub("[()]","",unlistTitulosgenero)
unlistTitulosgenero <- gsub("[:]","",unlistTitulosgenero)
unlistTitulosgenero <- gsub("\n","-",unlistTitulosgenero)


# Generando data de titulos views y genero
DATOS2 <- data.frame(TITULO = unlistTitulostitulos[1:2458], VISITAS = as.numeric(unlistTitulosviews)[1:2458], GENERO = unlistTitulosgenero)
write.csv(DATOS2,file="Tabla1.csv")


#Separando por espacio los generos y pasando a minuscula
unlistgeneros2 <- unlist(Generos)
unlistgeneros2 <- gsub("Género","",unlistgeneros2)
unlistgeneros2 <- gsub("[()]","",unlistgeneros2)
unlistgeneros2 <- gsub("[:]","",unlistgeneros2)
unlistgeneros2 <- gsub("\n","-",unlistgeneros2)

unlistgeneros2 <- strsplit(unlistgeneros2,"-")
unlistgeneros2 <- tolower(unlistgeneros2)


print(unlistgeneros2)

#unificar generos
totalgeneros <- ""
for(i in 1:length(unlistgeneros2)){
  totalgeneros<-paste(totalgeneros," ",unlistgeneros2[[i]])
}

print(totalgeneros)

#Tabla para extraer generos
contgenre <- unlist(totalgeneros)
tablagenre <- table(contgenre)

dfGenero <- as.data.frame(tablagenre)


grafico_view <- ggplot(DATOS, aes(TITULO, VISITAS)) +
  geom_bar(stat = "identity",fill = rgb(0.2, 0.2, 1, 0.3), color = "blue") +
  coord_flip() + 
  theme_minimal()


#no salio
grafico_genero <- ggplot(datos, aes(unlistTitulosgenero, Var1)) +
  geom_bar(stat = "identity",fill = rgb(0.2, 0.2, 1, 0.3), color = "blue") +
  coord_flip() + 
  theme_minimal()
