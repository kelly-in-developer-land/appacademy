class Queen < SlidingPieces

  def symbol
    :Q
  end

  def move_dirs
    moves(ORTHOGONAL + DIAGONAL)
  end

end
