# Include the module file
include("SudokuSolver.jl")

# Import the module
using .SudokuSolver

# Example Sudoku puzzle (0 represents empty cells)
puzzle = [
    5 3 0 0 7 0 0 0 0;
    6 0 0 1 9 5 0 0 0;
    0 9 8 0 0 0 0 6 0;
    8 0 0 0 6 0 0 0 3;
    4 0 0 8 0 3 0 0 1;
    7 0 0 0 2 0 0 0 6;
    0 6 0 0 0 0 2 8 0;
    0 0 0 4 1 9 0 0 5;
    0 0 0 0 8 0 0 7 9
]

# Solve the Sudoku puzzle
solution = solve_sudoku(puzzle)

if solution != nothing
    println("Sudoku puzzle solved:")
    print_solution(solution)
else
    println("No solution found for the given Sudoku puzzle.")
end