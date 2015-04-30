class Pawn < Pieces

  WHITE = { :move => [-1, 0], :capture => [[-1,-1], [-1, 1]] }
  BLACK = { :move => [1, 0], :capture => [[1, 1], [1, -1]] }

  def symbol
    :P
  end

  def move_dirs
    moveset = WHITE if @color == :white
    moveset = BLACK if @color == :black
    capture_moves(moveset) + movement_moves(moveset)
  end

  private

  def capture_moves(moveset)
    valid_move_set = []
    moveset[:capture].each do |coordinates|
      pos = [@position[0] + coordinates[0], @position[1] + coordinates[1]]
      board_pos = @board[pos]
      if @board.on_board?(pos)
        board_pos = @board[pos]
        valid_move_set << pos unless board_pos.nil? || board_pos.color == @color
      end
    end
    valid_move_set
  end

  def movement_moves(moveset)
    valid_move_set =  []
    pos = [@position[0] + moveset[:move][0], @position[1] + moveset[:move][1]]
    if @board[pos].nil? && @board.on_board?(pos)
      valid_move_set << pos
      unless @moved
        pos = [pos[0] + moveset[:move][0], pos[1] + moveset[:move][1]]
        if @board[pos].nil? && @board.on_board?(pos)
          valid_move_set << pos
        end
      end
    end
    valid_move_set
  end

end
