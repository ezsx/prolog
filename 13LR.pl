% some func

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

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

%12(45) Дан целочисленный массив и интервал a..b. Необходимо найти сумму элементов, значение которых попадает в этот интервал.

sumL(List,A,B,Sum):-sumL(List,A,B,0,Sum).
sumL([],_,_,Su,Su):-!.
sumL([H|T],A,B,S,Sum):- 
	H> A,H< B,S1 is S+H,
	sumL(T,A,B,S1,Sum),!;
	sumL(T,A,B,S,Sum).

task12:- read(N),readlist(L,N),read(A),read(B),sumL(L,A,B,Sum),write(Sum).
