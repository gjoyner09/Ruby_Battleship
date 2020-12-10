require_relative('board.rb')
require_relative('print-board.rb')

def user_turn(c_b, u_g_b, boats)
    puts "Please enter the space you would like to guess (e.g. D6):"
    space = gets.chomp
    rowcol = Board.space_to_row_col(space)
    loop do
        if rowcol == false
            puts "That entry is invalid. Please try again:"
        elsif u_g_b[rowcol[0]][rowcol[1]] != "."
            puts "You've already guessed that space. Please try again:"
        else
            break
        end
    end
    row = rowcol[0]
    col = rowcol[1]

    
    lett = c_b[row][col]
    lett == "." ? u_g_b[row][col] = "x" : u_g_b[row][col] = c_b[row][col]
    if lett == "."
        puts "Miss"
    else
        boat_arr = boats.select { |x| x[:letter] == lett }
        boat = boat_arr[0]
        puts "Hit! #{boat[:name]}!"
        str = u_g_b.join
        if str.count(lett) == boat[:length]
            puts "You've sunk the #{boat[:name]}!"
        end
    end

    puts "Here is your guessed board:"
    print_board_outside_class(u_g_b)

    over = false
    str = u_g_b.join
    over = true if str.count(".") == 47
    return over

end