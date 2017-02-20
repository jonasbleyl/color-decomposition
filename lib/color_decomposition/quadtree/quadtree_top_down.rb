require 'color_decomposition/quadtree/node'

module Quadtree
  class TopDown
    attr_accessor :node

    def initialize(node)
      @node = node
    end

    def base_nodes
      depth = 0
      num = [@node.rect[:right] - @node.rect[:left],
             @node.rect[:bottom] - @node.rect[:top]].max
      depth += 1 while num / 2**(depth + 1) > 1
      nodes = []
      traverse_to_base(nodes, @node, 0, depth)
      nodes
    end

    private

    def traverse_to_base(nodes, node, depth, desired_depth)
      if depth == desired_depth
        nodes.push(node)
      else
        node.split if node.leaf?
        node.child_nodes.each do |inner_node|
          traverse_to_base(nodes, inner_node, depth + 1, desired_depth)
        end
      end
    end
  end
end
