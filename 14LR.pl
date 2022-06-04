
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


% 1.3 Дана строка, определить самое частое слово

task1_3 :- readString(Str, _), mostCommW(Str, X), writeString(X).



countWordsStr(List, X, Ans) :- 
    countWordsStr(List, X, 0, Ans).
countWordsStr([], _, Ans, Ans) :- !.
countWordsStr([X|T], X, Count, Ans) :- 
    NewCount is Count + 1, 
    countWordsStr(T, X, NewCount, Ans),!.
countWordsStr([_|T], X, Count, Ans) :- 
    countWordsStr(T, X, Count, Ans),!.

splitStr([], _, CurWord, CurWordList, Ans) :- 
    appendString(CurWordList, [CurWord], NewWL), 
    Ans = NewWL,!.

splitStr([Separator|T], Separator, CurWord, CurWordList, Ans) :- 
    appendString(CurWordList, [CurWord], NewWL), 
    splitStr(T, Separator, [], NewWL, Ans),!.

splitStr([S|T], Separator, CurWord, CurWordList, Ans) :- 
    appendString(CurWord, [S], NewWord), 
    splitStr(T, Separator, NewWord, CurWordList, Ans),!.

splitStr(Str, Separator, Ans) :- 
    char_code(Separator, SepCode), 
    splitStr(Str, SepCode, [], [], Ans).



mostCommW(Str, Ans) :-
    splitStr(Str, " ", Words), 
    mostCommW(Words, Words, 0, [], Ans). 

mostCommW(Words, [Word|T], CurMaxCnt, _, Ans) :- 
    countWordsStr(Words, Word, Cnt), 
    Cnt > CurMaxCnt, 
    NewMax is Cnt, 
    NewMaxWord = Word, 
    mostCommW(Words, T, NewMax, NewMaxWord, Ans),!.

mostCommW(Words, [_|T], CurMaxCnt, CurMaxWord, Ans) :- 
    mostCommW(Words, T, CurMaxCnt, CurMaxWord, Ans),!.

mostCommW(_, [], _, Ans, Ans) :-!.
