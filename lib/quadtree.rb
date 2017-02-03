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

  def merge(nodes, as_leaf)
    if as_leaf
      node = Node.new(nodes[0].lab)
    else
      node = Node.new(nodes[0].lab, nodes)
    end
  end

  def generate
    tempNodes = []
    tempRow = []
    while @nodes.size > 1
      squares = ((nodes.size * nodes[0].size) / 4)
      p "#{nodes.size} #{nodes[0].size}"
      row = 0
      col = 0

      squares.times do
        n1 = @nodes[row][col]
        n2 = @nodes[row][col + 1]
        n3 = @nodes[row + 1][col]
        n4 = @nodes[row + 1][col + 1]
        if (n1.is_leaf? && n2.is_leaf? && n3.is_leaf? && n4.is_leaf?)
          v1 = ColorComparator.ciede2000(n1.lab, n2.lab)
          v2 = ColorComparator.ciede2000(n3.lab, n4.lab)
          v3 = ColorComparator.ciede2000(n1.lab, n3.lab)
          node = merge([n1, n2, n3, n4], (v1 < 1 && v2 < 1 && v3 < 1))
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
      @nodes.clear
      @nodes = tempNodes.dup
      p "#{@nodes.size}"
      tempNodes.clear
    end
  end
end
