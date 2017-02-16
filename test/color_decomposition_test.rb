require 'color_decomposition'
require 'rmagick'
require 'test/unit'

class TestColorDecomposition < Test::Unit::TestCase
  include Magick

  def test_tiny_image_quadtree
    image_path = "#{__dir__}/data/images/image-tiny.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:bottom], quadtree.rect[:right])
    quadtree.child_nodes.each do |node|
      draw_node(node, image)
    end
    image.write 'result-image-tiny.jpg'
  end

  def test_small_image_quadtree
    image_path = "#{__dir__}/data/images/image-small.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:bottom], quadtree.rect[:right])
    quadtree.child_nodes.each do |node|
      draw_node(node, image)
      next if node.child_nodes.nil?
      node.child_nodes.each do |inner_node|
        draw_node(inner_node, image)
      end
    end
    image.write 'result-image-small.jpg'
  end

  def test_non_square_image_quadtree
    image_path = "#{__dir__}/data/images/image-non-square.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:bottom], quadtree.rect[:right])
    quadtree.child_nodes.each do |node|
      draw_node(node, image)
    end
    image.write 'result-image-tiny.jpg'
  end

  private

  def draw_node(node, image)
    rect = Magick::Draw.new
    rect.fill = node.rgb_hex
    rect.rectangle(node.rect[:top], node.rect[:left],
                   node.rect[:bottom], node.rect[:right])
    rect.draw(image)
  end
end