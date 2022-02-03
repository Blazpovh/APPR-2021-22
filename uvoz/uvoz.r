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

