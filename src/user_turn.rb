require_relative('board.rb')
require_relative('print_board.rb')

# method for the user's turn
def user_turn(c_b, u_g_b, boats, fast)
    puts "Here is your guessed board:"
    sleep(1) if !fast
    puts
    print_board_outside_class(u_g_b)
    puts
    sleep(1) if !fast
    puts "Please enter the space you would like to guess (e.g. D6):"
    space = gets.chomp
    rowcol = Board.space_to_row_col(space)
    # checks validity of user input
    loop do
        if rowcol == false
            sleep(0.5) if !fast
            puts "That entry is invalid. Please try again:"
            space = gets.chomp
            rowcol = Board.space_to_row_col(space)
        elsif u_g_b[rowcol[0]][rowcol[1]] != "."
            sleep(0.5) if !fast
            puts "You've already guessed that space. Please try again:"
            space = gets.chomp
            rowcol = Board.space_to_row_col(space)
        else
            break
        end
    end
    row = rowcol[0]
    col = rowcol[1]

    # updates the user's guessed board and informs the user of the result
    lett = c_b[row][col]
    lett == "." ? u_g_b[row][col] = "x" : u_g_b[row][col] = c_b[row][col]
    # if miss
    if lett == "."
        sleep(0.5) if !fast
        puts "Miss"
    # if hit
    else
        sleep(0.5) if !fast
        boat_arr = boats.select { |x| x[:letter] == lett }
        boat = boat_arr[0]
        puts "Hit! #{boat[:name]}!"
        str = u_g_b.join
        if str.count(lett) == boat[:length]
            sleep(0.5) if !fast
            puts "You've sunk the #{boat[:name]}!"
        end
    end

    # shows the user the state of her/his board
    sleep(1) if !fast
    puts "Here is your guessed board:"
    sleep(1) if !fast
    print_board_outside_class(u_g_b)

end