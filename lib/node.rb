class Node
  attr_accessor :left # top left x
  attr_accessor :top # top left Y
  attr_accessor :right # bottom right x
  attr_accessor :bottom # bottom right y
  attr_accessor :child_nodes
  attr_accessor :lab

  def initialize(lab, child_nodes = nil)
    @lab = lab
    @child_nodes = child_nodes
    # @left = left
    # @top = top
    # @right = right
    # @bottom = bottom
  end

  def is_leaf?
    @child_nodes.nil?
  end
end
