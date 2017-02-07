require_relative 'color/color_comparator'
require_relative 'node'

class Quadtree
  attr_reader :nodes

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
    squares = (@nodes.size * @nodes[0].size) / 4
    tempNodes = []
    tempRow = []
    row = 0
    col = 0

    squares.times do
      n1 = @nodes[row][col]
      n2 = @nodes[row][col + 1]
      n3 = @nodes[row + 1][col]
      n4 = @nodes[row + 1][col + 1]
      if n1.is_leaf? && n2.is_leaf? && n3.is_leaf? && n4.is_leaf?
        node = merge([n1, n2, n3, n4], similar?(n1, n2, n3, n4, diff_amount))
        tempRow.push(node)
      else
        node = merge([n1, n2, n3, n4], false)
        tempRow.push(node)
      end

      if col + 2 == @nodes[0].size
        col = 0
        row += 2
        tempNodes.push(tempRow.dup)
        tempRow.clear
      else
        col += 2
      end
    end
    tempNodes
  end

  def similar?(n1, n2, n3, n4, amount)
    v1 = ColorComparator.ciede2000(n1.lab, n2.lab)
    v2 = ColorComparator.ciede2000(n3.lab, n4.lab)
    v3 = ColorComparator.ciede2000(n1.lab, n3.lab)
    v1 < amount && v2 < amount && v3 < amount
  end

  def merge(nodes, as_leaf)
    rect = { left: nodes[0].rect[:left], top: nodes[0].rect[:top],
             right: nodes[3].rect[:right], bottom: nodes[3].rect[:bottom] }
    if as_leaf
      Node.new(nodes[0].rgb, rect, nodes[0].lab)
    else
      Node.new(nodes[0].rgb, rect, nodes[0].lab, nodes)
    end
  end
end
