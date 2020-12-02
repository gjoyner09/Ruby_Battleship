# puts "    A B C D E F G H"
# puts "    _ _ _ _ _ _ _ _"
# puts "1 | . . . . . . . ."
# puts "2 | . . . B B B . . "
# puts "3 | . . . . . . . ."
# puts "4 | . B . . . . . ."
# puts "5 | . B . . . . . ."
# puts "6 | . B . . . . . ."

Class Board

    attr_reader :carrier, :battleship, :destroyer, :submarine, :patrol_boat

    # Sets up a blank board
    def initialize
        @board = []
        @row = [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
        10.times { @board.push(@row) }
        @carrier = {length: 5, letter: "C"}
        @battleship = {length: 4, letter: "B"}
        @destroyer = {length: 3, letter: "D"}
        @submarine = {length: 3, letter: "S"}
        @patrol_boat = {length: 2, letter: "P"}
        return @board
    end

    # Determines if a desired boat placement is valid
    def valid?(length, row, column, direction)
        for i in 1..length
            if board[row-1][column-1] != "."
                return false
            else
                direction == "horizontal" ? column += 1 : row += 1
            end
        end
        return true
    end

    # Adds a boat to the board
    def add_boat(boat, board)
        
    end

    # Prints the board
    def print_board(board)
    end

end