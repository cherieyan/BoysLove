###  NINEMANGA ####
#Extraer informacion de libreria rvest
library('rvest')

#Estraer links de las primeras 100 pasginas de ninemanga
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
for(i in 1:5){
  print(paste("Link ->",resultMangas[[i]],sep=""))
  Descargas2<-read_html(resultMangas[[i]])
  ContGenero<-html_nodes(Descargas2,"message.genre")
  genero2<-html_text(ContGenero)
  Generos<-c(Generos, genero2)
}

print(Generos)

