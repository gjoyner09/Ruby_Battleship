require_relative('board.rb')
require_relative('ruby-battleship.rb')

def user_turn
    puts "Please enter the space you would like to guess (e.g. D6):"
    space = gets.chomp
    rowcol = Board.space_to_row_col(space)
    loop do
        if rowcol == false
            puts "That entry is invalid. Please try again:"
        elsif $user_guess_board.board[rowcol[0]][rowcol[1]] != "."
            puts "You've already guessed that space. Please try again:"
        else
            break
        end
    end
    row = rowcol[0]
    col = rowcol[1]

    
    lett = $computer_board.board[row][col]
    lett == "." ? $user_guess_board.board[row][col] = "x" : $user_guess_board.board[row][col] = $computer_board.board[row][col]
    if lett == "."
        puts "Miss"
    else
        boat = $computer_board.boats.select { |x| x[:letter] == lett }
        puts "Hit! #{boat[:name]}!"
        str = $user_guess_board.board.join
        if str.count(lett) == boat[:length]
            puts "You've sunk the #{boat[:name]}!"
        end
    end

    puts "Here is your guessed board:"
    $user_guess_board.print_board

    over = false
    str = $user_guess_board.board.join
    over = true if str.count(".") == 47
    return over

end