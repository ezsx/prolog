man(UmemuroArareo).
man(TokamiHajuro).
man(AkamisuTokikuni).
man(MakitaOkidasu). 
man(FujisakiNaruromao).
man(OtomaruManamori).
man(KogaiFuzen). 
man(HataroHachidaira).
man(IgamatsuSadatada).

woman(KataMachinari).
woman(NatsumoriMarizuki).
woman(OgatakeAyameki).
woman(MinabiraGinatsu).
woman(UranagiToshitomi).
woman(HaratakiKise).
woman(UbugitaMesato).
woman(OshindoKiramiko).
woman(AzumuroKosaki).

parent(UmemuroArareo,TokamiHajuro).
parent(UmemuroArareo,OgatakeAyameki).
parent(UmemuroArareo,MakitaOkidasu).
parent(UmemuroArareo,UranagiToshitomi).

parent(KataMachinari,TokamiHajuro).
parent(KataMachinari,OgatakeAyameki).
parent(KataMachinari,MakitaOkidasu).
parent(KataMachinari,UranagiToshitomi).

parent(TokamiHajuro,OtomaruManamori).
parent(TokamiHajuro,KogaiFuzen).
parent(NatsumoriMarizuki,OtomaruManamori).
parent(NatsumoriMarizuki,KogaiFuzen).

parent(AkamisuTokikuni,HataroHachidaira).
parent(AkamisuTokikuni,HaratakiKise).
parent(OgatakeAyameki,HataroHachidaira).
parent(OgatakeAyameki,HaratakiKise).

parent(MakitaOkidasu,UbugitaMesato).
parent(MakitaOkidasu,OshindoKiramiko).
parent(MinabiraGinatsu,UbugitaMesato).
parent(MinabiraGinatsu,OshindoKiramiko).

parent(FujisakiNaruromao,AzumuroKosaki).
parent(FujisakiNaruromao,IgamatsuSadatada).
parent(UranagiToshitomi,AzumuroKosaki).
parent(UranagiToshitomi,IgamatsuSadatada).

%11
daughter(X):- parent(X,Y),woman(Y),write(Y),nl,fail.
daughter(X,Y):-parent(Y,X),woman(X).
