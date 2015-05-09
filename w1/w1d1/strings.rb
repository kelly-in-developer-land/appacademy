
  def num_to_s(num, base)

    base_16_letters = {"10" => "A", "11" => "B", "12" => "C", "13" => "D", "14" => "E", "15" => "F"}

    exponent = num/base
    count = exponent
    result = ""
    while count >= 0
      quotient = (num / (base ** count)).to_s
      remainder = num % (base ** count)
      if quotient.to_i > 9
        quotient = base_16_letters[quotient.to_s]
      end
      result += quotient
      count -= 1
      num = remainder
    end

    result.sub(/^0*/,"")

end

puts num_to_s(234, 16)
puts num_to_s(234, 2)
puts num_to_s(16, 16)
puts num_to_s(5, 2)


def caesar_cipher(str, offset)
  result = str.chars.map do |char|
    case char.ord
    when (97..122)
      if char.ord + offset > 122
        char = (char.ord + offset - 26).chr
      else
        char = (char.ord + offset).chr
      end
    end
  end
  result.join("")
end

puts caesar_cipher("zany", 2)
