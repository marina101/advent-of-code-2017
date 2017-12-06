def process(test = false)
  input = test ? test_string : real_string
  input_array = input.split(" ").collect{|i| i.to_i}
  redistribute_blocks(input_array)
end

def test_string
  "0 2 7 0"
end

def real_string
  "14 0 15 12 11 11 3 5 1 6 8 4 9 1 8 4"
end

def redistribute_blocks(current_array)
  steps = 0
  patterns = []
  loop do
    patterns << current_array.to_s
    blocks = current_array.max
    index = current_array.index(blocks)
    current_array[index] = 0

    until blocks == 0 do
      index = (index + 1) % current_array.length
      current_array[index] += 1
      blocks -= 1
    end

    steps += 1
    break if patterns.include?(current_array.to_s)
  end
  steps
end

puts process
