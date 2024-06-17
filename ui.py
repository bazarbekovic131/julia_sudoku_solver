import sys
from PyQt5.QtWidgets import QApplication, QWidget, QGridLayout, QPushButton, QLineEdit, QLabel
from julia import Julia, Main

# Initialize Julia and load the SudokuSolver module
Julia(compiled_modules=False)
Main.include("SudokuSolver.jl")

class SudokuSolverGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.grid = QGridLayout()
        self.setLayout(self.grid)
        self.entries = []

        for i in range(9):
            row = []
            for j in range(9):
                entry = QLineEdit(self)
                entry.setMaxLength(1)
                entry.setFixedSize(40, 40)
                self.grid.addWidget(entry, i, j)
                row.append(entry)
            self.entries.append(row)

        self.solve_button = QPushButton('Solve', self)
        self.solve_button.clicked.connect(self.solve_sudoku)
        self.grid.addWidget(self.solve_button, 9, 0, 1, 9)

        self.result_label = QLabel(self)
        self.grid.addWidget(self.result_label, 10, 0, 1, 9)

        self.setWindowTitle('Sudoku Solver')
        self.setGeometry(300, 300, 400, 400)
        self.show()

    def solve_sudoku(self):
        grid = []
        for i in range(9):
            row = []
            for j in range(9):
                text = self.entries[i][j].text()
                value = int(text) if text.isdigit() else 0
                row.append(value)
            grid.append(row)

        # Convert the grid to a Julia matrix and solve
        julia_grid = Main.eval("reshape({}, 9, 9)".format(grid))
        solution = Main.solve_sudoku(julia_grid)

        if solution is not None:
            for i in range(9):
                for j in range(9):
                    self.entries[i][j].setText(str(solution[i + 1, j + 1]))
            self.result_label.setText('Sudoku solved!')
        else:
            self.result_label.setText('No solution found.')

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = SudokuSolverGUI()
    sys.exit(app.exec_())
