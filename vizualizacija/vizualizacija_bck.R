# 3. faza: Vizualizacija podatkov
# **************************************************
# Zemljevid
# **************************************************
setwd("/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/")
source("lib/libraries.r")
#slo.regije.sp <- readRDS("podatki/gadm36_SVN_1_sp.rds")
slo.regije.shp = readOGR("podatki/SVN_adm_shp/SVN_adm1.shp") # preberemo podatke o zemljevidu
slo.regije.map = slo.regije.shp %>% spTransform(CRS("+proj=longlat +datum=WGS84")) # pretvorimo v ustrezen format
#slo.regije.map = slo.regije.sp# %>% spTransform(CRS("+proj=longlat")) # pretvorimo v ustrezen format
#slo.regije.poligoni = slo.regije.sp


print(slo.regije.map@data)
slo.regije.poligoni = fortify(slo.regije.map)
print(slo.regije.poligoni)
slo.regije.poligoni1<-slo.regije.poligoni %>%
  left_join(
    rownames_to_column(slo.regije.map@data),
    by = c("id" = "rowname")
  )

slo.regije.poligoni_kratek= slo.regije.poligoni1[,c("NAME_1", "long", "lat", "order", "hole", "piece", "id", "group")]

slo.regije.poligoni_kratek %>% write_csv("podatki/OB/OB.shp")


slo.regije.centroidi = slo.regije.map %>% coordinates %>% as.data.frame
colnames(slo.regije.centroidi) = c("long", "lat")

slo.regije.centroidi = slo.regije.centroidi %>% rownames_to_column() %>%
  left_join(
    rownames_to_column(slo.regije.map@data),
    by = "rowname"
  ) 
slo.regije.centroidi<-slo.regije.centroidi[,c("NAME_1", "long", "lat")]

jpeg(file="/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/slo_regije1.jpg")
ggplot() +
  geom_polygon(
    data = slo.regije.poligoni_kratek,
    mapping = aes(long, lat, group = group),
    color = 'black',
    fill = 'white'
  ) +
  coord_map() +
  geom_text(
    data = slo.regije.centroidi,
    mapping = aes(x = long, y = lat, label = NAME_1)
  )

dev.off()
jpeg(file="/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/slo_regije2.jpg")

slo.regije.poligoni %>% ggplot() +
  geom_polygon(
    mapping = aes(long, lat, group = group),
    color = "grey",
    fill = "white"
  ) +
  coord_map() +
  geom_text(
    data = slo.regije.centroidi,
    mapping = aes(x = long, y = lat, label = NAME_1),
    size = 3
  ) +
  theme_classic() +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank()
  )
dev.off()











temperature_po_krajih <- read.csv("podatki/povprecne_temperature.csv",sep = ";")
Gorenjska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Gorenjska regija",2])
Goriška <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Goriska regija",2])
Jugovzhodna_Slovenija <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "JV SLO",2])
Koroška <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Koroska regija",2])
Notranjo_kraška <-mean(temperature_po_krajih[temperature_po_krajih[,3] == "Notranjsko-kraska regija",2])
Obalno_kraska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Obalno-kraska regija",2])
Osrednjeslovenska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Osrednjoslovenska regija",2])
Podravska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Podravska regija",2])
Pomurska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Pomurska regija",2])
Savinjska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Savinjska regija",2])
Posavska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Posavska regija",2])
Zasavska <- mean(temperature_po_krajih[temperature_po_krajih[,3] == "Zasavska regija",2])
povprecna_temperatura <- c(Gorenjska,Goriška,Jugovzhodna_Slovenija,Koroška,Notranjo_kraška,Obalno_kraska,Osrednjeslovenska,Podravska,Pomurska,Savinjska,Posavska,Zasavska)
Tabela_regije <- data.frame(NAME_1=Imena_regij,povprecna_temperatura)



jpeg(file="/Users/blazpovh/Documents/R_projektna_naloga/APPR-2021-22-Blaz-Povh/slike/slo_povpr_temp.jpg")

left_join(Tabela_regije,slo.regije.poligoni_kratek,
          by = "NAME_1"
) %>%
  ggplot() +
  geom_polygon(
    mapping = aes(long, lat, group = group, fill = povprecna_temperatura),
    color = "grey"
  ) +
  coord_map() +
  scale_fill_binned() +
  theme_classic() +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank(),
  ) +
  guides(fill=guide_legend(title="Povprečna letna \ntemperatura"))

dev.off()

Imena_regij <- c(slo.regije.sp$NAME_1)
m1 <- min(vektor_temperatur)
M1 <- max(vektor_temperatur)
plot(gadm,vektor_temperatur1, col=colors)

colors = heat.colors(12, alpha=1, rev = FALSE)

gadm_plot(gadm)




