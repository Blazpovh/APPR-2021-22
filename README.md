# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Tematika

Tema moje projektne naloge se imenuje poraba električne energije za različne porabnike skozi leto.
To temo sem si izbral, ker na Razvojnem centru Novo mesto, kjer občasno delam, potrebujejo nekoga, da naredi ta projekt. Tema me tudi drugače zanima in tako bom naredil projektno nalogo in zraven se malo zasluzil:)
V sklopu te naloge bom opazoval porabo električne energije za različne električne porabnike na letni ravni. Opazoval bom, kako se poraba spreminja glede na porabnike in slednje grupiral po podobnosti porabe. Podatke za porabo električne energije in vreme bom dobil iz programskega vmesnika JSON, medtem ko bom dobil koledarske podatke iz CSV formata.

Analiziral bi, kateri porabniki imajo največjo porabo ter na kere dneve v letu je slednja največja(npr. nedelje, prazniki...) in s pomočjo tega poizkušal napovedati porabo za prihodnost.
Izbrali si boste temo, s katero se bo vaš projekt ukvarjal.
Tukaj boste napisali, kje ste dobili podatke, ter kakšen je vaš cilj.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Potrebne knjižnice so v datoteki `lib/libraries.r`
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).
