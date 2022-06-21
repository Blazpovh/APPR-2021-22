# 2. faza: Uvoz podatkov
#setwd("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/")
N=199
data_i_tidy<-data.frame(datum=character(N),porabnik=numeric(N),meritve=matrix(0,N,96))

Ncust=51
cnt=1
for (i in c(1:Ncust)) {
  print(i)
  data_i <- fromJSON(file=paste0("podatki/consumptions/consumptions_consumer_",i,"_2021-01-01_2021-12-31.json"),method = "R")
  for (j in c(1:length(data_i))) {
      x = data_i[[j]]$values
      if (length(x) < 96){
        x = as.numeric(c(x[1:8], rep("NA",96 - length(x)), x[9:length(x)]))
        x = na.approx(x, rule=2)
      }
      data_i_tidy[cnt, 3:98]=x
      data_i_tidy$datum[cnt]=data_i[[j]]$date 
      data_i_tidy$porabnik[cnt]=i
      cnt=cnt + 1
  }
}
write.table(data_i_tidy,"podatki/zdruzeni_podatki/data_tidy1.csv",sep=" ")


koledar_data <- read_csv("podatki/calendar_2021.csv", na =" ", locale=locale(encoding="Windows-1250"))
koledar_data_1 <- select(koledar_data, -c(dayHours,dayNum,index))
koledar_data_1 <-koledar_data[-c(87),]
print(koledar_data_1)
dnevni_podatki <- koledar_data_1$dayName
Ime_dneva <- rep(dnevni_podatki, times=Ncust)
datum <- as.character(koledar_data_1$date)
datumi <- as.character(rep(datumi, times=Ncust))
prosti_dnevi <- koledar_data_1$freeDay
Prosti_dan <- rep(prosti_dnevi, times=Ncust)
imena_dni_tabela <- data_frame(datum, dnevni_podatki, prosti_dnevi)
Tabela_porabe <- read.csv("~/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/podatki/zdruzeni_podatki/data_tidy1.csv", sep="")
Tabela_porabe1 <- left_join(Tabela_porabe, imena_dni_tabela, by='datum')
colnames(Tabela_porabe1)[99]<- "Ime_dneva"
colnames(Tabela_porabe1)[100]<- "Prosti_dan"
write.table(Tabela_porabe1,"podatki/zdruzeni_podatki/Tabela_porabe.csv",sep=" ")

Tabela_tidy<-Tabela_porabe1 %>% pivot_longer( meritve.1: meritve.96,names_to = "meritev",values_to = "poraba")
write.table(Tabela_tidy,"podatki/zdruzeni_podatki/Tabela_tidy.csv",sep=" ")
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
data_vreme1_tidy <- data_vreme_tidy[!duplicated(data_vreme_tidy[c(1,2)]),] 
data_vreme2_tidy <- data_vreme1_tidy[-198, ]
write.table(data_vreme_tidy,"podatki/zdruzeni_podatki/data_vreme_tidy.txt",sep=" ")
write.table(data_vreme2_tidy,"podatki/zdruzeni_podatki/data_vreme2_tidy.txt",sep=" ")

