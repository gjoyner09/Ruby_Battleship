require_relative('../board.rb')

# tests that the program is working as it should
describe Board do
    it 'should initialize a Board instance with a board array of length 8' do
        test = Board.new
        expect(test.board.length).to eq(8)
    end

    it 'should initialize a Board instance with a boat array of length 5' do
        test = Board.new
        expect(test.boats.length).to eq(5)
    end

    it 'should turn C3 into [2,2]' do
        expect(Board.space_to_row_col('C3')).to eq([2,2])
    end

    it 'should turn [2,2] into C3' do
        expect(Board.rowcol_to_space([2,2])).to eq('C3')
    end
end

