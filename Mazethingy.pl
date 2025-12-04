simple_map([[s,f,e]]).
basic_map([[w,s,w],
           [f,f,w],
           [e,w,w]]).


find_exit(Maze, Instructlst) :- 
  first_row(Maze, Row1), find_start(s, Row1, 0)

find_start(Start , [H|_], Loc). // ends after start is found
find_start(Start , [_|T], Loc) :-
  find_start(Start , T).

first_row([[H|_]|_], H).
