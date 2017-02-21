require 'color_decomposition/version'
require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/image/image_reader'

module ColorDecomposition
  def self.quadtree(path, similarity)
    image = ImageReader.new(path)
    quadtree = Quadtree.new(image.height, image.width)
    image.add_image_data(quadtree)
    quadtree.generate_similarity_tree(similarity)
    quadtree.root
  end
end
