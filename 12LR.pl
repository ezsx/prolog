
%% add to list для след заданий

append([], List2, List2).
append([Head|Tail], List2, [Head|TailResult]):-
   append(Tail, List2, TailResult).
   
%11 maximalnii prostoy delitel chisla
prostoe(X):-prostoe(2,X).
prostoe(X,X):-!.
prostoe(K,X):- Ost is X mod K, Ost=0,!,fail.
prostoe(K,X):-K1 is K+1,prostoe(K1,X).

%main
mProstDel(X,N):- mProstDel(X,X,N),!.
mProstDel(X,K,K):- O is X mod K, O = 0,prostoe(K),!.
mProstDel(X,K,N):-K1 is K-1,mProstDel(X,K1,N).

%12 NOD nechet mProstDel & proizvedenije cifr

mNeprostDel(X,N):- mNeprostDel(X,X,N),!.
mNeprostDel(X,K,K):- 
	O is X mod K, 
	O = 0,
	not(prostoe(K)),K mod 2 =\= 0,!.
mNeprostDel(X,K,N):- 
	K1 is K-1,
	mNeprostDel(X,K1,N).

sumCifr(X,A):-sumCifr(X,1,A).
sumCifr(0,F,F):-!.
sumCifr(X,S,A):-
	X1 is X div 10,
	S1 is S * (X mod 10),
	sumCifr(X1,S1,A).

nOD(0, X, X):- X > 0, !.
nOD(X, Y, Z):- X >= Y, X1 is X-Y, nOD(X1,Y,Z).
nOD(X, Y, Z):- X < Y, X1 is Y-X, nOD(X1,X,Z).

%main
task2(N,A):-
	N1 is N,
	mNeprostDel(N1,MU),
	MaxUd is MU,
	N2 is N,
	sumCifr(N2,AC),
	AppC is AC,
	nOD(MaxUd,AppC,A),!.

%13 Найти d, меньшее 1000, 
%   для которого десятичная дробь 1/d содержит самый длинный период

%делим на 2 пока можем

del2(1,1):-!.
del2(X,R):- 
	X1 is X div 2,
	Os is X mod 2,!,
	del2(X1,R1),!,
	(Os = 0,R is R1;R is X),!.
	
%делим на 5 пока можем
del5(5,1):-!.
del5(4,4):-!.
del5(3,3):-!.
del5(2,2):-!.
del5(1,1):-!.
del5(X,R):- 
	X1 is X div 5,
	Os is X mod 5,
	del5(X1,R1),!,
	(Os = 0,R is R1;R is X),!.

%период дроби 1/X

period_CH(X,L):-
	del2(X,R2),
	del5(R2,R5),
	period_CH(R5,L,0,1).
period_CH(_,G,G,0):-!.
period_CH(N,L,K,R):-
	K1 is K + 1,
	R1 is (R * 10) mod N,
	R1=\=1,R1=\=0,
	period_CH(N,L,K1,R1),!;Ka1 is K+1,
	period_CH(N,L,Ka1,0),!.

%main
find_period(A):-find_period(A,0,0,1).
find_period(G,G,_,1000):-!.
find_period(A,Ch,Ma,Co):- period_CH(Co,Res),
	Res>Ma,
	Ma1 is Res,
	Ch1 is Co,
	Co1 is Co + 1,!,
	find_period(A,Ch1,Ma1,Co1);Co2 is Co + 1,
	find_period(A,Ch,Ma,Co2),!.
	

%14 получить длину списка

%main
length1(List, Length):-
   length1(List, 0, Length).
length1([], Length, Length):-!.
length1([_Head|Tail], Buffer, Length):-
   NewBuffer is Buffer + 1,
   length1(Tail, NewBuffer, Length).
   
%15 - 20  (3, 11, 13, 15, 27, 30)


readL(X,Y):-readL([],X,0,Y).
readL(A,A,G,G):-!.
readL(A,B,C,D):- C1 is C+1,
	read(X),
	append(A,[X],A1),
	readL(A1,B,C1,D).

writeL([]):-!.
writeL([H|T]):- 
	write(H),
	write(' '),
	writeL(T).

% 15(3) Дан целочисленный массив и натуральный индекс (число, меньшее размера массива). 
% Необходимо определить является ли элемент по указанному индексу глобальным максимумом.

