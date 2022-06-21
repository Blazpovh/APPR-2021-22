# 4. faza: Napredna analiza podatkov
Tabela_porabe1 <- read.csv("./podatki/zdruzeni_podatki/Tabela_porabe.csv", sep="")

dnevna_poraba <-rowSums(Tabela_porabe1[ ,3:98],is.na(Tabela_porabe1) == FALSE)
length(dnevna_poraba)
porabniki  <-  labels(table(Tabela_porabe1$porabnik))[[1]]

povpr_poraba=c()
for (i in 1:length(porabniki)){
  print(i)
  poraba=dnevna_poraba[Tabela_porabe1$porabnik==porabniki[i]]
  povpr_poraba[i]=mean(poraba)
}
frekvenca <- c(1:51)
data_povpr_poraba <- data.frame(povpr_poraba,frekvenca)

jpeg("./slike/prikaz_skupne_povprecne_porabe_za_razlicne_meritve.jpg")
Tabela_delovnih_dni <- filter(Tabela_porabe1, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p3 <-plot(meritev3, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za različne tipe dni",xaxt='n')
meritev1 <- colMeans(Tabela_porabe1[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p1 <-points(meritev1, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za razl. meritve",xaxt='n',col="blue")
Tabela_prostih_dni <- filter(Tabela_porabe1, Prosti_dan == "TRUE")
meritev2 <- colMeans(Tabela_prostih_dni[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p2 <-points(meritev2, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za proste dni",xaxt='n',col="red")
Tabela_delovnih_dni <- filter(Tabela_porabe1, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p3 <-points(meritev3, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za delavne dni",xaxt='n',col="green")
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
legend(title = "Legenda", legend = c("vsi dnevi","prosti dnevi","delovni dnevi"),"topright",col = c("blue","red","green"),lty = 1)
dev.off()

jpeg("./slike/prikaz_skupne_povprecne_porabe_za_proste_dni.jpg")
Tabela_prostih_dni <- filter(Tabela_porabe1, Prosti_dan == "TRUE")
meritev2 <- colMeans(Tabela_prostih_dni[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p2 <-plot(meritev2, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za proste dni",xaxt='n')
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
dev.off()

jpeg("./slike/prikaz_skupne_povprecne_porabe_za_delovne_dni.jpg")
Tabela_delovnih_dni <- filter(Tabela_porabe1, Prosti_dan == "FALSE")
meritev3 <- colMeans(Tabela_delovnih_dni[ , 3:98 ],is.na(Tabela_porabe1)== FALSE)
p3 <-plot(meritev3, type = "o",pch = 20, xlab="čas",ylab = "povprečna poraba",main = "Graf povprečne poraba el. energije za delavne dni",xaxt='n')
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
dev.off()

jpeg("./slike/prikaz_skupne_povprecne_porabe_za_razlicne_dneve.jpg")
par(mar=c(5,6,4,1)+.0001)
plot(c(0,97),c(0.5,4),main="Povprečna poraba za dneve v tednu",type = "n",pch=20, xlab = "čas", ylab = "povprečna poraba",xaxt='n')
povpr_poraba_ponedeljek <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Monday")[ ,3:98])
graf_ponedeljek <- points(povpr_poraba_ponedeljek,type = "o",pch=20,xaxt='n',col="black")
povpr_poraba_torek <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Tuesday")[ ,3:98])
graf_torek <- points(povpr_poraba_torek, type = "o",pch=20,xaxt='n',col="red")
povpr_poraba_sreda <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Wednesday")[ ,3:98])
graf_sreda <- points(povpr_poraba_sreda, type = "o",pch=20,xaxt='n',col="blue")
povpr_poraba_cetrtek <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Thursday")[ ,3:98])
graf_cetrtek <- points(povpr_poraba_cetrtek, type = "o",pch=20,xaxt='n',col="green")
povpr_poraba_petek <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Friday")[ ,3:98])
graf_petek <- points(povpr_poraba_petek, type = "o",pch=20,xaxt='n',col="orange")
povpr_poraba_sobota <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Saturday")[ ,3:98])
graf_sobota <- points(povpr_poraba_sobota, type = "o",pch=20,xaxt='n',col="yellow")
povpr_poraba_nedelja <- colMeans(filter(Tabela_porabe1, Ime_dneva =="Sunday")[ ,3:98])
graf_nedelja <- points(povpr_poraba_nedelja, type = "o",pch=20,xaxt='n',col="purple")
xlabels=c("3h","6h","9h","12h","15h","18h","21h","24h")
axis(side=1, at=c(12,24,36,48,60,72,84,96),labels=xlabels)
legend(title = "Legenda", legend = c("ponedeljek","torek","sreda","cetrtek","petek","sobota","nedelja"),"topright",col = c("black","red","blue","green","orange","yellow","purple"),lty=1)
dev.off()


# *********************************************** 
# od tu naprej imam analizo za vremenske podatke
# **********************************************
data_vreme2_tidy <- read.table("./podatki/zdruzeni_podatki/data_vreme2_tidy.txt",sep=" ")
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
povpr_poraba_za_vsak_dan <-rowMeans(Tabela_porabe1[ ,3:98])
povpr_poraba_matrika <- t(matrix(povpr_poraba_za_vsak_dan,198,51))
povpr_poraba_za_vsak_dan1 <- as.vector(colSums(povpr_poraba_matrika))
povpr_poraba_za_vsak_dan1<-povpr_poraba_za_vsak_dan1[-198]
povprecna_T_za_vsak_dan <- temperature_po_dnevih$`Skupna temperatura za dan`
skupne_padavine_za_vsak_dan <- padavine_po_dnevih$`Kolicina padavin za dan`
r12=cor(povpr_poraba_za_vsak_dan1,povprecna_T_za_vsak_dan[1:197]) #brisem zato ker za porabo na koncu 0
r13=cor(povpr_poraba_za_vsak_dan1,skupne_padavine_za_vsak_dan[1:197])


# ***************************************************
# Napovedni model s časovnimi vrstami
# ***************************************************
povpr_poraba_za_vsak_dan_ts <- ts(povpr_poraba_za_vsak_dan1, frequency = 365, start = c(2021,1))
arima_model <- auto.arima(povpr_poraba_za_vsak_dan_ts)
summary(arima_model)
holt_model <- holt(povpr_poraba_za_vsak_dan_ts, h=1)
summary(holt_model)
se_model <- ses(povpr_poraba_za_vsak_dan_ts, h = 1)
summary(se_model)
naive_mod <- naive(povpr_poraba_za_vsak_dan_ts, h = 1)
summary(naive_mod, "NA"= 0)
podatki_napovedni_model = tibble(povpr_poraba_za_vsak_dan_ts, arima_model$fitted, holt_model$fitted, se_model$fitted, naive_mod$fitted)
write.table(podatki_napovedni_model,"./podatki/zdruzeni_podatki/podatki_napovedni.csv",sep=" ")

jpeg("./slike/prikaz_natancnosti_razlicnih_napovednih_modelov.jpg")
mar.default <- c(5,2,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0),family="serif") #axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
title="Povprečna poraba in njene  napovedi"
plot(c(2021.0, 2021.6), c(0,170),yaxt='n',xaxt='n',main=title, type = "n", pch=19,cex.lab=1.2, cex.axis=1.3, cex.main=1.5,xlab = "Čas",ylab = "Povprečna poraba")  # setting up coord. system
xlabels = c(2021.0,2021.1, 2021.2, 2021.3, 2021.4, 2021.5, 2021.6)
ylabels = c(1:10)*17
axis(side=1,at=xlabels)
axis(side=2,at=ylabels)
lines(arima_model$fitted, type = "l", col = "blue",lwd=1,cex = 1,pch=16)
lines(holt_model$fitted, type = "l", col = "green",lwd=1,cex = 1,pch=16)
lines(se_model$fitted, type = "l", col = "red",lwd=1,cex = 1,pch=16)
lines(naive_mod$fitted, type = "l", col = "purple",lwd=1,cex = 1,pch=16)
lines(povpr_poraba_za_vsak_dan_ts, type = "l", col = "orange",lwd=2,cex = 1,pch=16)
legend("top", legend=(c("Dejanska poraba","Arima model", "Holt model", "Se model", "Naive mod")), pch=c(16,16,16,16,16),cex=c(1.2,1.2,1.2,1.2, 1.2),col=c("orange","blue", "green", "red", "purple"),y.intersp=0.8)
dev.off()
# ***************************************************
# Grupiranje rezultatov
# ***************************************************
povpr_poraba_za_vsak_dan <-rowMeans(Tabela_porabe1[ ,3:98])
povpr_poraba_matrika <- t(matrix(povpr_poraba_za_vsak_dan,198,51))
set.seed(123)

# *************************************************************
# Ugotavljanje optimalnega števila skupin s silhuetnim diagramom
# *************************************************************
obrisi = function(podatki, hc = TRUE, od = 2, do = NULL) {
  n = nrow(podatki)
  if (is.null(do)) {
    do = n - 1
  }
  
  razdalje = dist(podatki)
  
  k.obrisi = tibble()
  for (k in od:do) {
    if (hc) {
      o.k = hclust(razdalje) %>%
        cutree(k) %>%
        silhouette(razdalje)
    } else {
      set.seed(42) # zato, da so rezultati ponovljivi
      o.k = kmeans(podatki, k)$cluster %>%
        silhouette(razdalje)
    }
    k.obrisi = k.obrisi %>% bind_rows(
      tibble(
        k = rep(k, n),
        obrisi = o.k[, "sil_width"]
      )
    )
  }
  k.obrisi$k = as.ordered(k.obrisi$k)
  
  k.obrisi
}

obrisi.povprecje = function(k.obrisi) {
  k.obrisi.povprecje = k.obrisi %>%
    group_by(k) %>%
    summarize(obrisi = mean(obrisi))
}

obrisi.k = function(k.obrisi) {
  obrisi.povprecje(k.obrisi) %>%
    filter(obrisi == max(obrisi)) %>%
    summarize(k = min(k)) %>%
    unlist() %>%
    as.character() %>%
    as.integer()
}

r.hc = povpr_poraba_matrika[c(1:9,11:43,45:51),] %>% obrisi(hc = TRUE, od=2, do=20)
r.km = povpr_poraba_matrika[c(1:9,11:43,45:51),]  %>% obrisi(hc = FALSE,od=2, do=20)



diagram.obrisi = function(k.obrisi) {
  ggplot() +
    geom_boxplot(
      data = k.obrisi,
      mapping = aes(x = k, y = obrisi)
    ) +
    geom_point(
      data = obrisi.povprecje(k.obrisi),
      mapping = aes(x = k, y = obrisi),
      color = "red"
    ) +
    geom_line(
      data = obrisi.povprecje(k.obrisi),
      mapping = aes(x = as.integer(k), y = obrisi),
      color = "red"
    ) +
    geom_point(
      data = obrisi.povprecje(k.obrisi) %>%
        filter(obrisi == max(obrisi)) %>%
        filter(k == min(k)),
      mapping = aes(x = k, y = obrisi),
      color = "blue"
    ) +
    xlab("število skupin (k)") +
    ylab("obrisi (povprečje obrisov)") +
    ggtitle(paste("Maksimalno povprečje obrisov pri k =", obrisi.k(k.obrisi))) +
    theme_classic()
}
jpeg("./slike/hirarhicni_model.jpg")
diagram.obrisi(r.hc)
dev.off()

jpeg("./slike/model_k_tih_voditeljev.jpg")
diagram.obrisi(r.km)
dev.off()
# ***************************************************
# Generiranje skupin
# ***************************************************
klas <- kmeans(povpr_poraba_matrika,2)
klasifikacija <- klas$cluster
povpr_poraba_matrika1 <- cbind(povpr_poraba_matrika, klasifikacija)

M=max(max(povpr_poraba_matrika1[,1:198]))
m=min(min(povpr_poraba_matrika1[,1:198]))

Tabela_razred1 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "1",1:198]
Tabela_razred2 <- povpr_poraba_matrika1[povpr_poraba_matrika1[,199] == "2",1:198]


jpeg("./slike/prikaz_povprecne_porabe_za_razlicne_razrede.jpg")
mar.default <- c(5,2,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0),family="serif") #axis(side, at=, labels=, pos=, lty=, col=, las=, tck=, ...)
title="Povprečna poraba za različne razrede porabnikov"
plot(c(0,199), c(0,100),yaxt='n',xaxt='n',main=title, type = "n", pch=19,cex.lab=1.2, cex.axis=1.3, cex.main=1.5,xlab = "Dnevi",ylab = "Povprečna poraba")  # setting up coord. system
xlabels=c(1:19)*10
axis(side=1,at=xlabels,labels=xlabels)
axis(side=2,at=c(0:6)*20,labels=as.factor(c(0:6)*20))
lines(colSums(Tabela_razred1), type = "l", col = "black",lwd=2,cex = 1,pch=16)
lines(Tabela_razred2, type = "l", col = "red",lwd=2,cex = 1,pch=16)
legend("top", legend=(c("Sk1","Sk2")), pch=c(16,16),cex=c(1,1),col=c("black","red"),y.intersp=1.5,horiz=T)
dev.off()


