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
DATOS2 <- data.frame(TITULO = unlistTitulostitulos[1:2000], VISITAS = as.numeric(unlistTitulosviews)[1:2000], GENERO = unlistTitulosgenero[1:2000])
write.csv(DATOS2,file="Tabla1.csv")


#### Contando los generos ###
Genre2 <- list()
for(i in 1:length(resultMangas)){
  Genre2 <- c(Genre2,genero2)
}

#unificar generos
totalgeneros <- ""
for(i in 1:length(Genre2)){
  totalgeneros<-paste(totalgeneros," ",Genre2[[i]])
}

print(totalgeneros)

totalgeneros <- gsub("Género","",totalgeneros)
totalgeneros <- gsub("[()]","",totalgeneros)
totalgeneros <- gsub("[:]","",totalgeneros)
totalgeneros <- gsub("\n","-",totalgeneros)

totalgeneros <- strsplit(totalgeneros,"-")[[1]]
totalgeneros <- tolower(totalgeneros)
totalgeneros <- strsplit(totalgeneros,",")[[1]]


contgenre <- unlist(totalgeneros)

tablagenre <- table(contgenre)

dftablaGeneros <- as.data.frame(tablagenre)



###Grafico
library("ggplot2")

dftablaGeneros %>%
  ggplot()+
  aes(x=contgenre, y=Freq) +
  geom_bar (stat="identity")
