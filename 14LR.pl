


/*
1 Дана строка. Вывести ее три раза через запятую и показать количе-
ство символов в ней.
2 Дана строка. Найти количество слов.
3 Дана строка, определить самое частое слово
4 Дана строка. Вывести первые три символа и последний три символа,
если длина строки больше 5 Иначе вывести первый символ столько
раз, какова длина строки.
5 Дана строка. Показать номера символов, совпадающих с последним
символом строки.
*/

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

/*
1 Дан файл. Прочитать из файла строки и вывести длину наибольшей
строки.
2 Дан файл. Определить, сколько в файле строк, не содержащих
пробелы.
3 Дан файл, найти и вывести на экран только те строки, в которых букв
А больше, чем в среднем на строку.
4 Дан файл, вывести самое частое слово.
5 Дан файл, вывести в отдельный файл строки, состоящие из слов, не
повторяющихся в исходном файле.
*/

% 2.1

task2_1 :- see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file1.txt'), rSList(StringsList), seen, maxLengthList(StringsList, MaxLen), write(MaxLen),!.

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
    see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file1.txt'), 
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
    see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file2.txt'), 
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
    see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file3.txt'), 
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
    see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file4.txt'), 
    rSList(StrList), 
    seen, 
    strListToStr(StrList, Words), 
    repeatingWords(Words, RepWords),
    tell('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/outFile2_5.txt'), 
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

% 3 - 3 Дана строка в которой слова записаны через пробел. Необходимо
% 		перемешать все слова этой строки в случайном порядке.


task3 :- 
    rS(Str, _),
    splitString(Str, " ", Words),
    randomSortList(Words, NewWords),
    wordsToString(NewWords, String),
    wS(String).



wordsToString([H|T], Ans) :-
    wordsToString([H|T], [], Ans),!.

wordsToString([H|T],  List, Ans) :-
    wordsToString2(H, List, NewList), 
    appendString(NewList, [32], NewList2),
    wordsToString(T, NewList2, Ans).

wordsToString([], Ans, Ans).

wordsToString2([H|T], List, Ans) :-
    appendString(List, [H], NewList),
    wordsToString2(T, NewList, Ans).

wordsToString2([], Ans, Ans).



valueByIndex([H|T], Index, Ans) :-
    valueByIndex([H|T], 0, Index, Ans),!.
    
valueByIndex([Ans|_], Index, Index, Ans).

valueByIndex([_|T], CurIndex, Index, Ans) :-
    NewCurIndex is CurIndex + 1,
    valueByIndex(T, NewCurIndex, Index, Ans).



swapInList([H|T], Index1, Index2, Ans) :-
    swapInList([H|T], [H|T], 0, Index1, Index2, [], Ans),!.

swapInList(List, [H|T], CurIndex, Index1, Index2, SpawList, Ans) :-
    NewCurIndex is CurIndex + 1,
    (
    CurIndex is Index1,
    valueByIndex(List, Index2, Value),
    appendString(SpawList, [Value], NewSpawList),
    swapInList(List, T, NewCurIndex, Index1, Index2, NewSpawList, Ans)
    ;
    CurIndex is Index2,
    valueByIndex(List, Index1, Value),
    appendString(SpawList, [Value], NewSpawList),
    swapInList(List, T, NewCurIndex, Index1, Index2, NewSpawList, Ans)
    ;
    appendString(SpawList, [H], NewSpawList),
    swapInList(List, T, NewCurIndex, Index1, Index2, NewSpawList, Ans)
    ).

swapInList(_, [], _, _, _, Ans, Ans).



randomSortList([H|T], Ans) :-
    count([H|T], Length),
    randomSortList([H|T], 0, 100, Length, Ans),!.

randomSortList([H|T], CurIndex, MaxIndex, Length, Ans) :-
    NewCurIndex is CurIndex + 1,
    NewCurIndex < MaxIndex,
    random(0, Length, RandIndex1),
    random(0, Length, RandIndex2),
    swapInList([H|T], RandIndex1, RandIndex2, NewList),
    randomSortList(NewList, NewCurIndex, MaxIndex, Length, Ans).

randomSortList(Ans, _, _, _, Ans).

% 4 - 8 Дана строка в которой записаны слова через пробел. Необходимо
%		посчитать количество слов с четным количеством символов.

task4 :- 
    rS(Str, _),
    splitString(Str, " ", Words),
    countUnevenWords(Words, 0, Count),
    write(Count),!.

countUnevenWords([H|T], Count, Ans) :-
    count(H, Count1),
    0 is Count1 mod 2,
    NewCount is Count + 1,
    countUnevenWords(T, NewCount, Ans).

countUnevenWords([_|T], Count, Ans) :-
    countUnevenWords(T, Count, Ans).

