# distance in spiral algorithm part 1
input = 277678

def process(input)
  return 0 if input == 1

  # Find closest greater special corner (aka lower right corner of square)
  closest_special_corner = 1
  while closest_special_corner < input do
    closest_special_corner = (closest_special_corner ** 0.5 + 2) ** 2
  end

  diff = closest_special_corner - input
  sqroot = closest_special_corner ** 0.5
  offset = diff % (sqroot - 1)

  return offset if offset > sqroot / 2
  sqroot - (offset + 1)
end

puts process(input)
