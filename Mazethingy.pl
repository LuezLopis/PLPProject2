simple_map([[s,f,e]]).
basic_map([[w,s,w],
           [f,f,w],
           [e,w,w]]).


find_exit(Maze, Instructlst) :- 
    first_row(Maze, Row1), 
    find_start(s, Row1, 0),
    % function to take us to start
   wander(Maze, Instructlst, 1, Loc, s)
  


find_start(Start , [H|_], Loc). // ends after start is found
find_start(Start , [_|T], Loc) :-
    find_start(Start, T, Loc1), Loc is Loc1 + 1.

first_row([[H|_]|_], H).

maze_element(Matrix, R, C, Element) :-
    nth0(R, Matrix, Row),   % Get the row
    nth0(C, Row, Element).  % Get element from that row

wander(Maze, Instructlst, CurrR, CurrC) :-
    maze_element(Maze, CurrR, CurrC, CurrVal), % takes out the current location  
    CurrVal = e,
    !,    % will exit if exit is found
    read_instruct(Instructlst), % reads instruction
    do_direct(Direct), // 
    
           
read_instruct([H|T]) :-
    Direct = H; 

do_direct(left) :- 
    C1 is C, C is C1 - 1.

do_direct(right) :- 
    C1 is C, C is C1 + 1.

do_direct(up) :- 
   R1 is R, R is R1 - 1.

do_direct(down) :- 
   R1 is R, R is R1 + 1.

