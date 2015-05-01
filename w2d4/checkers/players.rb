require_relative 'board'

class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def take_turn
    start_pos = [nil, nil]
    end_pos = [nil, nil]
    puts "Enter the row and column of the piece you want to move, separated by a space."
    start_pos[0], start_pos[1] = gets.chomp.split(/[,\s]*/).map { |el| el.to_i }
    puts "Enter move you want to make with that piece."
    end_pos[0], end_pos[1] = gets.chomp.split(/[,\s]*/).map { |el| el.to_i }

    [start_pos, end_pos]
    # now make it a sequence...
    # make a quit option, and a save option
    # use getch...
  end

end
