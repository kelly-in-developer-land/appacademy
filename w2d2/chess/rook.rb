class Rook < SlidingPieces

  def symbol
    :R
  end

  def move_dirs
    moves(ORTHOGONAL)
  end

end
