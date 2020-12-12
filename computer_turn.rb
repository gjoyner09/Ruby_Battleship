require_relative('board.rb')
require 'colorize'

def computer_turn(u_b, c_g_b, boats)
    # checks to see if they have an unsunk ship
    a = false
    a = unsunk(a, c_g_b, boats)
    # if there's an outstanding unsunk ship, computer tries to sink it
    if a && !easy
        str = c_g_b.join
        lett = a[:letter]
        space = (str =~ /#{lett}/)
        x = space / 8
        y = space % 8
        if str.count(lett) == 1
            loop do
                x = space / 8
                y = space % 8
                loop do
                    dir = rand(4)
                    if dir == 0 && x < 7
                        x += 1
                        break
                    elsif dir == 1 && x > 0
                        x -= 1
                        break
                    elsif dir == 2 && y < 7
                        y += 1
                        break
                    elsif dir == 3 && y > 0
                        y -=1
                        break
                    end
                end
                begin
                    if c_g_b[x][y] == "."
                        result(x, y, u_b, c_g_b, boats)
                        break
                    end
                rescue
                end
            end
        else
            # lett = u_b[x][y]
            if x+1 < 8 && c_g_b[x+1][y] == lett
                loop do
                    random = rand(2)
                    begin
                        if random == 0
                            if c_g_b[x-1][y] == "."
                                result(x-1, y, u_b, c_g_b, boats)
                                break
                            end
                        else
                            if c_g_b[x+2][y] == lett
                                if c_g_b[x+3][y] == lett
                                    if c_g_b[x+4][y] == "."
                                        result(x+4, y, u_b, c_g_b, boats)
                                        break
                                    end
                                else
                                    if c_g_b[x+3][y] == "."
                                        result(x+3, y, u_b, c_g_b, boats)
                                        break
                                    end
                                end
                            else
                                if c_g_b[x+2][y] == "."
                                    result(x+2, y, u_b, c_g_b, boats)
                                    break
                                end
                            end
                        end
                    rescue
                    end
                end
            else
                loop do
                    random = rand(2)
                    begin
                        if random == 0
                            if c_g_b[x][y-1] == "."
                                result(x, y-1, u_b, c_g_b, boats)
                                break
                            end
                        else
                            if c_g_b[x][y+2] == lett
                                if c_g_b[x][y+3] == lett
                                    if c_g_b[x][y+4] == "."
                                        result(x, y+4, u_b, c_g_b, boats)
                                        break
                                    end
                                else
                                    if c_g_b[x][y+3] == "."
                                        result(x, y+3, u_b, c_g_b, boats)
                                        break
                                    end
                                end
                            else
                                if c_g_b[x][y+2] == "."
                                    result(x, y+2, u_b, c_g_b, boats)
                                    break
                                end
                            end
                        end
                    rescue
                    end
                end
            end
        end

    # if no outstanding unsunk ships, then computer makes a random guess
    else
        loop do
            x = rand(8)
            y = rand(8)
            if c_g_b[x][y] == "."
                result(x, y, u_b, c_g_b, boats)
                break
            end
        end
    end
    sleep(1) if !fast
    puts "Here is the computer's guessed board:"
    sleep(2) if !fast
    puts
    print_board_outside_class(c_g_b)
    puts
end

def unsunk(a, c_g_b, boats)
    str = c_g_b.join
    boats.each do |x| 
        if str.count(x[:letter]) > 0 && str.count(x[:letter]) < x[:length]
            a = x
        end
    end
    return a
end

def result(a, b, u_b, c_g_b, boats)
    lett = u_b[a][b]
    lett == "." ? c_g_b[a][b] = "x" : c_g_b[a][b] = lett
    sleep(2) if !fast
    puts "The computer guessed #{Board.rowcol_to_space([a,b])}."
    if lett == "."
        sleep(1) if !fast
        puts "The computer's guess was a miss."
    else
        sleep(1) if !fast
        puts "The computer's guess was a hit!"
        boat_arr = boats.select { |x| x[:letter] == lett }
        boat = boat_arr[0]
        sleep(1) if !fast
        puts "The computer hit your #{boat[:name]}."
        str = c_g_b.join
        if str.count(lett) == boat[:length]
            sleep(0.5) if !fast
            puts "The computer has now sunk your #{boat[:name]}."
        end
    end
end