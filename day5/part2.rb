def process(test = false)
  input = test ? test_string : File.read('input.txt')
  array = input.split("\n").collect{|i| i.to_i}
  index = 0
  steps = 0

  while true do
    old_index = index
    index = index + array[index]
    steps += 1
    break if index >= array.length || index < 0
    array[old_index] >= 3 ? array[old_index] -= 1 : array[old_index] += 1
  end
  steps
end

def test_string
  "0\n3\n0\n1\n-3"
end

puts process
