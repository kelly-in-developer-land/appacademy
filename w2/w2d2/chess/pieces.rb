class Pieces
  attr_reader  :board, :color
  attr_accessor :moved, :position

  def initialize(pos, board, color, moved=false)
    @position = pos
    @board = board
    @moved = moved
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
      unless temp_board.in_check?(@color)
        valid_moves << move
      end
    end
    valid_moves
  end

  def symbol
    raise "Undefined."
  end

  def piece_dup(duped_board)
    self.class.new(@position.dup, duped_board, @color, @moved)
  end
end