countUnevenWords([], Ans, Ans).

% 5 - 16	Дан массив в котором находятся строки "белый", "синий" и
%			"красный" в случайном порядке. Необходимо упорядочить массив так,
%			чтобы получился российский флаг.

task5 :- 
    see('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/file5.txt'), 
    rS(Str,_), 
    seen,
    splitString(Str, " ", Words),
    ruSort(Words, [], NewWords),
    wS(NewWords),!.


ruSort(OriginList, List, Ans) :-
    filterW(OriginList, Ans1),
    filterB(OriginList, Ans2),
    filterR(OriginList, Ans3),
    appendString(List, Ans1, List1),
    appendString(List1, Ans2, List2),
    appendString(List2, Ans3, List3),
    equelList(List3, Ans).

equelList(Ans, Ans).


filterW([H|T], Ans) :-
    filterW([H|T], [], Ans),!.

filterW([H|T], List, Ans) :-
    (filterStr(H, "w", List1),
    count(List1, Count),
    Count > 0,
    appendString(List, H, NewList),
    appendString(NewList, [32], NewList2),
    filterW(T, NewList2, Ans));
    filterW(T, List, Ans).

filterW([], Ans, Ans).



filterB([H|T], Ans) :-
    filterB([H|T], [], Ans),!.

filterB([H|T], List, Ans) :-
    (filterStr(H, "b", List1),
    count(List1, Count),
    Count > 0,
    appendString(List, H, NewList),
    appendString(NewList, [32], NewList2),
    filterB(T, NewList2, Ans));
    filterB(T, List, Ans).

filterB([], Ans, Ans).



filterR([H|T], Ans) :-
    filterR([H|T], [], Ans),!.

filterR([H|T], List, Ans) :-
    (filterStr(H, "r", List1),
    count(List1, Count),
    Count > 0,
    appendString(List, H, NewList),
    appendString(NewList, [32], NewList2),
    filterR(T, NewList2, Ans));
    filterR(T, List, Ans).

filterR([], Ans, Ans).



filterStr([H|T], Char, Ans):-
    char_code(Char, Code),
    filterStr([H|T], Code, [], Ans),!.

filterStr([Char|T], Char, List, Ans) :-
    appendString(List, [Char], NewList),
    filterStr(T, Char, NewList, Ans).

filterStr([_|T], Char, List, Ans) :-
    filterStr(T, Char, List, Ans).

filterStr([], _, Ans, Ans).


% 6.1

task6 :- 
    read(N),
    readList(N, List),
    read(K), 
    tell('C:/Users/scdco/Documents/Prolog/prolog/LR_14Files/outFile6.txt'),
    write(List), nl, write(" K = "), write(K), nl, nl, nl, nl,
    write("Размещения с повторениями из N по K: "), nl, nl,
    aRepWrite(List, K), nl, nl, nl,
    write("Перестановки из N: "), nl, nl,
    pWrite(List), nl, nl, nl,
    write("Размещения из N по K: "), nl, nl,
    aWrite(List, K), nl, nl, nl,
    write("Подмножества: "), nl, nl,
    subSetWrite(List), nl, nl, nl,
    write("Сочетания из N по K: "), nl, nl,
    cWrite(List, K), nl, nl, nl,
    write("Сочетания с повторениями из N по K: "), nl, nl,
    cRepWrite(List, K), nl, nl, nl,
    told.

readList(0, []) :- !.
readList(I, [X|T]) :- read(X), I1 is I - 1, readList(I1, T).



% 6.1 - Размещения из N по K с повторениями

aRepWrite(List, K) :- 
    not(aRepWriteInternal(List, K)).

aRepWriteInternal(List, K) :- 
    aRep(List, K, A), 
    write(A), nl, fail.

aRep(List, K, Ans) :- 
    aRep(List, K, [], Ans).

aRep(List, K, CurList, Ans) :-
    K > 0, 
    inList(List, X), 
    NewK is K - 1,
    aRep(List, NewK, [X|CurList], Ans). 

aRep(_, 0, Ans, Ans) :- !.



% 6.2 Перестановки из N

pWrite(List) :-
    count(List, K),
    aWrite(List, K).

p(List, Ans) :-
    count(List, K),
    a(List, K, Ans).



% 6.3 Размещения из N по K

inListNoRep([H|T],H,T).
inListNoRep([H|T],Elem,[H|Tail]):-inListNoRep(T,Elem,Tail).



aWrite(List, K) :-
    not(aWriteInternal(List, K)).

aWriteInternal(List, K) :- 
    a(List, K, A), 
    write(A), nl, fail.

a(List, K, Ans) :- 
    a(List, K, [], Ans).

