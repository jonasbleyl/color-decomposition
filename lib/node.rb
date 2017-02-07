require_relative 'color/color_converter'

class Node
  attr_reader :rgb, :rect, :child_nodes
  attr_accessor  :lab

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
