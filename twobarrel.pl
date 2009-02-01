/* two barrels problem */
/* works on get(3, 5, 2). fails on get(3, 2, 5). overflow on get(100, 5, 2).
*/

/* pour from barrel containing X1 to barrel
 * containing Y1 with capacity Ycap,
 * giving barrels containing X2 and Y2
 */
pour(X1, Y1, Ycap, X2, Y2) :-
    X1 > 0,
    Y1 < Ycap,
    Ydif is Ycap - Y1,
    X1 >= Ydif,
    X2 is X1 - Ydif,
    Y2 is Ycap.

pour(X1, Y1, Ycap, X2, Y2) :-
    X1 > 0,
    Y1 < Ycap,
    Ydif is Ycap - Y1,
    X1 < Ydif,
    Xdif is Ydif - X1,
    X2 is X1 - Xdif,
    Y2 is Y1 + Xdif.

/* empty or fill barrel containing X1
 */
empty(X1, 0) :-   
    X1 > 0.
fill(X1, Xcap, X2):-
    X1 < Xcap,
    X2 is Xcap.

/* perform any of the above operations on the two barrels
 */
op(L1, _Lcap, R1, Rcap, L2, R2) :-
    pour(L1, R1, Rcap, L2, R2).
op(L1, Lcap, R1, _Rcap, L2, R2) :-
    pour(R1, L1, Lcap, R2, L2).
op(L1, _Lcap, R1, _Rcap, L2, R1) :-
    empty(L1, L2).
op(L1, _Lcap, R1, _Rcap, L1, R2) :-
    empty(R1, R2).
op(L1, Lcap, R1, _Rcap, L2, R1) :-
    fill(L1, Lcap, L2).
op(L1, _Lcap, R1, Rcap, L1, R2) :-
    fill(R1, Rcap, R2).

out(L, R):-
    write(L), write(' '), write(R), nl.

/* get X given L/Lcap(acity) and R/Rcap barrels
 */
get(X, L, Lcap, R, Rcap) :-
    op(L, Lcap, R, Rcap, L2, R2),
    L2 is X,
    out(L2, R2).
get(X, L, Lcap, R, Rcap) :-
    op(L, Lcap, R, Rcap, L2, R2),
    R2 is X,
    out(L2, R2).
get(X, L, Lcap, R, Rcap) :-
    op(L, Lcap, R, Rcap, L2, R2),
    [L2, R2] \= [0, 0],
    get(X, L2, Lcap, R2, Rcap),
    out(L2, R2).


get(X, Lcap, Rcap) :-
    get(X, 0, Lcap, 0, Rcap),
    out(0, 0).