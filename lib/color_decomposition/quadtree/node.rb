require 'color_decomposition/color/color_converter'

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
    centerX = (rect[:top] + rect[:bottom]) * 0.5
    centerY = (rect[:left] + rect[:right]) * 0.5
    @child_nodes = [
      new_child_node(rect[:left], rect[:top], centerX, centerY),
      new_child_node(centerX, rect[:top], rect[:right], centerY),
      new_child_node(rect[:left], centerY, centerX, rect[:bottom]),
      new_child_node(centerX, centerY, rect[:right], rect[:bottom])
    ]
  end

  def lab
    @lab ||= ColorConverter.rgb_to_lab(rgb)
  end

  def rgb_hex
    "##{hex(rgb[:r])}#{hex(rgb[:g])}#{hex(rgb[:b])}"
  end

  private

  def new_child_node(left, top, bottom, right)
    Node.new(left: left.floor, top: top.floor,
             right: right.ceil, bottom: bottom.ceil)
  end

  def hex(num)
    sprintf('%02X', num)
  end
end
