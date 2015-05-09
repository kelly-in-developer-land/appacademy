def range(start, finish)
  if finish < start
    []
  elsif start == finish
    [finish]
  else
    ([] << start) + range(start + 1, finish)
  end
end

def array_sum_recursive(array)
  if array.length == 1
    array[0]
  elsif array.length < 1
    0
  else
    array.pop + array_sum_recursive(array)
  end
end

def array_sum_iterative(array)
  sum = 0
  array.each { |el| sum += el }
  sum
end

def exp1(base, exponent)
  if exponent == 0
    1
  else
    base * exp1(base, exponent - 1)
  end
end

def exp2(base, exponent)
  if exponent == 0
    1
  elsif exponent == 1
    base
  elsif exponent % 2 == 0
    exp2(base, exponent / 2) * exp2(base, exponent / 2)
  else
    base * (exp2(base, (exponent -1) / 2) * exp2(base, (exponent -1) / 2))
  end
end

class Array
  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el.dup }
  end
end

def fib_iter(n)
  fibs = []
  if n == 0
    fibs
  else
    n.times do
      if fibs.empty?
        fibs << 1
      elsif fibs == [1]
        fibs << 1
      else
        fibs << fibs[-1] + fibs[-2]
      end
    end
  end
  fibs
end

def fib_recursive(n)
  if n == 0
    [0]
  elsif n == 1
    [1]
  else
    fib_recursive(n - 1) + [(fib_recursive(n - 1).last + fib_recursive(n - 2).last)]
  end
end

def bsearch(array, target)
  return nil if array.length == 1 && target != array[0]
  middle = array.length/2
  if array[middle] == target
    middle
  elsif array[middle] < target
    sub_bsearch_right = bsearch(array[middle+1..-1], target)
    sub_bsearch_right.nil? ? nil : middle + sub_bsearch_right
  elsif array[middle] > target
    sub_bsearch_left = bsearch(array[0..middle-1], target)
    sub_bsearch_left.nil? ? nil : middle - sub_bsearch_left
  end
end

def make_change_1(amt, coins)
  coins.sort!
  if amt == 0
    []
  else
    coin_bag = []
    if coins.last <= amt
      current_coin = coins.pop
      num_coins = amt / current_coin
      coin_bag += Array.new(num_coins) { current_coin }
      coin_bag += make_change(amt % current_coin, coins)
    else
      coins.pop
      make_change(amt, coins)
    end
  end
end

def make_change_2(amt, coins)
  coins.sort!
  if amt == 0
    []
  else
    coin_bag = []
    if coins.last <= amt
      coin_bag += Array.new(1) { coins.last }
      coin_bag += make_change(amt - coins.last, coins)
    else
      coins.pop
      make_change(amt, coins)
    end
  end
end

def make_change(amt, coins)
  coins.sort!.reverse!
  if amt == 0
    []
  elsif coins.first > amt
    nil
  else
    best_change = []
    coins.each do |coin|
      remainder = make_change(amt - coin, coins)
      if remainder
        change = [coin] + remainder
        if best_change.empty? || best_change.length > change.length
          best_change = change
        end
      else
        change = nil
      end
    end
    best_change
  end

  # change
end


def subsets(set)

  return [[]] if set.empty?

  smaller_subsets = subsets(set[0..-2])
  bigger_subsets = []
  smaller_subsets.each { |sub| bigger_subsets << sub =+ set.last }

  smaller_subsets + bigger_subsets

end

def merge(arr1, arr2)
  result = []
  until arr1.empty? && arr2.empty?
    if arr2.empty?
      result << arr1[0]
      arr1.delete_at(0)
    elsif arr1.empty?
      result << arr2[0]
      arr2.delete_at(0)
    elsif arr1[0] <= arr2[0]
      result << arr1[0]
      arr1.delete_at(0)
    elsif arr2[0] <= arr1[0]
      result << arr2[0]
      arr2.delete_at(0)
    end
  end
  result
end

def merge_sort(array)
  if array.length <= 1
    array
  else
    left = array[0...array.length/2]
    right = array[array.length/2..-1]
    merge(merge_sort(left), merge_sort(right))
  end
end
