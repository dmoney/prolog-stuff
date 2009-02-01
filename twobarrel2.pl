fill([B, Q, C], [B, C, C]) :-
   Q < C.
empty([B, Q, C], [B, 0, C]) :-
   Q > 0.
pour([B1, Q1, C1], [B2, Q2, C2], [B1, Q1new, C1], [B2, Q2new, C2]) :-
   Q1 >0,
   Q2 < C2,
   Dif2 is C2 - Q2,
   not(Q1 > Dif2), /* support <= ? gives me error */
   Q1new is 0,
   Q2new is Q2 + Q1.
pour([B1, Q1, C1], [B2, Q2, C2], [B1, Q1new, C1], [B2, Q2new, C2]) :-
   Q1 >0,
   Q2 < C2,
   Dif2 is C2 - Q2,
   Q1 > Dif2,
   Q1new is Q1 - Dif2,
   Q2new is C2.

right([_B, Q, _C], _, Q).
right(_, [_B, Q, _C], Q).
/*right([_BL, QL, _CL], [_BR, QR, _CR], X) :-
   X is QL + QR.*/
   
quantity([_B, Q, _R], Q).

get(X, L, R, Hist, Hist) :-
   right(L, R, X).
get(X, L, R, Hist, Hist2) :-
   op(L, R, O, L2, R2),
   quantity(L2, QL2),
   quantity(R2, QR2),
   not(member([_, QL2, QR2], Hist)),
   append(Hist, [[O, QL2, QR2]], Hist1),
   get(X, L2, R2, Hist1, Hist2).

get(X, Lcap, Rcap, Hist) :-
   get(X, [left, 0, Lcap], [right, 0, Rcap], [[start, 0, 0]], Hist).



op(L, R, empty_l, L2, R) :-
   empty(L, L2).
op(L, R, empty_r, L, R2) :-
   empty(R, R2).
op(L, R, fill_l, L2, R) :-
   fill(L, L2).
op(L, R, fill_r, L, R2) :-
   fill(R, R2).
op(L, R, pour_lr, L2, R2) :-
  pour(L, R, L2, R2).
op(L, R, pour_rl, L2, R2) :-
  pour(R, L, R2, L2).

/* unit tests */
fill_works :-
  not(fill([b, 5, 5], _X1)),
  fill([b, 4, 5], [b, 5, 5]),
  not(fill([b, 4, 5], [c, _X2, _Y2])).

empty_works :-
  not(empty([b, 0, 0], _X)),
  empty([b, 5, 0], [b, 0, 0]),
  empty([b, 5, _], [b, 0, _]).
  
pour_works :-
  not(pour([left, 0, 5], [right, 0, 5], _L, _R)),
  pour([left, 1, 5], [right, 0, 5], [left, 0, 5], [right, 1, 5]),
  pour([left, 3, 5], [right, 1, 3], [left, 1, 5], [right, 3, 3]).

right_works :-
  not(right([left, 5, 5], [right, 3, 4], 10)),
  right([left, 5, 5], [right, 3, 4], 3),
  right([left, 5, 5], [right, 3, 4], 8).

