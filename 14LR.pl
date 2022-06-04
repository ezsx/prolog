
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

task1_3 :- readString(Str, _), mostCommW(Str, X), wS(X).



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

% 1.4

task1_4 :- readString(Str, N), task1_4(Str, N).

subStr([H|T], Start, End, Ans) :- 
    subStr([H|T], Start, End, 0, [], Ans).

subStr([H|T], Start, End, I, List, Ans) :- 
    I >= Start, I < End, 
    appendString(List, [H], NewList), 
    NewI is I + 1, 
    subStr(T, Start, End, NewI, NewList, Ans),!.

subStr([_|T], Start, End, I, List, Ans) :- 
    NewI is I + 1, 
    subStr(T, Start, End, NewI, List, Ans),!.

subStr([], _, _, _, Ans, Ans) :- !.

wSNTimes(_, 0) :- !. 
wSNTimes(Str, N) :- 
    wS(Str), 
    NewN is N - 1,
    wSNTimes(Str, NewN),!. 

task1_4(Str, N) :- 
    N > 5, 
    subStr(Str, 0, 3, First3), 
    L3 is N - 3, 
    subStr(Str, L3, N, Last3), 
    wS(First3), 
    write(" "), 
    wS(Last3),!.

task1_4([H|_], N) :- wSNTimes([H], N).

% 1.5

task1_5 :- 
    rS(Str, N), 
    NewN is N - 1, 
    subStr(Str, NewN, N, [Char|_]), 
    indChar(Str, Char, Ans), 
    write(Ans).

indChar(List, X, Ans) :- 
    indChar(List, X, 0, [], Ans).

indChar([X|T], X, I, List, Ans) :- 
    appendString(List, [I], NewList), 
    NewI is I + 1, 
    indChar(T, X, NewI, NewList, Ans),!.

indChar([_|T], X, I, List, Ans) :- 
    NewI is I + 1, 
    indChar(T, X, NewI, List, Ans),!.

indChar([], _, _, Ans, Ans) :- !.

% 2.1

task2_1 :- see('LR14_Files/file1.txt'), rSList(StringsList), seen, maxLengthList(StringsList, MaxLen), write(MaxLen),!.

count([X|T], Ans) :- 
    count([X|T], 0, Ans).

count([_|T], Count, Ans) :- 
    NewCount is Count + 1, 
    count(T, NewCount, Ans), !.

count([], Ans, Ans) :- !.



rSList(List) :- 
    readString(A,_,Flag), 
    rSList([A],List,Flag).

rSList(List,List,1) :- !.

rSList(Cur_list,List,0) :- 
    readString(A,_,Flag), 
    (not(A = []), appendString(Cur_list,[A],C_l),
    rSList(C_l,List,Flag); 
    rSList(Cur_list,List,Flag)),!.



maxLengthList(List, Ans) :- 
    maxLengthList(List, 0, Ans).

maxLengthList([H|T], CurMax, Ans) :- 
    count(H, NewMax), 
    NewMax > CurMax, 
    maxLengthList(T, NewMax, Ans), !.

maxLengthList([_|T], CurMax, Ans) :- 
    maxLengthList(T, CurMax, Ans), !.

maxLengthList([], Ans, Ans) :- !.
