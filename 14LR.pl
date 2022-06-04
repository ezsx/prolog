
% 1.1

task1_1:- 
    rS(Str,N), 
    wS(Str), write(", "), 
    wS(Str), write(", "), 
    wS(Str), write(", "), 
    write(N).

rS(Str,N):- 
    get0(Char), 
    rS(Char, [], 0, Str, N, _).

rS(Str,N, Flag):- 
    get0(Char), 
    rS(Char, [], 0, Str, N, Flag).

rS(-1,Str,N,Str,N,1):-!.
rS(10,Str,N,Str,N,0):-!.

rS(Char,NowStr,Count,Str,N, Flag):-
    NewCount is Count+1, 
    appendString(NowStr,[Char],NewNowStr), 
    get0(NewChar), 
    rS(NewChar,NewNowStr,NewCount,Str,N, Flag).

appendString([],X,X).
appendString([X|T],Y,[X|T1]) :- appendString(T,Y,T1).

wS([]):-!.
wS([H|T]):-put(H),wS(T).


% 1.2

task1_2:- 
    rS(Str,_), 
    wordsCount(Str,Count),
    write(Count).

wordsCount([],Count):-Count is 1,!.
wordsCount([H|T], Count):-
	    H is 32,
		wordsCount(T,N),
		Count is N+1;
		wordsCount(T,Count).

