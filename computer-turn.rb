require_relative('board.rb')

def computer_turn
# need action for if they have an unsunk ship

    # if no outstanding unsunk ships, then computer makes a random guess
    loop do
        a = rand(8)
        b = rand(8)
        if $comp_guess_board.board[a,b] != "."
            lett = $user_board.board[a,b]
            $comp_guess_board.board[a,b] = lett
            puts "The computer guessed #{Board.rowcol_to_space([a,b])}."
            if lett == "."
                puts "The computer's guess was a miss."
            else
                puts "The computer's guess was a hit!"
                boat = $computer_board.boats.select { |x| x[:letter] == lett }
                puts "The computer hit your #{boat[:name]}."
                str = $comp_guess_board.board.join
                if str.count(lett) == boat[:length]
                    puts "The computer has now sunk your #{boat[:name]}."
                end
            end
            break
        end
    end

end