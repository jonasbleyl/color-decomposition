require 'color_decomposition'
require 'rmagick'
require 'test/unit'
require 'pp'

class TestColorDecomposition < Test::Unit::TestCase
  include Magick

  def test_simple_quadtree_from_image
    image_path = "#{__dir__}/data/images/image-tiny.png"
    quadtree = ColorDecomposition.quadtree(image_path, 1)
    image = Image.new(quadtree.rect[:bottom], quadtree.rect[:right])

    quadtree.child_nodes.each do |node|
      gc = Magick::Draw.new
      gc.fill = node.rgb_hex
      gc.rectangle(node.rect[:left], node.rect[:top],
                   node.rect[:right], node.rect[:bottom])
      gc.draw(image)
    end
    image.write 'result-image-tiny.jpg'
  end
end
