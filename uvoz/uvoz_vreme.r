setwd("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/")
source("lib/libraries.r")
N=199*51
data_vreme_tidy <- data.frame(datum=character(N),kraj = character(N),porabnik=numeric(N),padavine=matrix(0,N,48),temperatura=matrix(0,N,48))
Ncust1=50
cunt=1
for (w in c(1:Ncust1)) {
  print(w)
  data_w <- fromJSON(file=paste0("podatki/weather/weather_",w,"_2021-01-01_2021-12-31.json"),method = "R")
  for (l in c(1:(length(data_w)-1))) {
    if (data_w[[l]]$date != "2021-03-28"){
      dolzina_padavine <- length(data_w[[l]]$precipitation)
      dolzina_temperatura <- length(data_w[[l]]$temperature)
      if(dolzina_padavine > 0){
        data_vreme_tidy[cunt, 4:(dolzina_padavine+3)]=data_w[[l]]$precipitation
      }
      data_vreme_tidy$datum[cunt]=data_w[[l]]$date 
      data_vreme_tidy$porabnik[cunt]=w
      data_vreme_tidy$kraj[cunt]=data_w[[l]]$title
      if(dolzina_temperatura > 0){
        data_vreme_tidy[cunt, 52:(dolzina_temperatura+51)]=data_w[[l]]$temperature
      }
      cunt=cunt + 1
    }
  }
}
 data_vreme1_tidy <- data_vreme_tidy[!duplicated(data_vreme_tidy[c(1,2)]),] 
data_vreme2_tidy <- data_vreme1_tidy[-198, ]
write.table(data_vreme_tidy,"podatki/zdruzeni_podatki/data_vreme_tidy.txt",sep=" ")
write.table(data_vreme2_tidy,"podatki/zdruzeni_podatki/data_vreme2_tidy.txt",sep=" ")
