%simple_map([[s,f,e]]).
%basic_map([[w,s,w],
%           [f,f,w],
%           [e,w,w]]).

basic_instruct([down, left, down]).

find_exit(Maze, Instructlst) :- 
    first_row(Maze, Row1), 
    find_start(s, Row1, 0, Loc),
    % function to take us to start
   wander(Maze, Instructlst, 1, Loc, s).

find_start(Start, [], Acc, Loc):-
    write('There is no start '), nl.

find_start(Start , [Start|_], Acc, Acc).% ends after start is found
find_start(Start , [_|T], Acc, Loc) :-
    find_start(Start, T, Acc, Loc), Loc is Acc + 1.

first_row([[H|_]|_], H).

maze_element(Matrix, R, C, Element) :-
    nth0(R, Matrix, Row),   % Get the row
    nth0(C, Row, Element).  % Get element from that row

wander(Maze, Instructlst, CurrR, CurrC, e) :- % exit has been found has been found
    write('Exit has been found '), nl, !.

wander(Maze, [], CurrR, CurrC, CurrVal) :- 
    CurrVal \= e,
    write('Out of Instruction '), nl, fail.    

wander(Maze, _, _, _, w):- % not caring about any but if spot is wall then failure
    write('Hit wall...'), nl, fail.

wander(Maze, [Direct|Remainlst], CurrR, CurrC, CurrVal) :-
    (CurrVal = s; CurrVal = f), % current spot is valid and not the exit
    do_direct(Direct, CurrR, CurrC, NEWR, NEWC), % manipulates the coordinate of the curr to the next instruction direction
    maze_element(Maze, NEWR, NEWC, NextSpot), % takes out the next location 
    wander(Maze, Remainlst, NEWR, NEWC, NextSpot).

do_direct(left, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC - 1.

do_direct(right, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC + 1.

do_direct(up, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR - 1.

do_direct(down, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR + 1.
