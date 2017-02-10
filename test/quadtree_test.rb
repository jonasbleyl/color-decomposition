require 'color_decomposition/quadtree/quadtree'
require 'test/unit'

class TestColorComparator < Test::Unit::TestCase
  def test_four_nodes
    rgb = { r: 255, g: 255, b: 255 }
    n1 = Node.new(rgb, left: 0, top: 0, right: 1, bottom: 1)
    n2 = Node.new(rgb, left: 1, top: 0, right: 2, bottom: 1)
    n3 = Node.new(rgb, left: 0, top: 1, right: 1, bottom: 2)
    n4 = Node.new(rgb, left: 1, top: 1, right: 2, bottom: 2)
    quadtree = Quadtree.new([[n1, n2], [n3, n4]])
    quadtree.generate(1)

    assert_nil(quadtree.root.child_nodes)
    assert_equal(quadtree.root.rect, left: 0, top: 0, right: 2, bottom: 2)
  end
end
