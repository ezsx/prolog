% some func

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

listContains([],_):- false, !.
listContains([Head|_],Head).
listContains([_|Tail],Number):- listContains(Tail,Number).


contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

listleng([],0).
listleng([_|T],I):-listleng(T,J),I is J + 1.

writelist([]):-!.
writelist([H|T]):- write(H),write(' '),writelist(T).

readlist(X,Y):-readlist([],X,0,Y).
readlist(A,A,G,G):-!.
readlist(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readlist(A1,B,C1,D).

frequency(L,El,F):- frequency(L,El,F,0).
frequency([],_,G,G):-!.
frequency([H|T],El,F,C):-H=:=El, C1 is C + 1,!,frequency(T,El,F,C1);frequency(T,El,F,C),!.

elbyindex(L,I,El):-elbyindex(L,I,El,0).
elbyindex([H|_],K,H,K):-!.
elbyindex([_|Tail],I,El,Cou):- I =:= Cou,elbyindex(Tail,Cou,El,Cou);Cou1 is Cou + 1, elbyindex(Tail,I,El,Cou1).

getindex(L,El,I):-getindex(L,El,I,0).
getindex([],_,G,G):-!.
getindex([H|T],El,I,C):- H=\=El,C1 is C + 1,!,getindex(T,El,I,C1);getindex([],El,I,C),!.

%some func

%11(39) Дан целочисленный массив. Необходимо вывести вначале его элементы с четными индексами, а затем - с нечетными.

chnch(L):-listleng(L,Len),chnch(L,0,Len,[],[]).
chnch([],F,F,A,B):-append(A,B,C),writelist(C).
chnch([H|T],In,Le,Ch,Nch):- 
	In mod 2 =:= 0,
	append(Ch,[H],Ch1),
	In1 is In + 1,chnch(T,In1,Le,Ch1,Nch),!;
	append(Nch,[H],Nch1),
	In2 is In +1,
	chnch(T,In2,Le,Ch,Nch1),!.

task11:- read(N),readlist(L,N),chnch(L),!.

%12(45) Дан целочисленный массив и интервал a..b. 
%Необходимо найти сумму элементов, значение которых попадает в этот интервал.

sumL(List,A,B,Sum):-sumL(List,A,B,0,Sum).
sumL([],_,_,Su,Su):-!.
sumL([H|T],A,B,S,Sum):- 
	H> A,H< B,S1 is S+H,
	sumL(T,A,B,S1,Sum),!;
	sumL(T,A,B,S,Sum).

task12:- read(N),readlist(L,N),read(A),read(B),sumL(L,A,B,Sum),write(Sum).

%13(51) Для введенного списка построить два списка L1 и L2, 
%где элементы L1 это неповторяющиеся элементы исходного списка,
%а элемент списка L2 с номером i показывает, 
%сколько раз элемент списка L1 с таким номером повторяется в исходном.

notin([],[]):- !.
notin([H|T],L):-notin([H|T],L,[]).
notin([],Lis,Lis):-!.
notin([H|T],List,[]):-notin(T,List,[H]),!.
notin([H|T],List,List1):-not(contains(List1,H)),append(List1,[H],List2),notin(T,List,List2),!.
notin([_|T],List,List1):-notin(T,List,List1).

p_p(Common,Uniq,Res):-p_p(Common,Uniq,Res,[]).
p_p(_,[],R,R):-!.
p_p(Common,[H|T],Res,Acc):-frequency(Common,H,F),F1 is F,append(Acc,[F1],Acc1),p_p(Common,T,Res,Acc1).

task13:- read(N),readlist(L,N),notin(L,Uniq),p_p(L,Uniq,Res),writelist(L),nl,writelist(Uniq),nl,writelist(Res),!. 

%Задание 14 Беседует трое друзей: Белокуров, Рыжов, Чернов. Брюнет сказал Белокурову: 
%“Любопытно, что один из нас блондин, другой брюнет, третий - рыжий, но ни у кого цвет волос не соответствует фамилии”.
%Какойцвет волос у каждого из друзей?

inL([],_):-fail.
inL([X|_],X).
inL([_|T],X):-inL(T,X).

task14:- Hairs=[_,_,_],
inL(Hairs,[belokurov,_]),
inL(Hairs,[chernov,_]),
inL(Hairs,[rizhov,_]),
inL(Hairs,[_,ginger]),
inL(Hairs,[_,blond]),
inL(Hairs,[_,brunette]),
not(inL(Hairs,[belokurov,blond])),
not(inL(Hairs,[chernov,brunette])),
not(inL(Hairs,[rizhov,ginger])),
write(Hairs),!.

%Задание 15 Три подруги вышли в белом,
%зеленом и синем платьях и туфлях. Известно, 
%что только у Ани цвета платья и туфлей совпадали. 
%Ни туфли,ни платье Вали не были белыми. 
%Наташа была в зеленых туфлях. Определить цвета платья и туфель на каждой из подруг.

task15:- Vertidos=[_,_,_],
inL(Vertidos,[ann,_,_]),
inL(Vertidos,[valya,_,_]),
inL(Vertidos,[natasha,_,_]),
inL(Vertidos,[_,white,_]),
inL(Vertidos,[_,green,_]),
inL(Vertidos,[_,blue,_]),
inL(Vertidos,[_,_,white]),
inL(Vertidos,[_,_,green]),
inL(Vertidos,[_,_,blue]),
inL(Vertidos,[natasha,_,green]),
not(inL(Vertidos,[valya,white,white])),
not(inL(Vertidos,[natasha,green,_])),
write(Vertidos),!.

%Задание 16 На заводе работали три друга: слесарь, токарь и сварщик. Их фамилии Борисов, Иванов и Семенов. У слесаря нет ни братьев, ни сестер. Он
%самый младший из друзей. Семенов, женатый на сестре Борисова, старше токаря. Назвать фамилии слесаря, токаря и сварщика.

% [профессия, фамилия, кол-во сестер, старшинство, жена]

/*
    Слесарь не Борисов (у борисова сестра, у слесаря нет)
    Слесарь не Семенов (слесарь самый младший, а Семенов старше токаря)
    -> Слесарь - Иванов
    Семенов старше токаря -> Токарь не Семенов
    -> Токарь - Борисов
    -> Сварщик - Семенов
*/

task16:- Work = [_,_,_],
%inL(Work,[slesar,borisov,kolvo_bratev,vozrast,rodstvennik]),
inL(Work,[slesar,_,0,0,_]),
inL(Work,[tokar,_,_,1,_]),
inL(Work,[svarshick,_,_,_,_]),
inL(Work,[_,semenov,_,2,borisov]),
inL(Work,[_,ivanov,_,_,_]),
inL(Work,[_,borisov,1,_,_]),
inL(Work,[slesar,Who1,_,_,_]),
inL(Work,[tokar,Who2,_,_,_]),
inL(Work,[svarshick,Who3,_,_,_]),
write('slesar = '),write(Who1),nl,write('tokar = '),write(Who2),nl,write('svarshick = '),write(Who3),!.


% В бутылке, стакане, кувшине и банке находятся молоко, ли-
% монад, квас и вода. Известно, что вода и молоко не в бутылке, сосуд с лимона-
% дом находится между кувшином и сосудом с квасом, в банке - не лимонад и не
% вода. Стакан находится около банки и сосуда с молоком. Как распределены
% эти жидкости по сосудам.

isOnRight(_, _, [_]):- false, !.
isOnRight(A, B, [A|[B|_]]).
isOnRight(A, B, [_|List]):- isOnRight(A,B,List).

isOnLeft(_, _, [_]):- false, !.
isOnLeft(A, B, [B|[A|_]]).
isOnLeft(A, B, [_|List]):- isOnLeft(A,B,List).

next(A, B, List):- isOnRight(A, B, List).
next(A, B, List):- isOnLeft(A, B, List).

task17(Result):-
    Drinks = [_,_,_,_],
    
    listContains(Drinks,[bottle, _]),
    listContains(Drinks,[glass, _]),
    listContains(Drinks,[ewer, _]),
    listContains(Drinks,[jar, _]),
    listContains(Drinks,[_, milk]),
    listContains(Drinks,[_, lemonade]),
    listContains(Drinks,[_, kvas]),
    listContains(Drinks,[_, water]),
    
    % Вода и молоко не в бутылке
    not(listContains(Drinks,[bottle, milk])),
    not(listContains(Drinks,[bottle, water])),
    
    % В банке - не лимонад и не вода
    not(listContains(Drinks,[jar, lemonade])),
    not(listContains(Drinks,[jar, water])),
    
    % Сосуд с лимонадом находится между кувшином и сосудом с квасом
    isOnRight([ewer, _], [_, lemonade], Drinks),
    isOnRight([_, lemonade], [_, kvas], Drinks),
    
    % Стакан находится около банки и сосуда с молоком
    next([glass, _], [jar, _], Drinks),
    next([glass, _],[_, milk], Drinks),
    
    Result = Drinks, !.


/*
Задание 18 Воронов, Павлов, Левицкий и Сахаров – четыре талантли-
вых молодых человека. Один из них танцор, другой художник, третий-певец,
а четвертый-писатель. О них известно следующее: Воронов и Левицкий си-
дели в зале консерватории в тот вечер, когда певец дебютировал в сольном
концерте. Павлов и писатель вместе позировали художнику. Писатель написал
биографическую повесть о Сахарове и собирается написать о Воронове. Воро-
нов никогда не слышал о Левицком. Кто чем занимается?*/

task18(Result):-
    Guys = [_, _, _, _],
    
    listContains(Guys, [voronov, _]),
    listContains(Guys, [pavlov, _]),
    listContains(Guys, [levizkyi, _]),
    listContains(Guys, [saharov, _]),
    listContains(Guys, [_, dancer]),
    listContains(Guys, [_, artist]),
    listContains(Guys, [_, singer]),
    listContains(Guys, [_, writer]),
    
    % Певец - не Воронов или Левицкий
    not(listContains(Guys, [voronov, singer])),
    not(listContains(Guys, [levizkyi, singer])),
    
    % Художник - не Павлов
    not(listContains(Guys, [pavlov, artist])),

    % Писатель - не Сахоров, Воронов, Павлов
    not(listContains(Guys, [saharov, writer])),
    not(listContains(Guys, [voronov, writer])),
    not(listContains(Guys, [pavlov, writer])),

    Result = Guys, !.


/*
%Задание 19 Три друга заняли первое, второе, третье места в соревнова-
ниях универсиады. Друзья разной национальности, зовут их по-разному, и лю-
бят они разные виды спорта. Майкл предпочитает баскетбол и играет лучше,
чем американец. Израильтянин Саймон играет лучше теннисиста. Игрок в кри-
кет занял первое место. Кто является австралийцем? Каким спортом увлека-
ется Ричард?*/
task19:-
    Athletes = [_,_,_],

    % [name, nationality, sport, place]
    
    % Майкл предпочитает баскетбол
    listContains(Athletes, [michael, _, basketball, _]),
    
    % Саймон - израильтянин
    listContains(Athletes, [saimon, isrial, _, _]),

    % Игрок в крикет занял первое место
    listContains(Athletes, [_, _, cricket, first]),
    
    listContains(Athletes, [richard, _, _, _]),

    listContains(Athletes, [_, _, tennis, _]),
    listContains(Athletes, [_, american, _, _]),
    listContains(Athletes, [_, austrian, _, _]),
    
    listContains(Athletes, [_, _, _, second]),
    listContains(Athletes, [_, _, _, third]),

    % Майкл играет лучше, чем американец
    not(listContains(Athletes, [michael, american, _, _])),
    
    % Саймон играет лучше теннисиста
    not(listContains(Athletes, [saimon, _, tennis, _])),

    listContains(Athletes, [Austrian, austrian, _, _]),
    listContains(Athletes, [richard, _, RichardsSport, _]),
    
    write('Austrian: '), writeln(Austrian),
    write('Richards sport is '), writeln(RichardsSport), !.



/*
%20. Вариант 3 Три друга – Петр, Роман и Сергей учатся на математическом,
физическом и химическом факультетах университета. Если Петр математик,
то Сергей не физик. Если Роман не физик, то Петр – математик. Если Сергей
не математик, то Роман – химик. Где учится Роман?

*/
task20:- Chels = [_,_,_],
%inL(Chels,[pyotr,roman,sergey,matem,fisica,quimia]),
inL(Chels,[pyotr,_]),
inL(Chels,[roman,_]),
inL(Chels,[sergey,_]),
inL(Chels,[_,matem]),
inL(Chels,[_,fisica]),
inL(Chels,[_,quimia]),
(not(inL(Chels,[pyotr,matem]));inL(Chels,[sergey,fisica])),
((inL(Chels,[roman,fisica]));(inL(Chels,[pyotr,matem]))),
((inL(Chels,[sergey,matem]));inL(Chels,[roman,fisica])),
inL(Chels,[roman,Who1]),
write(Chels),nl,write('roman uchitsa '),write(Who1),!.




