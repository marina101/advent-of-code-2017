class Node
  attr_accessor :name, :weight, :children, :parent, :child_names

  def initialize(name, weight, child_names)
    @name = name
    @weight = weight
    @child_names = child_names
    @children = []
  end

  # returns a hash of the total weights of each child's sumtree
  def children_sumtrees
    children.each_with_object({}) do |child, sum|
      sum[child.name] = child.total_weight
    end
  end

  def total_weight
    return weight if children.empty?

    children.map(&:total_weight).inject(:+) + weight
  end

  def children_balanced?
    children_sumtrees.values.uniq.length == 1
  end
end

def process(test = false)
  input = test ? test_string : File.read('input.txt')
  lines = input.split("\n")

  tree = build_tree(lines)
  root = find_root(tree)
  puts "root is #{root.name}"

  node = root

  while true do 
    child_sumtrees = node.children_sumtrees

    # find the sumtree weight that occurs only once
    imbalanced_weight = child_sumtrees.values.uniq
      .find { |v| child_sumtrees.values.count(v) == 1 }

    # figure out which node that weight belongs to
    imbalanced_node_name, _ = child_sumtrees.find do |name, weight|
      weight == imbalanced_weight
    end

    imbalanced_node = tree[imbalanced_node_name]

    # check if imbalance is at current level or deeper
    if imbalanced_node.children_balanced?
      diff = child_sumtrees.values.uniq.inject(:-).abs
      puts imbalanced_node.weight - diff
      break
    else
      # keep going down the tree in the direction of imbalance
      node = imbalanced_node
    end
  end
  
end

def build_tree(lines)
  tree = {}
  lines.each do |string|
    line = string.split(" ")
    child_names = []
    if line[2]
      line[3..-1].each do |word|
        child_names << word.gsub(",", "")
      end
    end
    tree[line[0]] = Node.new(line[0], line[1].gsub('(','').gsub(')','').to_i, child_names)
  end

  # Set the parent name for each node that has one
  tree.each do |node_name, node|
    next unless node.child_names
    node.child_names.each do |child_name|
      tree[child_name].parent = node
      node.children << tree[child_name]
    end
  end
  tree
end

def find_root(tree)
  root = nil
  tree.each do |node_name, node|
    next if node.parent
    root = node
  end
  root
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

process