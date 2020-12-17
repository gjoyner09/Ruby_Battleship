# prints the board with colors (for use in files that can't access the different instances of the Board from ruby_battleship.rb)
def print_board_outside_class(board)
    color_board = board.map do |x|
        x.map do |y|
            if y != "."
                y == "x" ? y = y.blue : y = y.red
            else
                y = "."
            end
        end
    end
    puts "    A B C D E F G H"
    puts "    _ _ _ _ _ _ _ _"
    for i in 1..8
        puts "#{i} | #{color_board[i-1].join(" ")}"
    end
end