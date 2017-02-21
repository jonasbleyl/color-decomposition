require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/quadtree/node'
require 'test/unit'
require 'pp'

class TestColorComparator < Test::Unit::TestCase
  def test_quadtree_rect
    quadtree = Quadtree.new(2, 2)
    assert_equal({ left: 0, top: 0, right: 2, bottom: 2 }, quadtree.root.rect)

    nodes = quadtree.base_nodes
    assert_equal({ left: 0, top: 0, right: 1, bottom: 1 }, nodes[0].rect)
    assert_equal({ left: 1, top: 0, right: 2, bottom: 1 }, nodes[1].rect)
    assert_equal({ left: 0, top: 1, right: 1, bottom: 2 }, nodes[2].rect)
    assert_equal({ left: 1, top: 1, right: 2, bottom: 2 }, nodes[3].rect)
  end

  def test_quadtree_base_nodes
    quadtree = Quadtree.new(6, 6)
    assert_equal(16, quadtree.base_nodes.size)

    quadtree = Quadtree.new(15, 15)
    assert_equal(64, quadtree.base_nodes.size)

    quadtree = Quadtree.new(250, 150)
    assert_equal(16_384, quadtree.base_nodes.size)
  end
end
