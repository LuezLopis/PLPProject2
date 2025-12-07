big_map([[s,w,f,f],
         [f,w,f,w],
         [f,f,f,w],
         [w,f,e,w]]).
big_instruct([down, down, right, right, down, left, down, left]).     
spiral_map([[s,f,f,f],
            [w,w,f,w],
            [f,f,f,w],
            [w,f,w,w],
            [e,f,f,f]]).
spiral_instruct([right, right, down, down, left, down, down, right]).

find_exit(Maze, Instructlst) :- 
    first_row(Maze, Row), 
    find_start(s, Row, Loc),
    % function to take us to start
   wander(Maze, Instructlst, 0, Loc, s).

find_start(Start, Row, Column) :-
    find_start_helper(Start, Row, 0, Column).

find_start_helper(Start , [Start|_], Acc, Acc):- % ends after start is found
    write('Start has been found, beginning...'), nl, !.

find_start_helper(Start , [_|T], CurrAcc, Loc) :-
    NextAcc is CurrAcc + 1, 
    find_start_helper(Start, T, NextAcc, Loc).

first_row([H|_], H). 

maze_element(Matrix, R, C, Element) :-
    nth0(R, Matrix, Row),   % Get the row
    nth0(C, Row, Element).  % Get element from that row

wander(Maze, Instructlst, CurrR, CurrC, e) :- % exit has been found has been found
    write('Exit has been found '), nl, !.

wander(_, [], _, _, CurrVal) :- 
    CurrVal \= e,
    write('Out of Instruction '), nl, fail.    

wander(Maze, _, _, _, w):- % not caring about any but if spot is wall then failure
    write('Hit wall...'), nl, fail.

wander(Maze, [Direct|Remainlst], CurrR, CurrC, CurrVal) :-
    (CurrVal = s; CurrVal = f), % current spot is valid and not the exit
    write('Wandering, '),
    do_direct(Direct, CurrR, CurrC, NEWR, NEWC), % manipulates the coordinate of the curr to the next instruction direction
    maze_element(Maze, NEWR, NEWC, NextSpot), % takes out the next location 
    wander(Maze, Remainlst, NEWR, NEWC, NextSpot).

do_direct(left, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC - 1,
    write('Moving Left, ').

do_direct(right, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC + 1,
    write('Moving Right, ').

do_direct(up, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR - 1,
   write('Moving Up, ').

do_direct(down, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR + 1,
   write('Moving Down, ').
