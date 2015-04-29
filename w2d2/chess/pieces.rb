class Pieces
  attr_reader :position, :board, :color
  attr_accessor :moved

  def initialize(pos, board, color)
    @position = pos
    @board = board
    @moved = false
    @color = color
  end

  def moves
    raise "Undefined."
  end

  def move_dirs
    raise "Undefined."
  end

  def valid_moves
    valid_moves = []
    possible_moves = self.move_dirs
    possible_moves.each do |move|
      temp_board = @board.board_dup
      temp_board.update(@position, move)
      valid_moves << move unless temp_board.in_check?(@color)
    end
    valid_moves
  end

  def symbol
    raise NotImplementedError.new
  end

end
