class Array

  def my_uniq
    result = []

      self.each do |e|
        if result.include?(e)
          next
        else
          result << e
        end
      end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |num, i|
      count = 1
      while i+count < self.length
        if self[i] + self[i+count] == 0
          result << [i, i+count]
        end
        count +=1
      end
    end
    result.sort
  end

  def my_transpose
    result = Array.new(self.count) { [] }

    self.each_with_index do |e, i|

      e.each_with_index do |n, l|
        result[l][i] = n
      end
   end
    result
  end

  def profit_pair
    most_profitable_amount = 0
    most_profitable_pair = []
    i = 0
    while i < self.length
      j = 1
      while i + j < self.length
        if self[j] - self[i] > most_profitable_amount
          most_profitable_amount = self[j] - self[i]
          most_profitable_pair = [i,j]
        end
        j += 1
      end
      i += 1
    end
    most_profitable_pair
  end

end

#Hanoi

default_board = [[1,2,3,4,5],[],[]]

board = [[1,2,3,4,5],[],[]]
# board[rod][index] = disc

puts "Welcome to the Towers of Hanoi! Your objective is to move all of the discs to the third rod, in ascending order."

until board[-1].sort == default_board[0]
  puts "On what rod is this disc you want to move?"
  rod = gets.to_i - 1
  puts "What disc to you want to move?"
    temp_disc = gets.to_i
    until board[rod].index(temp_disc) == 0
      puts "Error, can't move that disc. Please select another disc."
      temp_disc = gets.to_i
    end
    disc = temp_disc
    board[rod].delete(disc)
  puts "What rod do you want to move disc number #{disc} to?"
    temp_rod = gets.to_i - 1
    until board[temp_rod][-1] == nil || board[temp_rod][0] > disc
      puts "Error, can't move that disc to that rod. Please select another rod."
      temp_rod = gets.to_i
    end
    rod = temp_rod
  board[rod] = [disc] + board[rod]
  p board
end

puts "You did it!"
p board
