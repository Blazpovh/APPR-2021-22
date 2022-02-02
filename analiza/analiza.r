# 4. faza: Napredna analiza podatkov
setwd("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/")
data_tidy<-read.table("podatki/zdruzeni_podatki/data_tidy.txt",sep=" ")

dnevna_poraba <-rowSums(data_tidy[ ,3:98],is.na(data_tidy) == FALSE)
length(dnevna_poraba)
porabniki  <-  labels(table(data_tidy$porabnik))[[1]]

povpr_poraba=c()
for (i in 1:length(porabniki)){
  print(i)
  poraba=dnevna_poraba[data_tidy$porabnik==porabniki[i]]
  povpr_poraba[i]=mean(poraba)
}
frekvenca <- c(1:51)
data_povpr_poraba <- data.frame(povpr_poraba,frekvenca)

pdf("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/analiza/prikaz_skupne_povprecne_porabe_za_razlicne_porabnike.pdf")
chol <- data_povpr_poraba
qplot(chol$povpr_poraba, 
      geom = "histogram",
      binwidth= 40,
      main = "Povprecna poraba el. energije za razlicne porabnike",
      xlab = "Povprecna poraba",
      ylab = "Frekvenca",
      ylim = c(0,10))
dev.off()
jpeg("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/prikaz_skupne_povprecne_porabe_za_razlicne_meritve.jpg")
Tabela_delovnih_dni <- filter(data_tidy, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(data_tidy)== FALSE)
p3 <-plot(meritev3, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za razlicne tipe dni",xaxt='n')
meritev1 <- colMeans(data_tidy[ , 3:98 ],is.na(data_tidy)== FALSE)
p1 <-points(meritev1, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za razl. meritve",xaxt='n',col="blue")
Tabela_prostih_dni <- filter(data_tidy, Prosti_dan == "TRUE")
meritev2 <- colMeans(Tabela_prostih_dni[ , 3:98 ],is.na(data_tidy)== FALSE)
p2 <-points(meritev2, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za proste dni",xaxt='n',col="red")
Tabela_delovnih_dni <- filter(data_tidy, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(data_tidy)== FALSE)
p3 <-points(meritev3, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za delavne dni",xaxt='n',col="green")
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
legend(title = "Legenda", legend = c("vsi dnevi","prosti dnevi","delovni dnevi"),"topright",col = c("blue","red","green"),lty = 1)
dev.off()

pdf("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/analiza/prikaz_skupne_povprecne_porabe_za_proste_dni.pdf")
Tabela_prostih_dni <- filter(data_tidy, Prosti_dan == "TRUE")
meritev2 <- colMeans(Tabela_prostih_dni[ , 3:98 ],is.na(data_tidy)== FALSE)
p2 <-plot(meritev2, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za proste dni",xaxt='n')
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
dev.off()

pdf("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/analiza/prikaz_skupne_povprecne_porabe_za_delovne_dni.pdf")
Tabela_delovnih_dni <- filter(data_tidy, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(data_tidy)== FALSE)
p3 <-plot(meritev3, type = "o",pch = 20, xlab="cas",ylab = "povprecna poraba",main = "Graf povprecne poraba el. energije za delavne dni",xaxt='n')
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
dev.off()

jpeg("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/prikaz_skupne_povprecne_porabe_za_razlicne_dneve.jpg")
par(mar=c(5,6,4,1)+.0001)
plot(c(0,97),c(0.5,4),main="Povprecna poraba za dneve v tednu",type = "n",pch=20, xlab = "cas", ylab = "povprecna poraba",xaxt='n')
povpr_poraba_ponedeljek <- colMeans(filter(data_tidy, Ime_dneva =="Monday")[ ,3:98])
graf_ponedeljek <- points(povpr_poraba_ponedeljek,type = "o",pch=20,xaxt='n',col="black")
povpr_poraba_torek <- colMeans(filter(data_tidy, Ime_dneva =="Tuesday")[ ,3:98])
graf_torek <- points(povpr_poraba_torek, type = "o",pch=20,xaxt='n',col="red")
povpr_poraba_sreda <- colMeans(filter(data_tidy, Ime_dneva =="Wednesday")[ ,3:98])
graf_sreda <- points(povpr_poraba_sreda, type = "o",pch=20,xaxt='n',col="blue")
povpr_poraba_cetrtek <- colMeans(filter(data_tidy, Ime_dneva =="Thursday")[ ,3:98])
graf_cetrtek <- points(povpr_poraba_cetrtek, type = "o",pch=20,xaxt='n',col="green")
povpr_poraba_petek <- colMeans(filter(data_tidy, Ime_dneva =="Friday")[ ,3:98])
graf_petek <- points(povpr_poraba_petek, type = "o",pch=20,xaxt='n',col="orange")
povpr_poraba_sobota <- colMeans(filter(data_tidy, Ime_dneva =="Saturday")[ ,3:98])
graf_sobota <- points(povpr_poraba_sobota, type = "o",pch=20,xaxt='n',col="yellow")
povpr_poraba_nedelja <- colMeans(filter(data_tidy, Ime_dneva =="Sunday")[ ,3:98])
graf_nedelja <- points(povpr_poraba_nedelja, type = "o",pch=20,xaxt='n',col="purple")
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
legend(title = "Legenda", legend = c("ponedeljek","torek","sreda","cetrtek","petek","sobota","nedelja"),"topright",col = c("black","red","blue","green","orange","yellow","purple"),lty=1)
dev.off()


# *********************************************** 
# od tu naprej imam analizo za vremenske podatke
# **********************************************
data_vreme2_tidy <- read.table("podatki/zdruzeni_podatki/data_vreme2_tidy.txt",sep=" ")
datumi <- (data_vreme2_tidy$datum)
padavine_po_dnevih <- data.frame(rowSums(data_vreme2_tidy[ ,4:51], is.na(data_vreme2_tidy) == FALSE))
colnames(padavine_po_dnevih) <- c('Kolicina padavin za dan')
rownames(padavine_po_dnevih) <-c(datumi)
write.table(padavine_po_dnevih,"podatki/zdruzeni_podatki/padavine_po_dnevih.txt",sep=" ")

temperature_po_dnevih <- data.frame(rowMeans(data_vreme2_tidy[ ,52:99], is.na(data_vreme2_tidy) == FALSE))
colnames(temperature_po_dnevih) <- c('Skupna temperatura za dan')
rownames(temperature_po_dnevih) <-c(datumi)
write.table(temperature_po_dnevih,"podatki/zdruzeni_podatki/temperature_po_dnevih.txt",sep=" ")

padavine_po_urah <- data.frame(colSums(data_vreme2_tidy[ ,4:51]))
colnames(padavine_po_urah) <- c('Povprecna kol padavina za to uro')
write.table(padavine_po_urah,"podatki/zdruzeni_podatki/padavine_po_urah.txt",sep=" ")

temperature_po_urah <- data.frame(colMeans(data_vreme2_tidy[ ,52:99], is.na(data_vreme2_tidy) == FALSE))
colnames(temperature_po_urah) <- c('Povprecna temperatura za vsako casovno obdobje')
write.table(temperature_po_urah,"podatki/zdruzeni_podatki/temperature_po_urah.txt",sep=" ")


# *************************************************
# Korelacije
# *************************************************
povpr_poraba_za_vsak_dan <-rowMeans(data_tidy[ ,3:98])
povpr_poraba_matrika <- t(matrix(povpr_poraba_za_vsak_dan,198,51))
povpr_poraba_za_vsak_dan1 <- as.vector(colSums(povpr_poraba_matrika))
povpr_poraba_za_vsak_dan1<-povpr_poraba_za_vsak_dan1[-198]
povprecna_T_za_vsak_dan <- temperature_po_dnevih$`Skupna temperatura za dan`
skupne_padavine_za_vsak_dan <- padavine_po_dnevih$`Kolicina padavin za dan`
r12=cor(povpr_poraba_za_vsak_dan1,povprecna_T_za_vsak_dan)
r13=cor(povpr_poraba_za_vsak_dan1,skupne_padavine_za_vsak_dan)

# ***********************************************
# Napovedni model
# **********************************************
n <- 3 #stopnja polinoma za aproksimacijo
A <- matrix(c(1,0,0,0,1,1,1,1,1,2,4,8,1,3,9,27), nrow = 4)
m <- length(povpr_poraba_za_vsak_dan1)
t <- matrix(0,length(povpr_poraba_za_vsak_dan1),1)
t[1:(n+1)] = povpr_poraba_za_vsak_dan1[1:(n+1)]
  for (i in ((n+2):m)) {
    p = solve(t(A), povpr_poraba_za_vsak_dan1[(i-n-1):(i-1)])
    t[i,]<- p[1] + p[2]*(n+1)+ p[3]*(n+1)^2 +p[4]*(n+1)^3
  }

n1 <- 4 #stopnja polinoma za aproksimacijo
A1 <- matrix(c(1,1,1,1,1,0,1,2,3,4,0,1,4,9,16,0,1,8,27,64,0,1,16,81,256), nrow = 5)
m1 <- length(povpr_poraba_za_vsak_dan1)
t1 <- matrix(0,length(povpr_poraba_za_vsak_dan1),1)
t1[1:(n1+1)] = povpr_poraba_za_vsak_dan1[1:(n1+1)]
for (i in ((n1+2):m1)) {
  pi = solve(A1, povpr_poraba_za_vsak_dan1[(i-n1-1):(i-1)])
  t1[i,]<- pi[1] + pi[2]*(n1+1)+ pi[3]*(n1+1)^2 +pi[4]*(n1+1)^3 +pi[5]*(n1+1)^4
}


n2 <- 2 #stopnja polinoma za aproksimacijo
A2 <- matrix(c(1,1,1,0,1,2,0,1,4), nrow = 3)
m2 <- length(povpr_poraba_za_vsak_dan1)
t2 <- matrix(0,length(povpr_poraba_za_vsak_dan1),1)
t2[1:(n2+1)] = povpr_poraba_za_vsak_dan1[1:(n2+1)]
for (i in ((n2+2):m2)) {
  pi = solve(A2, povpr_poraba_za_vsak_dan1[(i-n2-1):(i-1)])
  t2[i,]<- pi[1] + pi[2]*(n2+1)+ pi[3]*(n2+1)^2 
}

c <- povpr_poraba_za_vsak_dan1
c_napovedan1 <- t
c_napovedan2 <- t1
c_napovedan3 <- t2
slika_aproksimacije <-plot(c, type = "o",pch = 20,col="black")
#aproksimacija <- points(c_napovedan1,type = "o",pch = 20, ,col="blue")
#aproksimacija1 <- points(c_napovedan2,type = "o",pch = 20, ,col="red")
zgornja_meja <- max(max(c_napovedan3),max(c))
jpeg("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/prikaz_skupne_natancnosti_napovednega_modela.jpg")
default <- c(5,2,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0),family="serif") #axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
title="Povprecna poraba in njena napoved"
plot(c(0,200), c(0,zgornja_meja),yaxt='n',xaxt='n',main=title, type = "n", pch=19,cex.lab=1.2, cex.axis=1.3, cex.main=1.5,xlab = "Dnevi",ylab = "Povprecna poraba")  # setting up coord. system
xlabels=c(1:10)*20
axis(side=1,at=xlabels,labels=xlabels)
#axis(side=2,at=c(0:5)*20,labels=as.factor(c(0:5)*20))
lines(c, type = "o", col = "red",lwd=2,cex = 1,pch=16)
lines(c_napovedan3, type = "o", col = "green",lwd=2,cex = 1,pch=16)
# lines(c_napovedan1, type = "o", col = "blue",lwd=2,cex = 1,pch=16)
legend(5, zgornja_meja, legend=TeX(c("Dejanska poraba","Napovedana poraba")), pch=c(16,16),cex=c(1,1),col=c("red","green"),y.intersp=1.5)
dev.off()


# ***************************************************
# Grupiranje rezultatov
# ***************************************************
povpr_poraba_za_vsak_dan <-rowMeans(data_tidy[ ,3:98])
povpr_poraba_matrika <- t(matrix(povpr_poraba_za_vsak_dan,198,51))
set.seed(123)
klas <- kmeans(povpr_poraba_matrika,5)
klasifikacija <- klas$cluster
povpr_poraba_matrika1 <- cbind(povpr_poraba_matrika, klasifikacija)

M=max(max(povpr_poraba_matrika1[,1:198]))
m=min(min(povpr_poraba_matrika1[,1:198]))

Tabela_razred1 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "1",1:198]
Tabela_razred2 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "2",1:198]
Tabela_razred3 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "3",1:198]
Tabela_razred4 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "4",1:198]
Tabela_razred5 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "5",1:198]

