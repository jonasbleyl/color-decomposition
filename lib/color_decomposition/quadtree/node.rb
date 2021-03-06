require 'color_decomposition/color/color'
require 'color_decomposition/color/comparator'

module ColorDecomposition
  class Node
    include Comparator
    attr_accessor :rgb
    attr_reader :rect, :child_nodes

    def initialize(rect, rgb = nil, lab = nil, child_nodes = nil)
      @rect = rect
      @rgb = rgb
      @lab = lab
      @child_nodes = child_nodes
    end

    def leaf?
      @child_nodes.nil?
    end

    def child_leaves?
      @child_nodes.all?(&:leaf?)
    end

    def split
      center_x = (rect[:left] + rect[:right]) * 0.5
      center_y = (rect[:top] + rect[:bottom]) * 0.5
      @child_nodes = [
        new_child_node(rect[:left], rect[:top], center_x, center_y),
        new_child_node(center_x, rect[:top], rect[:right], center_y),
        new_child_node(rect[:left], center_y, center_x, rect[:bottom]),
        new_child_node(center_x, center_y, rect[:right], rect[:bottom])
      ]
    end

    def merge
      @rgb = @child_nodes[0].rgb
      @lab = @child_nodes[0].lab
      @child_nodes = nil
    end

    def similar?(amount)
      v1 = ciede2000(@child_nodes[0].lab, @child_nodes[1].lab)
      v2 = ciede2000(@child_nodes[2].lab, @child_nodes[3].lab)
      v3 = ciede2000(@child_nodes[0].lab, @child_nodes[2].lab)
      v1 < amount && v2 < amount && v3 < amount
    end

    def lab
      @lab ||= Color.new(@rgb).lab
    end

    def rgb_hex
      "##{hex(rgb[:r])}#{hex(rgb[:g])}#{hex(rgb[:b])}"
    end

    private

    def new_child_node(left, top, right, bottom)
      Node.new(left: left.floor, top: top.floor,
               right: right.ceil, bottom: bottom.ceil)
    end

    def hex(num)
      format('%02X', num)
    end
  end
end
