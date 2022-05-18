
%11 max prost del chisla
max_prost_del(X):-max_prost_del(2,X).
max_prost_del(X,X):-!.
max_prost_del(K,X):- Ost is X mod K, Ost=0,!,fail.
max_prost_del(K,X):-K1 is K+1,max_prost_del(K1,X).