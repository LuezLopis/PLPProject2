simple_map([[s,f,e]]).
basic_map([[w,s,w],
           [f,f,w],
           [e,w,w]]).

basic_instruct([down, left, down]).


find_exit(Maze, Instructlst) :- 
    first_row(Maze, Row1), 
    find_start(s, Row1, 0),
    % function to take us to start
   wander(Maze, Instructlst, 1, Loc, s).

find_start(Start, [], Loc):-
    write('There is no start '), nl.

find_start(Start , [H|_], Loc). % ends after start is found
find_start(Start , [_|T], Loc) :-
    find_start(Start, T, Loc1), Loc is Loc1 + 1.

first_row([[H|_]|_], H).

maze_element(Matrix, R, C, Element) :-
    nth0(R, Matrix, Row),   % Get the row
    nth0(C, Row, Element).  % Get element from that row

wander(Maze, Instructlst, CurrR, CurrC, CurrVal) :-
    (CurrVal = s; CurrVal = f), % current spot is valid and not the exit
    next_spot_is( Instructlst, CurrR, CurrC). % checks the next location
    
wander(Maze, Instructlst, CurrR, CurrC, CurrVal) :- 
    CurrVal = e, % exit has been found has been found
    write('Exit has been found '), nl.

wander(Maze, [], CurrC, CurrR, CurrVal) :- 
    write('Out of Instruction '), nl.    

next_spot_is(Currlst, R1, C1) :- % if the spot is f(floor) or s(start) then read next instruct
    read_instruct(Currlst, Direct, Remainlst), % reads instruction
    do_direct(Direct), % manipulates the coordinate of the curr to the next instruction direction
    maze_element(Maze, R1, C1, NextSpot), % takes out the next location 
    is_wall(NextSpot).

is_wall(Spot) :-
    Spot == w, % if there is a wall don't do instruct
    wander(Maze, Remainlst, CurrR, CurrC, CurrVal).

is_wall(Spot) :-
    Spot \== w, % if not a wall then proceed to next spot
    wander(Maze, Remainlst, R1, C1, NextSpot).

read_instruct([H|T], Direct, Remainlst) :-
    Direct = H,
    Remainlst = T. 

do_direct(left) :- 
    C1 is C, C is C1 - 1.

do_direct(right) :- 
    C1 is C, C is C1 + 1.

do_direct(up) :- 
   R1 is R, R is R1 - 1.

do_direct(down) :- 
   R1 is R, R is R1 + 1.
