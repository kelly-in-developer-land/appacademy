class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def take_turn
    start_pos, end_pos = nil, nil
    until start_pos.is_valid?
      puts "In what position is the piece you want to move?"
      puts "Enter the letter and the number."
      print "> "
      start_pos = gets.chomp
    end
    until end_pos.is_valid?
      puts "Where do you want to move it to?"
      puts "Enter the letter and the number."
      print "> "
      end_pos = gets.chomp
    end
    
  end

  def is_valid?

  end

end
