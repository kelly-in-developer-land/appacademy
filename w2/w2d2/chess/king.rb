class King < SteppingPieces

  MOVES = [
    [0, 1],
    [1, 0],
    [0, -1],
    [-1 ,0],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]

  def symbol
    :K
  end

  def move_dirs
    moves(MOVES)
  end

end
