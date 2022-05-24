
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