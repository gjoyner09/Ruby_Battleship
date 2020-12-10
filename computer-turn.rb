require_relative('board.rb')

def computer_turn
    # checks to see if they have an unsunk ship
    unsunk? = unsunk

    # if there's an outstanding unsunk ship, computer tries to sink it
    if unsunk?
        str = $comp_guess_board.board.join
        if str.count(unsunk[:letter]) == 1
            space = (str =~ /bar/)
            row = space / 8
            col = space % 8
            space_arr = [row, col]
            loop do
                dir = rand(4)
                case dir
                    when 0 then row += 1
                    when 1 then row -= 1
                    when 2 then col += 1
                    when 3 then col -= 1
                end
                begin
                    if computer_guess_board[row[col]] == "."
                        result(row,col)
                        break
                rescue
                end
            end
        else
        end

    # if no outstanding unsunk ships, then computer makes a random guess
    else
        loop do
            a = rand(8)
            b = rand(8)
            if $comp_guess_board.board[a,b] != "."
                result(a,b)
                break
            end
        end
    end
end

def unsunk
    str = $computer_guess_board.board.join
    unsunk? = false
    $computer_guess_board.boats.each do |x| 
        if str.count(x[:letter]) > 0 && str.count(x[:letter]) < x[:length]
            unsunk? = x
        end
    end
    return unsunk?
end

def result(a,b)
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
end