# A* search algorithm implemented as maze solver
The code uses an A* algorithm in order to solve an input maze, searching its solution path and visually representing it.


This search algorithm perform a complete, admissible and optimal search of a target.
The A* in this code, writed in MATLAB, is implemented as a function.

Function input: Square Matrix, that represents a maze, being '1' walls, '0' free positions, '3' start point, '9' target point.
Example:
maze = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 0 0 0 0 0 0 0 1 0 0 0 0 0 1;
       1 0 1 1 1 1 1 0 1 0 1 1 1 0 1;
       1 0 1 0 0 0 0 0 1 0 1 0 1 0 1; 
       3 0 1 0 1 1 1 1 1 0 1 0 1 0 1;
       1 0 1 0 0 0 0 0 0 0 0 0 1 0 1;
       1 0 1 0 1 1 1 1 1 1 1 0 1 0 1;
       1 0 1 0 0 0 0 0 1 0 0 0 1 0 1;
       1 0 1 0 1 0 1 0 1 1 1 1 1 0 1;
       1 0 1 0 1 0 1 0 1 0 0 0 0 0 1;
       1 0 1 0 1 0 1 0 1 0 1 1 1 1 1;
       1 0 0 0 1 0 1 0 1 9 0 0 0 0 1;
       1 1 1 1 1 0 1 1 1 1 1 1 1 0 1;
       1 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
 Function output:
 -Matrix maze map. This matrix is exactly the same as the input matrix but containing the solution path from the start point to the final target.
  It has represented the solution path with '5'.
 -Solution path vector. It contains all the solution positions from start to final, giving its row-column position.
 
 
