def process(test = false)
  input = test ? test_string : File.read('input.txt')
  sum = 0
  array = input.split("\n")

  array.each do |phrase|
    invalid = false
    words = phrase.split(" ")
    count = Hash.new(0)
    phrase.scan(/\w+/) do |word|
      count[word] += 1
    end
    invalid = count.any? {|k, v| v > 1}
    sum += 1 unless invalid
  end
  sum
end

def test_string
  "aa bb cc dd aaa"
end

puts process