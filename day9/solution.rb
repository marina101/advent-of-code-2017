def process(test = false)
  input = test ? test_string : File.read('input.txt')
  chars = input.split('')

  stack = []
  garbage_stack = []
  groups = []

  garbage = false
  cancelled = false
  random_chars = 0

  chars.each_with_index do |char, i|
    if char == '!' && garbage && !cancelled
      cancelled = true
    elsif cancelled && garbage
      cancelled = false
    elsif char == '{' && !garbage
      stack << char
    elsif char == '}' && stack.last == '{' && !garbage
      #this gets number of groups with their depth
      groups << stack.length
      #groups << 1 #just to get the number of groups
      stack.pop
    elsif char == '<' && !garbage
      garbage_stack << char
      garbage = true
    elsif char == '>' && garbage_stack.last == '<'
      garbage_stack.pop
      garbage = false
    elsif garbage
      random_chars += 1
    end
  end

  puts groups.inject(:+)
  puts "Part 2: number of non-cancelled characters inside garbage: #{random_chars}"
end



def test_string
  "{{<a!>},{<a!>},{<a!>},{<ab>}}"
end

process