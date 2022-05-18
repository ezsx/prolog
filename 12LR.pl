
%11 max prost del chisla
easy(X):-easy(2,X).
easy(X,X):-!.
easy(K,X):- Ost is X mod K, Ost=0,!,fail.
easy(K,X):-K1 is K+1,easy(K1,X).