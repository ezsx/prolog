
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

% 2.2

task2_2 :- 
    see('LR14_Files/file1.txt'), 
    readStringList(StringsList), 
    seen, 
    countStrNoSpace(StringsList, Count), 
    write(Count),!.

countChar(Str, Char, Ans) :- 
    char_code(Char, CharCode), 
    countChar(Str, CharCode, 0, Ans).

countChar([S|T], Char, Count, Ans) :- 
    S = Char, 
    NewCount is Count + 1, 
    countChar(T, Char, NewCount, Ans),!.

countChar([_|T], Char, Count, Ans) :- 
    countChar(T, Char, Count, Ans), !.

countChar([], _, Ans, Ans) :- !.



countStrNoSpace(StringsList, Ans) :- 
    countStrNoSpace(StringsList, 0, Ans),!.

countStrNoSpace([H|T], Count, Ans) :- 
    countChar(H, " ", SpaceCount), 
    SpaceCount is 0, 
    NewCount is Count + 1, 
    countStrNoSpace(T, NewCount, Ans),!.

countStrNoSpace([_|T], Count, Ans) :- 
    countStrNoSpace(T, Count, Ans),!.

countStrNoSpace([], Ans, Ans) :- !.

% 2.3

task2_3 :- 
    see('LR14_Files/file2.txt'), 
    rSList(StringsList), 
    seen, 
    count(StringsList, Len), 
    countCharList(StringsList, "a", Count1), 
    countCharList(StringsList, "A", Count2), 
    Count is Count1 + Count2, 
    Avg is Count / Len, 
    wSMoreA(StringsList, Avg).



countCharList(List, Char, Ans) :- 
    countCharList(List, Char, 0, Ans),!.

countCharList([H|T], Char, Count, Ans) :- 
    countChar(H, Char, Count1), 
    NewCount is Count + Count1, 
    countCharList(T, Char, NewCount, Ans),!.

countCharList([], _, Ans, Ans) :- !.



wSMoreA([H|T], Avg) :- 
    countChar(H, "a", Count1), 
    countChar(H, "A", Count2), 
    Count is Count1 + Count2, 
    Count > Avg, 
    wS(H), nl,
    wSMoreA(T, Avg),!.

wSMoreA([_|T], Avg) :- wSMoreA(T, Avg), !.

wSMoreA([], _) :- !.


% 2.4

task2_4 :- 
    see('LR14_Files/file3.txt'), 
    rSList(StringList), 
    seen, 
    strListToStr(StringList, BigString), 
    mostCommonWordList(BigString, Word), 
    writeString(Word).


mostCommonWordList(Words, Ans) :- 
    mostCommonWord(Words, Words, 0, [], Ans).


strListToStr(StrList, Ans) :- 
    strListToStr(StrList, [], Ans).

strListToStr([H|T], List, Ans) :- 
    splitString(H, " ", StrWords), 
    appendString(List, StrWords, NewList),
    strListToStr(T, NewList, Ans), !.

strListToStr([], Ans, Ans) :- !.

% 2.5

task2_5 :- 
    see('LR14_Files/file4.txt'), 
    rSList(StrList), 
    seen, 
    strListToStr(StrList, Words), 
    repeatingWords(Words, RepWords),
    tell('LR14_Files/outFile2_5.txt'), 
    writeNoRepeatingWordsStrings(StrList, RepWords), 
    told. 


inList([X|_], X).
inList([_|T] ,X) :- inList(T, X).

containsList(List, [H|_]) :- inList(List, H), !.
containsList(List, [_|T]) :- containsList(List, T).



repeatingWords(Words, Ans) :- 
    repeatingWords(Words, [], [], Ans).

repeatingWords([H|T], List, RepList, Ans) :- 
    inList(List, H), 
    appendString(List, [H], NewList),
    appendString(RepList, [H], NewRepList),  
    repeatingWords(T, NewList, NewRepList, Ans),!.

repeatingWords([H|T], List, RepList, Ans) :- 
    appendString(List, [H], NewList), 
    repeatingWords(T, NewList, RepList, Ans),!.

repeatingWords([], _, Ans, Ans) :- !.



writeNoRepeatingWordsStrings([H|T], RepWords) :- 
    splitString(H, " ", Words), 
    not(containsList(Words, RepWords)), 
    writeString(H), nl, 
    writeNoRepeatingWordsStrings(T, RepWords), !.

writeNoRepeatingWordsStrings([_|T], RepWords) :- 
    writeNoRepeatingWordsStrings(T, RepWords), !.

writeNoRepeatingWordsStrings([], _) :- !.


