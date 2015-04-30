require_relative 'piece_requires'

class Player
  attr_reader :color

  COLUMNS = {
    :a => 0,
    :b => 1,
    :c => 2,
    :d => 3,
    :e => 4,
    :f => 5,
    :g => 6,
    :h => 7
  }

  def initialize(color)
    @color = color
  end

  def take_turn(pieces)
    start_pos, end_pos = nil, nil
    piece = nil
    puts "#{@color.capitalize}'s turn!"
    until piece
      puts "In what position is the piece that you want to move?".blue
      puts "Enter the letter and the number.".blue
      print "> ".blue
      input = gets.chomp
      return "save" if input.downcase == "save" || input.downcase == "s"
      return "quit" if input.downcase == "quit" || input.downcase == "q"
      start_pos = convert(input)
      piece = pieces.find { |piece| piece.position == start_pos }
      puts "Invalid piece.".red if piece.nil?
    end
    valid_move = false
    until valid_move
      puts "Where do you want to move it to?".blue
      puts "Enter the letter and the number.".blue
      print "> ".blue
      input = gets.chomp
      return "save" if input.downcase == "save" || input.downcase == "s"
      return "quit" if input.downcase == "quit" || input.downcase == "q"
      end_pos = convert(input)
      valid_move = piece.valid_moves.include?(end_pos)
      puts "Invalid move." unless valid_move
    end
    [start_pos, end_pos]
  end

  def convert(position)
    column_letter, row_number = position.split(/[,\s]*/)
    pos = [8-row_number.to_i, COLUMNS[column_letter.to_sym]]
  end

end
