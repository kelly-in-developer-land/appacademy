class Knight < SteppingPieces

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def symbol
    :N
  end

  def move_dirs
    moves(MOVES)
  end

end
