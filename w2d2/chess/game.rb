class Game
  attr_accessor :board

  def initialize
    @board = Board.new
    populate_black_pieces
    populate_white_pieces
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
  end

  def play
    @board.display
    until @board.in_checkmate?(:white) || @board.in_checkmate?(:black)
      # @player1.take_turn
      @board.update
      @player2.take_turn
      # @board.update
    end

  end

  private

  def populate_black_pieces
    @board.grid[0][0] = Rook.new([0, 0], @board, :black)
    @board.grid[0][1] = Knight.new([0, 1], @board, :black)
    @board.grid[0][2] = Bishop.new([0, 2], @board, :black)
    @board.grid[0][3] = Queen.new([0, 3], @board, :black)
    @board.grid[0][4] = King.new([0, 4], @board, :black)
    @board.grid[0][5] = Bishop.new([0, 5], @board, :black)
    @board.grid[0][6] = Knight.new([0, 6], @board, :black)
    @board.grid[0][7] = Rook.new([0, 7], @board, :black)
    @board.grid[1].each_index do |idx|
      @board.grid[1][idx] = Pawn.new([1, idx], @board, :black)
    end
  end

  def populate_white_pieces
    @board.grid[7][0] = Rook.new([7, 0], @board, :white)
    @board.grid[7][1] = Knight.new([7, 1], @board, :white)
    @board.grid[7][2] = Bishop.new([7, 2], @board, :white)
    @board.grid[7][3] = Queen.new([7, 3], @board, :white)
    @board.grid[7][4] = King.new([7, 4], @board, :white)
    @board.grid[7][5] = Bishop.new([7, 5], @board, :white)
    @board.grid[7][6] = Knight.new([7, 6], @board, :white)
    @board.grid[7][7] = Rook.new([7, 7], @board, :white)
    @board.grid[6].each_index do |idx|
      @board.grid[6][idx] = Pawn.new([6, idx], @board, :white)
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
end