jpeg("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/prikaz_povprecne_porabe_za_razlicne_razrede.jpg")
mar.default <- c(5,2,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0),family="serif") #axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
title="Povprecna poraba za razlicne razrede porabnikov"
plot(c(0,199), c(0,60),yaxt='n',xaxt='n',main=title, type = "n", pch=19,cex.lab=1.2, cex.axis=1.3, cex.main=1.5,xlab = "Dnevi",ylab = "Povprecna poraba")  # setting up coord. system
xlabels=c(1:19)*10
axis(side=1,at=xlabels,labels=xlabels)
axis(side=2,at=c(0:5)*20,labels=as.factor(c(0:5)*20))
lines(colSums(Tabela_razred1), type = "l", col = "black",lwd=2,cex = 1,pch=16)
lines(colSums(Tabela_razred2), type = "l", col = "red",lwd=2,cex = 1,pch=16)
lines(Tabela_razred3, type = "l", col = "blue",lwd=2,cex = 1,pch=16)
lines(colSums(Tabela_razred4), type = "l", col = "green",lwd=2,cex = 1,pch=16)
lines(colSums(Tabela_razred5), type = "l", col = "orange",lwd=2,cex = 1,pch=16)
legend("top", legend=TeX(c("Sk1","Sk2","Sk3","Sk4","Sk5")), pch=c(16,16),cex=c(1,1),col=c("black","red","blue","green","orange"),y.intersp=1.5,horiz=T)
dev.off()


