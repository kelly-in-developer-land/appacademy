class Bishop < SlidingPieces
  def symbol
    :B
  end

  def move_dirs
    moves(DIAGONAL)
  end
end
