#
# tabela Veiculos Json
#
setwd("E:/Documents/CICLO/Mestrado/PROJETO/dados/URBS/2017_01_18_veiculos.json.tar/")
require(rjson)
rm(list=ls())
#r1 <- rjson::fromJSON(r2[2])
r2 <- readLines(con = "veiculos.json")
r1 <- data.frame("VEIC"=NULL,"LAT"=NULL,
                 "LON"=NULL,"DTHR"=NULL,
                 "COD_LINHA"=NULL)
for(i in 2:length(r2)){
  aux <- rjson::fromJSON(r2[i],simplify = F) 
  aux1 <- data.frame("VEIC"=aux$VEIC,
                     "LAT"=aux$LAT,
                     "LON"=aux$LON,
                     "DTHR"=aux$DTHR,
                     "COD_LINHA"=aux$COD_LINHA)
  r1 <- rbind(r1,aux1)
}
sprintf("[[",raw_data1[2])

readLines(raw_data)
sprintf("%f", pi)
sprintf("%.3f", pi)
sprintf("%1.0f", pi)
sprintf("%5.1f", pi)
sprintf("%05.1f", pi)
sprintf("%+f", pi)
sprintf("% f", pi)
sprintf("%-10f", pi) # left justified
sprintf("%e", pi)
sprintf("%E", pi)
sprintf("%g", pi)
sprintf("%g",   1e6 * pi) # -> exponential
sprintf("%.9g", 1e6 * pi) # -> "fixed"
sprintf("%G", 1e-6 * pi)

sprintf("%s is %f feet tall\n", "Sven", 7.1)  
sprintf(paste(raw_data1[2],collapse=","))
require(stringr)
str_extract_all(raw_data1[2],simplify = T)
str_remove_all(raw_data1[2],pattern = c(":",","))

