% индекс с нуля
elem_po_index(L,I,El):-elem_po_index(L,I,El,0).
elem_po_index([H|_],K,H,K):-!.
elem_po_index([_|Tail],I,El,Cou):- 
	I =:= Cou,
	elem_po_index(Tail,Cou,El,Cou); Cou1 is Cou + 1,
	elem_po_index(Tail,I,El,Cou1).

maxELEM(L,El):-maxELEM(L,[],-999,El).
maxELEM([],_,M,M):-!.
maxELEM([H|T],X,Mx,El):-H>Mx,!,
	append(X,T,List1),
	maxELEM(T,List1,H,El);append(X,T,List2),!,
	maxELEM(T,List2,Mx,El).

task15:- read(N),
	readL(L,N),
	read(I),
	elem_po_index(L,I,Elind),
	maxELEM(L,Elmax),
	(Elind =:= Elmax,write(yes);write(net)),!.


%16(11) Дан целочисленный массив, в котором лишь один элемент отличается от остальных. 
%       Необходимо найти значение этого элемента.

% сколько раз встретится элемент в списке

freq(L,El,F):- freq(L,El,F,0).
freq([],_,G,G):-!.
freq([H|T],El,F,C):-
	H=:=El,
	C1 is C + 1,!,
	freq(T,El,F,C1); freq(T,El,F,C),!.

otl_ELEM(L,I):-otl_ELEM(L,L,I,0).
otl_ELEM([],_,K,K):-!.
otl_ELEM([H|T],L,Y,Z):-freq(L,H,R),R =:= 1,!,otl_ELEM(T,L,Y,H);otl_ELEM(T,L,Y,Z),!.

%main
task16:- 
	read(N),
	readL(L,N),
	otl_ELEM(L,I), write(I),!.

%17(13)Дан целочисленный массив. Необходимо разместить элементы, 
%      расположенные до минимального, в конце массива.

minELEM(L,El):-minELEM(L,[],999,El).
minELEM([],_,M,M):-!.
minELEM([H|T],X,Mx,El):-H<Mx,!,
	append(X,T,List1),
	minELEM(T,List1,H,El);append(X,T,List2),!,
	minELEM(T,List2,Mx,El).

find_index(L,El,I):-find_index(L,El,I,0).
find_index([],_,G,G):-!.
find_index([H|T],El,I,C):- H=\=El,
	C1 is C + 1,!,
	find_index(T,El,I,C1);find_index([],El,I,C),!.

% срезаем список - элементы с индексами I1 и I2 включительно. Индекс с 0.
srez(L,I1,I2,R):-srez(L,I1,I2,R,-1,[]).

srez(_,_,O2,Res,O2,Res):-!.

srez([_|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1,
	Curi<I1,!,
	srez(T,I1,I2,R,Curi,Lis). %до I1
	
srez([_|_],I1,I2,R,Ci,Lis):- Curi is Ci + 1,
	Curi>I2,!,
	srez([],I1,Curi,R,Curi,Lis).%после I2
	
srez([H|T],I1,I2,R,Ci,Lis):- Curi is Ci + 1,
	append(Lis,[H],List),!,
	srez(T,I1,I2,R,Curi,List).%между I1 и I2

%main
task17:-
	read(N),readL(Lis,N),minELEM(Lis,Emin),
	find_index(Lis,Emin,In),srez(Lis,0,In-1,Before),srez(Lis,In,N-1,After),
	append(After,Before,Res),writeL(Res),!.


%18(15) является ли элемент по указанному индексу локальным минимумом

localMIN(List,I):-
	I=:=0, 
	elem_po_index(List,0,A1),
	elem_po_index(List,1,A2),
	A1<A2,write(yes),!;
	N1 is I - 1, N2 is I + 1,
	elem_po_index(List,N1,I1),
	elem_po_index(List,I,I2),
	elem_po_index(List,N2,I3),
	I2<I1,I2<I3,write(yes),!;
	listleng(List,Len),
	G1 is Len-1, 
	G2 is Len - 2, 
	elem_po_index(List,G1,K1),
	elem_po_index(List,G2,K2),
	K1<K2,write(yes),!;
	write(net),!.

%main
task18:-
	read(N),
	readL(Lis,N),
	read(I),localMIN(Lis,I),!.


%19(27) Дан целочисленный массив. 
%       Необходимо осуществить циклический сдвиг элементов массива влево на одну позицию.

task19:- read(N),
	readL(List,N),
	srez(List,0,0,Head),
	listleng(List,Len),
	Lk is Len - 1,
	srez(List,1,Lk,Tail),
	append(Tail,Head,Tailhead),
	writeL(Tailhead).

