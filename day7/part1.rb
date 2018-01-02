def process(test = false)
  input = test ? test_string : File.read('input.txt')
  lines = input.split("\n")

  parent_nodes = []
  child_nodes = []

  lines.each do |string|
    line = string.split(" ")
    next unless line[2]
    parent_nodes << line[0]
    line[3..-1].each do |node|
      node = node.gsub(",", "")
      child_nodes << node
    end
  end

  parent_nodes - child_nodes
end

def test_string
  "pbga (66)\n" +
  "xhth (57)\n" +
  "ebii (61)\n" +
  "havc (66)\n" +
  "ktlj (57)\n" +
  "fwft (72) -> ktlj, cntj, xhth\n" +
  "qoyq (66)\n" +
  "padx (45) -> pbga, havc, qoyq\n" +
  "tknk (41) -> ugml, padx, fwft\n" + 
  "jptl (61)\n" + 
  "ugml (68) -> gyxo, ebii, jptl\n" + 
  "gyxo (61)\n" + 
  "cntj (57)"
end

puts process