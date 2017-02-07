require_relative 'color/color_comparator'
require_relative 'node'

class Quadtree
  attr_accessor :nodes

  def initialize(nodes = [])
    @nodes = nodes
  end

  def root
    @nodes.flatten[0]
  end

  def generate(diff_amount)
    while @nodes.size > 1
      level_nodes = generate_level(diff_amount)
      @nodes.clear
      @nodes = level_nodes
    end
  end

  private

  def generate_level(diff_amount)
    nodes = []
    nodesRow = []
    row = 0
    col = 0

    ((@nodes.size * @nodes[0].size) / 4).times do
      quad = quad_nodes(row, col)
      node = merge(quad, all_leaves?(quad) && similar?(quad, diff_amount))
      nodesRow.push(node)
      if col + 2 == @nodes[0].size
        col = 0
        row += 2
        nodes.push(nodesRow.dup)
        nodesRow.clear
      else
        col += 2
      end
    end
    nodes
  end

  def quad_nodes(row, col)
    n1 = @nodes[row][col]
    n2 = @nodes[row][col + 1]
    n3 = @nodes[row + 1][col]
    n4 = @nodes[row + 1][col + 1]
    [n1, n2, n3, n4]
  end

  def all_leaves?(nodes)
    nodes.all?(&:leaf?)
  end

  def similar?(nodes, amount)
    v1 = ColorComparator.ciede2000(nodes[0].lab, nodes[1].lab)
    v2 = ColorComparator.ciede2000(nodes[2].lab, nodes[3].lab)
    v3 = ColorComparator.ciede2000(nodes[0].lab, nodes[2].lab)
    v1 < amount && v2 < amount && v3 < amount
  end

  def merge(nodes, as_leaf)
    rect = { left: nodes[0].rect[:left], top: nodes[0].rect[:top],
             right: nodes[3].rect[:right], bottom: nodes[3].rect[:bottom] }
    Node.new(nodes[0].rgb, rect, nodes[0].lab, as_leaf ? nil : nodes)
  end
end
