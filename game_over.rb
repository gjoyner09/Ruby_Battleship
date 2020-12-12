def done(board)
    if board.join.count("C") == 5 &&
        board.join.count("B") == 4 &&
        board.join.count("D") == 3 &&
        board.join.count("S") == 3 &&
        board.join.count("P") == 2
            puts "The game is over!"
            return true
    else
        return false
    end
end