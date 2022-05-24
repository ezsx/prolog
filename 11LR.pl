man(leo).
man(max).
man(matt).
man(dima).
man(letto).
man(tom).

woman(ann).
woman(elza).
woman(masha).
woman(maria).
woman(kate).
woman(amanda).

parent(leo,dima).
parent(ann,dima).
parent(max,maria).
parent(max,letto).
parent(elza,maria).
parent(elza,letto).
parent(matt,kate).
parent(masha,kate).


parent(letto,amanda).
parent(kate,amanda).

parent(dima,tom).
parent(maria,tom).

%11
daughter(X):- parent(X,Y),woman(Y),write(Y),nl,fail.
daughter(X,Y):-parent(Y,X),woman(X).
%12
wife(X):-man(X),parent(X,Z),parent(Y,Z),woman(Y),write(Y),nl,!.
wife(X,Y):-woman(X),man(Y),parent(X,Z),parent(Y,Z),write(yes),nl,!.
%13
grandMa(X,Y):-parent(X,Z),parent(Z,Y),woman(X),write(yes),nl,!.
grandMas(X):-parent(Z,X),parent(Y,Z),woman(Y),write(Y),nl.
%14
grandMaAndDa(X,Y):- parent(X,Z),parent(Z,Y),woman(Y),woman(X),write(yes),nl,fail;parent(Y,Z),parent(Z,X),woman(X),grandMa(Y,X),write(yes),nl,fail.
grand_pa_and_son(X,Y):-parent(X,Z),parent(Z,Y),man(X),man(Y),write(yes),nl,fail;parent(Y,Z),parent(Z,X),man(Y),man(X),write(yes),nl,fail.
in_list([],_):-fail.
in_list([X|_],X).
in_list([_|T],X):-in_list(T,X).
%15
minU(0,9):-!.
minU(X,M):-
	X1 is X div 10,
	minU(X1,M1),
	M2 is X mod 10,
	(M2<M1, M is M2;M is M1). 
%16
minD(X,M):- minD(X,9,M).
minD(0,M,M):-!.
minD(X,Y,M):-D is X mod 10, X1 is X div 10,D < Y,!,minD(X1,D,M); X2 is X div 10, minD(X2,Y,M).
%17	
minOddU(0,99):-!.
minOddU(X,M):-
    X1 is X div 10,
    minOddU(X1,M1),
    M2 is X mod 10,
    (M2 < M1, M2 mod 2 =\= 0 -> M is M2; M is M1).
%18
pr5(X,R):-pr5(X,1,R).
pr5(0,T,T):-!.
pr5(X,P,R):-D is X mod 10,D mod 5 =\= 0, P1 is (P * D),X1 is X div 10,pr5(X1,P1,R);X2 is X div 10,pr5(X2,P,R).
%19
fibU(1,1):-!.
fibU(2,1):-!.
fibU(N, X):- N1 is N - 1, N2 is N - 2, fibU(N1, X1), fibU(N2, X2), X is X1 + X2.
%20
fibD(N,X):-fibD(1,1,2,N,X).
fibD(_,F,N,N,F):-!.
fibD(A,B,K,N,X):- C is A+B, K1 is K+1,fibD(B,C,K1,N,X).
append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).