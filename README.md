# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Tematika

Tema moje projektne naloge se imenuje poraba električne energije za različne porabnike skozi leto.
To temo sem si izbral, ker na Razvojnem centru Novo mesto, kjer občasno delam, potrebujejo nekoga, da naredi ta projekt. Tema me tudi drugače zanima in tako bom naredil projektno nalogo in zraven se malo zasluzil:)
V sklopu te naloge bom opazoval porabo električne energije za različne električne porabnike za 200 zaporednih dni v letu 2021.  Podatke za porabo električne energije in vreme bom dobil iz programskega vmesnika JSON, medtem ko bom dobil koledarske podatke iz CSV formata.
Imel bi 50 tabel porabe električne energije, za vsak porabnik eno tabelo po dnevih. Potem pa bom imel še tabelo z vremenom, kjer bodo stolpci predstavljali vremenske dejavnike(vlaga, tlak, veter...). 
Nato bi te podatke grupiral po "tipih dneva", primerjal bi razlike porabe električne energije za navadne deovne dneve, nedelje, praznike, za različne letne čase, različna vremena...
Cilj te naloge bo bil napovedati porabo električne energije za prihodnji dan.


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
