# Function to check if a number can be placed in a given cell
function is_valid(solution, row, col, num)
    # Check the row
    for c in 1:9
        if solution[row][c] == num
            return false
        end
    end

    # Check the column
    for r in 1:9
        if solution[r][col] == num
            return false
        end
    end

    # Check the 3x3 sub-grid
    row_start = 3 * div(row - 1, 3) + 1
    col_start = 3 * div(col - 1, 3) + 1
    for r in row_start:row_start+2
        for c in col_start:col_start+2
            if solution[r][c] == num
                return false
            end
        end
    end

    return true
end

# Function to find an empty cell
function find_empty(solution)
    for r in 1:9
        for c in 1:9
            if solution[r][c] == 0
                return r, c
            end
        end
    end
    return nothing
end

# Backtracking solver
function solve_sudoku(solution)
    empty_cell = find_empty(solution)
    if empty_cell == nothing
        return true  # Solution found
    end

    row, col = empty_cell
    for num in 1:9
        if is_valid(solution, row, col, num)
            solution[row][col] = num
            if solve_sudoku(solution)
                return true
            end
            solution[row][col] = 0  # Reset cell
        end
    end

    return false  # No valid number found, backtrack
end

# Function to print the solution in a grid format
function print_solution(solution)
    for i in 1:9
        for j in 1:9
            print(solution[i][j], " ")
            if j % 3 == 0 && j != 9
                print("| ")
            end
        end
        println()
        if i % 3 == 0 && i != 9
            println("------+-------+------")
        end
    end
end

# Initial Sudoku grid
initial_solution = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]

# Solve the Sudoku puzzle
if solve_sudoku(initial_solution)
    println("Sudoku solution found:")
    print_solution(initial_solution)
else
    println("No solution exists for the given Sudoku puzzle.")
end
