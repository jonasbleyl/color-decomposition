require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/quadtree/node'
require 'test/unit'
require 'pp'

class TestColorComparator < Test::Unit::TestCase
  # def test_four_nodes
  #   rgb = { r: 255, g: 255, b: 255 }
  #   n1 = Node.new({ left: 0, top: 0, right: 1, bottom: 1 }, rgb)
  #   n2 = Node.new({ left: 1, top: 0, right: 2, bottom: 1 }, rgb)
  #   n3 = Node.new({ left: 0, top: 1, right: 1, bottom: 2 }, rgb)
  #   n4 = Node.new({ left: 1, top: 1, right: 2, bottom: 2 }, rgb)
  #   quadtree = Quadtree.new([[n1, n2], [n3, n4]])
  #   quadtree.base_nodes
  #
  #   assert(quadtree.root.leaf?)
  #   assert_equal({ left: 0, top: 0, right: 2, bottom: 2 }, quadtree.root.rect)
  # end

  def test_generate_quadtree_base_nodes
    quadtree = Quadtree.new(6, 6)
    assert_equal(4, quadtree.base_nodes.size)
  end
end
