
/* Exercise 1 */

when(275,10).
when(261,12).
when(381,11).
when(398,12).
when(399,12).

where(275,owen102).
where(261,dear118).
where(381,cov216).
where(398,dear118).
where(399,cov216).

enroll(mary,275).
enroll(john,275).
enroll(mary,261).
enroll(john,381).
enroll(jim,399).

/* (a) Schedule/3 - S: Student, P: Place, T: Time, C: Course */
schedule(S, P, T) :- enroll(S, C), when(C, T), where(C, P).

/* (b) Usage/2 - P: Place, T: Time */
usage(P, T) :- when(C, T), where(C, P).

/* (c) Conflict/2 - C1: Course 1, C2: Course 2: */
conflict(C1,C2) :- where(C1,X), where(C2,X), when(C1,Y), when(C2,Y), C1\=C2.

/* (d) Meet/2 - S: Student 1, R: Student 2 */
meet(S,R) :- schedule(S,P,T), schedule(R,P,T), schedule(S,P,T1), schedule(R,P,T2), T1\==T2+1.

/* Exercise 2 */
/* (a) rdup */
rdup([],[]).
rdup([A|L],M) :- L = [A|_], rdup(L,M).
rdup([A|L],[A|M]) :- rdup(L,M).

/* (b) flat */
flat([], []).
flat([A|L], F) :- flat(A, B) , flat(L, M) , append(B, M, F).
flat(L, [L]).

/* (c) project/3 */
project([], _, [], _).
project(_, [], [], _).
project([I|Is], [X|Xs], [X|Ls], P) :- I =:= P, project(Is, Xs, Ls, P+1).
project(Is, [_|Xs], Ls, P) :- project(Is, Xs, Ls, P+1).

project(Is, Xs, Ls) :- project(Is, Xs, Ls, 1).
