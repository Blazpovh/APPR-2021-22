# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Tematika

Tema moje projektne naloge se imenuje analiza pretekle porabe in napoved bodoče porabe električne energije za različne porabnike skozi leto na 15 minutni bazi.
To temo sem si izbral, ker na Razvojnem centru Novo mesto, kjer občasno delam, delajo na tem projektu in so mi posredovali realne podatke, hkrati pa bi za njih mogoče bili moji rezultati uporabni. 
Tema me zanima. V sklopu te naloge bom opazoval porabo električne energije za 50 različnih porabnikov električne energije za 200 zaporednih dni v letu 2021.  Podatke o pretekli porabi električne energije in za vreme v krajih, od koder so porabniki, sem dobil od Razvojnega centra Novo mesto v obliki json formata.
Pridobil sem pa tudi podatke o koledarju za celotno desetletje, ki so v obliki csv. 
Imel bom 50 tabel porabe električne energije, za vsak porabnik eno tabelo po dnevih. Potem pa bom imel še tabelo z vremenom, kjer bodo stolpci predstavljali vremenske dejavnike (vlaga, tlak, veter, temperatura, ...) za kraje, od koder so ti porabniki. 
Najprej bi za vsakega porabnika analiziral povprečno porabo ob različnih dnevih (delovni dnevi, vikendi, prazniki, različni meseci,...), nato pa bi izračunal skupno porabo vseh 50 porabnikov in nato naredil še razvrščanje v skupine, da bi videl tipične dnevne porabe (razvrščal bi teh 200 dni, za katere imam podatke).

Na koncu pa bi s  analizo časovnih vrst poskusil napovedati porabo v naslednjem dnevu. 


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
