simple_map([[s,f,e]]).
basic_map([[w,s,w],
           [f,f,w],
           [e,w,w]]).

basic_instruct([down, left, down]).

find_exit(Maze, Instructlst) :- 
    first_row(Maze, Row1), 
    find_start(s, Row1, 0, Loc),
    % function to take us to start
   wander(Maze, Instructlst, 1, Loc, s).

find_start(Start, [], Loc):-
    write('There is no start '), nl.

find_start(Start , [H|_], Acc, Loc).% ends after start is found
find_start(Start , [_|T], Acc, Loc) :-
    find_start(Start, T, Acc, Loc), Loc is Acc + 1.

first_row([[H|_]|_], H).

maze_element(Matrix, R, C, Element) :-
    nth0(R, Matrix, Row),   % Get the row
    nth0(C, Row, Element).  % Get element from that row

wander(Maze, Instructlst, CurrR, CurrC, e) :- % exit has been found has been found
    write('Exit has been found '), nl.

wander(Maze, [], CurrR, CurrC, CurrVal) :- 
    write('Out of Instruction '), nl.    

wander(Maze, Instructlst, CurrR, CurrC, CurrVal) :-
    (CurrVal = s; CurrVal = f), % current spot is valid and not the exit
    next_spot_is(Maze, Instructlst, CurrR, CurrC). % checks the next location 

next_spot_is(Maze, Currlst, CurrR, CurrC) :- % if the spot is f(floor) or s(start) then read next instruct
    read_instruct(Currlst, Direct, Remainlst), % reads instruction
    do_direct(Direct, CurrR, CurrC, NEWR, NEWC), % manipulates the coordinate of the curr to the next instruction direction
    maze_element(Maze, NEWR, NEWC, NextSpot), % takes out the next location 
    is_wall(Maze, Remainlst, CurrR, CurrC, CurrVal, NEWR, NEWC, NextSpot).

is_wall(Maze, Remainlst, CurrR, CurrC, CurrVal, NEWR, NEWC, Spot) :-
    Spot == w, % if there is a wall don't do instruct
    wander(Maze, Remainlst, CurrR, CurrC, CurrVal).

is_wall(Maze, Remainlst, CurrR, CurrC, CurrVal, NEWR, NEWC, Spot) :-
    Spot \== w, % if not a wall then proceed to next spot
    wander(Maze, Remainlst, NEWR, NEWC, Spot).

read_instruct([H|T], Direct, Remainlst) :-
    Direct = H,
    Remainlst = T. 

do_direct(left, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC - 1.

do_direct(right, OGR, OGC, OGR, NEWC) :- 
    NEWC is OGC + 1.

do_direct(up, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR - 1.

do_direct(down, OGR, OGC, NEWR, OGC) :- 
   NEWR is OGR + 1.
