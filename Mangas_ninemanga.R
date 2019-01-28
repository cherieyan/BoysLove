install.packages("ggplot2")

###  NINEMANGA ####
#Extraer informacion de libreria rvest
library('rvest')
library(ggplot2)

#Extraer links de las primeras 100 pasginas de ninemanga
resultMangas <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerdescargas<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  ConteMangas<-html_nodes(Leerdescargas, '.bookname')
  Linksmangas<-html_attr(ConteMangas,"href")
  resultMangas<-c(resultMangas, Linksmangas)
}

#imprimir los links 
print(resultMangas)

#Extraer titulos de los mangas
titulo2 <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerlinks<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Contenido2<-html_nodes(Leerlinks, '.bookname')
  Linkmangas2<-html_text(Contenido2)
  titulo2<-c(titulo2, Linkmangas2)
}

#Imprimir titulos de los mangas
print(titulo2)

#Extraer numero de vistas de cada manga
views <-list()
for(i in 1:100){
  print(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Leerlinks3<-read_html(paste("http://es.ninemanga.com/category/index_",i,".html", sep= ""))
  Contenido3<-html_nodes(Leerlinks3, '.bookinfo > dd > span')
  Linkmangas3<-html_text(Contenido3)
  views<-c(views, Linkmangas3)
}

#Imprimir numero de visitas de cada manga
print(views)

#Extraer generos de cada manga 
Generos <-list()
for(i in 1:length(resultMangas)){
  print(paste("Link ->es",resultMangas[[i]],sep=""))
  Descargas2<-read_html(resultMangas[[i]])
  ContGenero<-html_nodes(Descargas2,"[itemprop=genre]")
  genero2<-html_text(ContGenero)
  Generos<-c(Generos, genero2)
}

#Imprimir generos
print(Generos)

#Cambiar n por ""
Generos <- gsub("\n","", Generos)
############## creando data frame de genero############
unlistTitulosgenero <- unlist(Generos)

tablagenero <- table(unlistTitulosgenero)

titulogeneros <- as.data.frame(tablagenero)

############# creando data frame nombres de animes ##############
unlistTitulostitulos <- unlist(titulo2)

tablatitulos<- table(unlistTitulostitulos)

titulosname <- as.data.frame(tablatitulos)

############# creando data frame views ###########
unlistTitulosviews <- unlist(views)
unlistTitulosviews <- gsub(",","",unlistTitulosviews)
unlistTitulosviews <- gsub("views","",unlistTitulosviews)

tablaviews<- table(as.numeric(unlistTitulosviews))

titulosviews <- as.data.frame(tablaviews)

#######uniendo tablas #############
datos=cbind.data.frame(tablagenero,tablatitulos[1:1099],tablaviews[1:1099])

# Generando una data para views 
DATOS <- data.frame(LINKS = Linksmangas, TITULO = unlistTitulostitulos, VISITAS = as.numeric(unlistTitulosviews))

write.csv(DATOS, file="TablaMangas.csv")
write.csv(datos, file="TablitaMangas.csv")


grafico_view <- ggplot(DATOS, aes(TITULO, VISITAS)) +
  geom_bar(stat = "identity",fill = rgb(0.2, 0.2, 1, 0.3), color = "blue") +
  coord_flip() + 
  theme_minimal()

#no salio

grafico_genero <- ggplot(datos, aes(unlistTitulosgenero, Var1)) +
  geom_bar(stat = "identity",fill = rgb(0.2, 0.2, 1, 0.3), color = "blue") +
  coord_flip() + 
  theme_minimal()