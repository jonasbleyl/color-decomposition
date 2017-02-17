require 'color_decomposition/version'
require 'color_decomposition/quadtree/quadtree_bottom_up'
require 'color_decomposition/image/image_reader'

module ColorDecomposition
  def self.quadtree(path, similarity)
    image = ImageReader.new(path)
    quadtree = Quadtree::BottomUp.new(image.base_image_nodes)
    quadtree.generate(similarity)
    quadtree.root
  end
end
