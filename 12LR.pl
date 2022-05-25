
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
