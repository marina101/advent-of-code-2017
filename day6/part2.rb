module MemoryAllocation
  @current_array

  def self.process(test = false)
    input = test ? test_string : real_string
    @current_array = input.split(" ").collect{|i| i.to_i}
    reallocate_memory
  end

  def self.reallocate_memory
    steps = 0
    loop_tracker = { @current_array.to_s => 0 }
    while true do
      loop_tracker.merge!(@current_array.to_s => steps)
      blocks = @current_array.max
      index = @current_array.index(blocks)
      @current_array[index] = 0

      redistribute_blocks(blocks, index)

      steps += 1
      break if  loop_tracker.key?(@current_array.to_s)
    end
    steps - loop_tracker[@current_array.to_s]
  end

  def self.redistribute_blocks(blocks, index)
    until blocks == 0 do
        index = (index + 1) % @current_array.length
        @current_array[index] += 1
        blocks -= 1
    end
  end

  def self.test_string
    "0 2 7 0"
  end

  def self.real_string
    "14 0 15 12 11 11 3 5 1 6 8 4 9 1 8 4"
  end
end

puts MemoryAllocation.process
