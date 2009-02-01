adjacent(1,2).         adjacent(2,1). 
adjacent(1,3).         adjacent(3,1). 
adjacent(1,4).         adjacent(4,1). 
adjacent(1,5).         adjacent(5,1). 
adjacent(2,3).         adjacent(3,2). 
adjacent(2,4).         adjacent(4,2). 
adjacent(3,4).         adjacent(4,3). 
adjacent(4,5).         adjacent(5,4). 

color(1,red,a).    color(1,red,b). 
color(2,blue,a).   color(2,blue,b). 
color(3,green,a).  color(3,green,b). 
color(4,yellow,a). color(4,blue,b). 
color(5,blue,a).   color(5,green,b). 

conflict(R1,R2,Coloring) :- 
   adjacent(R1,R2), 
   color(R1,Color,Coloring), 
   color(R2,Color,Coloring). 

fib(1, 1).
fib(2, 1).
fib(X, Y):-
    X > 0,
    X1 is X-1,
    X2 is X-2,
    fib(X1, F1),
    fib(X2, F2),
    Y is F1 + F2.

istwo:-
	1+1 is 2.

factorial(0,F,F). 

factorial(N,A,F) :-  
    N > 0, 
    A1 is N*A, 
    N1 is N -1, 
    factorial(N1,A1,F). 

tr(A, A).

move(1,X,Y,_) :-  
    write('Move top disk from '), 
    write(X), 
    write(' to '), 
    write(Y), 
    nl. 
move(N,X,Y,Z) :- 
    N>1, 
    M is N-1, 
    move(M,X,Z,Y), 
    move(1,X,Y,_), 
    move(M,Z,Y,X).  

    
