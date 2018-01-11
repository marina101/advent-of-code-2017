class Registers
  attr_accessor :registers

  def initialize(test = false)
    input = test ? test_string : File.read('input.txt')
    lines = input.split("\n")

    @registers = {}
    names = []

     # initialize all @registers and set them to 0, save ops list
    lines.each do |string|
      line = string.split(" ")
      @registers[line[0]] = 0
      names << line[0]
    end

    max = 0
    lines.each do |string|
      line = string.split(" ")
      name = line[0]
      expression = [line[4], line[5], line[6]]
      operation = line[1]
      op_value = line[2].to_i
      if evaluate_expression(expression)
        case operation
        when 'inc'
          @registers[name] += op_value
          max = @registers[name] if @registers[name] > max
        when 'dec'
          @registers[name] -= op_value
          max = @registers[name] if @registers[name] > max
        end
      end
    end

    puts "The maximum value at the end is #{@registers.values.max}"
    puts "The maximum value to ever occur is #{max}"
  end

  def evaluate_expression(exp)
    first = @registers[exp[0]]
    second = exp[2].to_i
    case exp[1]
    when '=='
      first == second
    when '!='
      first != second
    when '>='
      first >= second
    when '>'
      first > second
    when '<='
      first <= second
    when '<'
      first < second
    end
  end

  def test_string
    "b inc 5 if a > 1\na inc 1 if b < 5\nc dec -10 if a >= 1\nc inc -20 if c == 10"
  end
end

Registers.new
