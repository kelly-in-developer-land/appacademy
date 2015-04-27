class MyHashSet

  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] ||= true
  end

  def include?(el)
    @store[el] != nil
  end

  def delete(el)
    val = @store.delete(el)
    (val.nil?) ? false : true
  end

  def union(set_2)
    result = {}
    set_2.each do |k, v|
      result[k] = v
    end
    self.each do |k, v|
      result[k] = v
    end
    result
  end

  def interset(set_2)
    result = {}
    set_2.each do |k, v|
      if self[k]
        result[k] = v
      end
    end
    result
  end

  def minus(set_2_)
    result = {}
    self.each do |k, v|
      if set_2[k]
        next
      else
        result[k] = v
      end
    end
    result
  end

end
