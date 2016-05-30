
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



/* Exercise 2 */
