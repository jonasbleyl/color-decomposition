require 'color_decomposition/quadtree/node'

class Quadtree
  attr_reader :root

  def initialize(height, width)
    @root = Node.new(left: 0, top: 0, right: height, bottom: width)
  end

  def base_nodes
    generate_to_base(nodes = [], max_level)
    nodes
  end

  def generate_similarity_tree(similarity)
    level = max_level - 1
    level.times do
      nodes_from_level(nodes = [], level)
      break if nodes.empty?
      nodes.each do |node|
        node.merge if node.similar?(similarity)
      end
      level -= 1
    end
  end

  private

  def nodes_from_level(nodes, desired_level, node = @root, level = 0)
    if level == desired_level
      nodes.push(node)
    else
      unless node.leaf?
        node.child_nodes.each do |inner_node|
          nodes_from_level(nodes, desired_level, inner_node, level + 1)
        end
      end
    end
  end

  def generate_to_base(nodes, desired_level, node = @root, level = 0)
    if level == desired_level
      nodes.push(node)
    else
      node.split if node.leaf?
      node.child_nodes.each do |inner_node|
        generate_to_base(nodes, desired_level, inner_node, level + 1)
      end
    end
  end

  def max_level
    level = 0
    num = [@root.rect[:right] - @root.rect[:left],
           @root.rect[:bottom] - @root.rect[:top]].max
    level += 1 while num / 2**(level + 1) >= 1
    level
  end
end
