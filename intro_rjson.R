#
#
#
rm(list=ls())
library(rjson)
library(sp)
library(maptools)
library(leaflet)
setwd("E:/Documents/CICLO/Mestrado/PROJETO/dados/URBS/")
lista <- list.dirs(full.names = F,recursive = F)
linhas <- fromJSON(file = paste0(lista[1],"/",list.files(lista[1],pattern = ".json")[2]))
pois <-fromJSON(file = paste0(lista[2],"/",list.files(lista[2],pattern = ".json")[2]))
pontosLinha <- fromJSON(file = paste0(lista[3],"/",list.files(lista[3],pattern = ".json")[2]))
shapeLinha <- fromJSON(file = paste0(lista[4],"/",list.files(lista[4],pattern = ".json")[2]))
tabelaLinha <- fromJSON(file = paste0(lista[5],"/",list.files(lista[5],pattern = ".json")[2]))
tabelaVeiculo <- fromJSON(file = paste0(lista[6],"/",list.files(lista[6],pattern = ".json")[2]))
trechoItinerario <- fromJSON(file = paste0(lista[7],"/",list.files(lista[7],pattern = ".json")[2]))
veiculos <- fromJSON(file = "2017_01_18_veiculos.json.tar/2017_01_18_veiculos.json/veiculos.json",
                     unexpected.escape = "skip",simplify = TRUE)
break()
linhas[[1]]
pois[[3]]
pontosLinha[[1]]
shapeLinha[[1]] # pode ser util!!!
tabelaLinha[[2]] # horarios de chegada e saida de pontos
trechoItinerario[[1]] # distancia total do trecho
tabelaVeiculo[[1]]
veiculos[[1]]
#
#
dt_linhas <- as.data.frame(matrix(NA,ncol=4,nrow=length(shapeLinha)))
colnames(dt_linhas) <- c("COD","LON","LAT","DIST")
for(i in 1:length(shapeLinha)){
  dt_linhas$COD[i] <- shapeLinha[[i]]$COD
  dt_linhas$LON[i] <- shapeLinha[[i]]$LON
  dt_linhas$LAT[i] <- shapeLinha[[i]]$LAT
}

dt_linhas$DIST[1]<-0
for (i in 2:length(shapeLinha)){
  d <- as.matrix(dt_linhas[(i-1):i,2:3])
  dt_linhas$DIST[i]<- dist(d)
}
break()
#
# points to lines
dt_linhas$LAT <- as.numeric(dt_linhas$LAT)
dt_linhas$LON <- as.numeric(dt_linhas$LON)
#source("E:/Documents/CICLO/Mestrado/PROJETO/scripts/Rjson/points_to_lines.R")
a <- as.matrix(dt_linhas[,2:4])
a <- a[which(duplicated(a[,1])==F),]
a <- a[which(duplicated(a[,2])==F),]
ve <- (which(a[,3]>0.001)+1)
#a <- a[6:331,]
b <- SpatialPoints(coords = a[1000:7000,1:2],
                   proj4string = CRS("+proj=longlat +datum=WGS84"))
c <- SpatialLines(LinesList = list(Lines(list(Line(b)),"id")))
leaflet(data = c) %>%
  addTiles() %>%
  addPolylines()
break( )
paths <- sp::split(data, data[[]])
sp_lines <- SpatialLines(list(Lines(list(Line(paths[[1]])), "line1")))
for (p in 2:length(paths)) {
  id <- paste0("line", as.character(p))
  l <- SpatialLines(list(Lines(list(Line(paths[[p]])), id)))
  sp_lines <- spRbind(sp_lines, l)
}

