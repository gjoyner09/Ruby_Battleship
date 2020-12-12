require_relative('../board.rb')

describe Board do
    it 'should initialize a Board instance with a boat array of length 5' do
        test = Board.new
        expect(test.boats.length).to eq(5)
    end
end