a(List, K, CurPerm, Ans) :-
    K > 0,
    inListNoRep(List, X, NewList), 
    NewK is K - 1, 
    a(NewList, NewK, [X|CurPerm], Ans).

a(_, 0, Ans, Ans) :- !.



% 6.4 Подмножества

subSetWrite(List) :-
    not(subSetWriteInternal(List)).

subSetWriteInternal(List) :- 
    subSet(List, SubSet), 
    write(SubSet), nl, fail.

subSet([Elem|SetTail], [Elem|SubSetTail]) :- 
    subSet(SetTail, SubSetTail).

subSet([_|SetTail], SubSet) :- 
    subSet(SetTail, SubSet).

subSet([], []).



% 6.5 Сочетания из N по K

cWrite(List, K) :-
    not(cWriteInternal(List, K)).

cWriteInternal(List, K) :-
    c(List, K, C), 
    write(C), nl, fail.

c(_, 0, []) :- !.

c([Elem|SetTail], K, [Elem|SubSetTail]) :- 
    NewK is K-1, 
    c(SetTail, NewK, SubSetTail).

c([_|SetTail], K, SubSet) :- 
    c(SetTail, K, SubSet).



% 6.6 Сочетания с повторениями из N по K

cRepWrite(List, K) :-
    not(cRepWriteInternal(List, K)).

cRepWriteInternal(List, K) :-
    cRep(List, K, C), 
    write(C), nl, fail.

cRep(_, 0, []) :- !.

cRep([Elem|SetTail], K, [Elem|SubSetTail]) :- 
    NewK is K-1, 
    cRep([Elem|SetTail], NewK, SubSetTail).

cRep([_|SetTail], K, SubSet) :- 
    cRep(SetTail, K, SubSet).

% 7  Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в
%  	 которых ровно две буквы a. Вывод в файл.

task7 :- tell('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/outFile7.txt'), not(task7Internal), told.

task7Internal :-

    Positions = [0,1,2,3,4],
    Word = [_, _, _, _, _],

    c(Positions, 2, [PosA1, PosA2]),

    valueByIndex(Word, PosA1, a),
    valueByIndex(Word, PosA2, a),

    inListNoRep(Positions, PosA1, PositionsNoA), 
    inListNoRep(PositionsNoA, PosA2, [Pos1, Pos2, Pos3]),

    aRep([b,c,d,e,f], 3, [Char1, Char2, Char3]), 

    valueByIndex(Word, Pos1, Char1),
    valueByIndex(Word, Pos2, Char2),
    valueByIndex(Word, Pos3, Char3), 

    write(Word), nl, fail.
	
% 8   Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в
%     которых ровно 2 буквы a, остальные буквы не повторяются. Вывод в файл.

task8 :- tell('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/outFile8.txt'), not(task8Internal), told.

task8Internal :-

    Positions = [0,1,2,3,4],
    Word = [_, _, _, _, _],

    c(Positions, 2, [PosA1, PosA2]),

    valueByIndex(Word, PosA1, a),
    valueByIndex(Word, PosA2, a),

    inListNoRep(Positions, PosA1, PositionsNoA), 
    inListNoRep(PositionsNoA, PosA2, [Pos1, Pos2, Pos3]),

    a([b,c,d,e,f], 3, [Char1, Char2, Char3]), 

    valueByIndex(Word, Pos1, Char1),
    valueByIndex(Word, Pos2, Char2),
    valueByIndex(Word, Pos3, Char3), 

    write(Word), nl, fail.
	
% 9	Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в
%	которых ровно одна буква повторяется 2 раза, остальные буквы не
%	повторяются. Вывод в файл.

task9 :- tell('C:/Users/scdco/Documents/Prolog/prolog/LR14_Files/outFile9.txt'), not(task9Internal), told.

task9Internal :-

    Positions = [0,1,2,3,4],
    Word = [_, _, _, _, _],

    c(Positions, 2, [PosRep2Char1, PosRep2Char2]),

    Alphabet = [a,b,c,d,e,f],
    c(Alphabet, 1, [Rep2Char]),

    valueByIndex(Word, PosRep2Char1, Rep2Char),
    valueByIndex(Word, PosRep2Char2, Rep2Char),

    inListNoRep(Positions, PosRep2Char1, PositionsNoRep2Char), 
    inListNoRep(PositionsNoRep2Char, PosRep2Char2, [Pos1, Pos2, Pos3]),
    inListNoRep(Alphabet, Rep2Char, AlphabetNoRep2Char),

    a(AlphabetNoRep2Char, 3, [Char1, Char2, Char3]), 

    valueByIndex(Word, Pos1, Char1),
    valueByIndex(Word, Pos2, Char2),
    valueByIndex(Word, Pos3, Char3),

    write(Word), nl, fail.










