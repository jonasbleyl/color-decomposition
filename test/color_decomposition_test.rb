require 'color_decomposition'
require 'rmagick'
require 'test/unit'

class TestColorDecomposition < Test::Unit::TestCase
  include Magick

  def test_invalid_arguments
    image_path = "#{__dir__}/data/images/test-image-tiny.png"
    assert_raise ArgumentError do
      ColorDecomposition.quadtree(image_path, -1)
    end
    assert_raise ArgumentError do
      ColorDecomposition.quadtree(image_path, 101)
    end
  end

  def test_tiny_image_quadtree
    image_path = "#{__dir__}/data/images/test-image-tiny.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:right], quadtree.rect[:bottom])
    quadtree.child_nodes.each do |node|
      draw_node(node, image)
    end
    original = ImageList.new(image_path).export_pixels_to_str
    assert_equal(original, image.export_pixels_to_str)
  end

  def test_small_image_quadtree
    image_path = "#{__dir__}/data/images/test-image-small.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:right], quadtree.rect[:bottom])
    quadtree.child_nodes.each do |node|
      if node.leaf?
        draw_node(node, image)
      else
        node.child_nodes.each do |inner_node|
          draw_node(inner_node, image) if inner_node.leaf?
        end
      end
    end
    original = ImageList.new(image_path).export_pixels_to_str
    assert_equal(original, image.export_pixels_to_str)
  end

  def test_non_square_image_quadtree
    image_path = "#{__dir__}/data/images/test-image-non-square.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:right], quadtree.rect[:bottom])
    quadtree.child_nodes.each do |node|
      draw_node(node, image)
    end
    original = ImageList.new(image_path).export_pixels_to_str
    assert_equal(original, image.export_pixels_to_str)
  end

  private

  def draw_node(node, image)
    rect = Magick::Draw.new
    rect.fill = node.rgb_hex
    rect.rectangle(node.rect[:left], node.rect[:top],
                   node.rect[:right], node.rect[:bottom])
    rect.draw(image)
  end
end
