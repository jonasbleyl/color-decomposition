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
    "##{rgb[:r].to_s(16)}#{rgb[:g].to_s(16)}#{rgb[:b].to_s(16)}"
  end
end
