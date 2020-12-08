require_relative(board.rb)

def user_turn(comp_board, user_guess_board)

    puts "Please enter the space you would like to guess (e.g. D6):"
    space = gets.chomp
    loop do
        rowcol = space_to_row_col(space)
        if rowcol == false
            puts "That entry is invalid. Please try again:"
        elsif user_guess_board[rowcol[0]][rowcol[1]] != "."
            puts "You've already guessed that space. Please try again:"
        else
            break
        end
    end
    row = rowcol[0]
    col = rowcol[1]

    user_guess_board[row][col] = comp_board[row][col]
    letter = comp_board[row][col]
    if lett == "."
        puts "Miss"
    else
        boat = comp_board.boats.select { |x| x[:letter] == lett }
        puts "Hit! #{boat[:name]}!"
        str = user_guess_board.join
        if str.count(lett) == boat[:length]
            puts "You've sunk the #{boat[:name]}!"
        end
    end

    over = false
    str = user_guess_board.join
    over = true if str.count(".") == 47
    return over

end