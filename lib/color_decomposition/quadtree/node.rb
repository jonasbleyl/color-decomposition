require 'color_decomposition/color/color_converter'
require 'color_decomposition/color/color_comparator'

class Node
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

  def split
    centerX = (rect[:left] + rect[:right]) * 0.5
    centerY = (rect[:top] + rect[:bottom]) * 0.5
    @child_nodes = [
      new_child_node(rect[:left], rect[:top], centerX, centerY),
      new_child_node(centerX, rect[:top], rect[:right], centerY),
      new_child_node(rect[:left], centerY, centerX, rect[:bottom]),
      new_child_node(centerX, centerY, rect[:right], rect[:bottom])
    ]
  end

  def merge
    @rgb = @child_nodes[0].rgb
    @lab = @child_nodes[0].lab
    @child_nodes = nil
  end

  def similar?(amount)
    v1 = ColorComparator.ciede2000(@child_nodes[0].lab, @child_nodes[1].lab)
    v2 = ColorComparator.ciede2000(@child_nodes[2].lab, @child_nodes[3].lab)
    v3 = ColorComparator.ciede2000(@child_nodes[0].lab, @child_nodes[2].lab)
    v1 < amount && v2 < amount && v3 < amount
  end

  def lab
    @lab ||= ColorConverter.rgb_to_lab(@rgb)
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
    sprintf('%02X', num)
  end
end
