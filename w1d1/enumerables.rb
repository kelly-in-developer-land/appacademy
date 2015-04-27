class Array

  def doubler
    self.map { |n| n*2 }
  end

  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self
  end

  def median
    sorted = self.sort
    length = sorted.length
    if length % 2 == 0
      left = sorted[length/2 - 1]
      right = sorted[length/2]
      median = (left.to_f+right.to_f)/2.0
    else
      median = sorted[length/2] # [0,1,2,3,4,5,6]
    end
  end


  def injector
    self.inject{|memo, i| memo + i }
  end
end
