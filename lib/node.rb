require_relative 'color/color_converter'

class Node
  attr_accessor :rgb, :lab, :rect, :child_nodes

  def initialize(rgb, rect, lab = nil, child_nodes = nil)
    @rgb = rgb
    @rect = rect
    @lab = lab
    @child_nodes = child_nodes
  end

  def is_leaf?
    @child_nodes.nil?
  end

  def lab
    @lab ||= ColorConverter.rgb_to_lab(rgb)
  end
end
