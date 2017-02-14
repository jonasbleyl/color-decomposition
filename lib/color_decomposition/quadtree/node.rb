require 'color_decomposition/color/color_converter'

class Node
  attr_reader :rgb, :rect, :child_nodes

  def initialize(rgb, rect, lab = nil, child_nodes = nil)
    @rgb = rgb
    @rect = rect
    @lab = lab
    @child_nodes = child_nodes
  end

  def leaf?
    @child_nodes.nil?
  end

  def lab
    @lab ||= ColorConverter.rgb_to_lab(rgb)
  end

  def rgb_hex
    "##{hex(rgb[:r])}#{hex(rgb[:g])}#{hex(rgb[:b])}"
  end

  private

  def hex(num)
    sprintf("%02X", num)
  end
end
