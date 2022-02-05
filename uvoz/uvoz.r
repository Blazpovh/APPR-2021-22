# 2. faza: Uvoz podatkov
setwd("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/")
source("lib/libraries.r")
N=199
data_i_tidy<-data.frame(datum=character(N),porabnik=numeric(N),meritve=matrix(0,N,96))

Ncust=51
cnt=1
for (i in c(1:Ncust)) {
  print(i)
  data_i <- fromJSON(file=paste0("podatki/consumptions/consumptions_consumer_",i,"_2021-01-01_2021-12-31.json"),method = "R")
  for (j in c(1:length(data_i))) {
    if (data_i[[j]]$date != "2021-03-28"){
      data_i_tidy[cnt, 3:98]=data_i[[j]]$values
      data_i_tidy$datum[cnt]=data_i[[j]]$date 
      data_i_tidy$porabnik[cnt]=i
      cnt=cnt + 1
    }
  }
}


koledar_data <- read_csv("podatki/calendar_2021.csv", na =" ", locale=locale(encoding="Windows-1250"))
koledar_data_1 <- select(koledar_data, -c(dayHours,dayNum,index))
koledar_data_1 <-koledar_data[-c(87),]
print(koledar_data_1)
dnevni_podatki <- koledar_data_1$dayName
dnevni_podatki_1 <- rep(dnevni_podatki, times=Ncust)
prosti_dnevi <- koledar_data_1$freeDay
prosti_dnevi_1 <- rep(prosti_dnevi, times=Ncust)
data_i_tidy <- data_i_tidy %>%
  add_column(Prosti_dan =prosti_dnevi_1, Ime_dneva =dnevni_podatki_1)

write.table(data_i_tidy,"podatki/zdruzeni_podatki/data_tidy.txt",sep=" ")

# ***********************************************************************
# Uvoz vremenskih podatkov
# ***********************************************************************
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

