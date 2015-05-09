class SteppingPieces < Pieces

  def moves(directions)
    valid_moves_array = []
    directions.each do |coordinates|
      pos = [@position[0] + coordinates[0], @position[1] + coordinates[1]]
      if @board.on_board?(pos)
        board_pos = @board[pos]
        valid_moves_array << pos unless !board_pos.nil? && board_pos.color == @color
      end
    end
    valid_moves_array
  end

end
