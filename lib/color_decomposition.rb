require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/image/image_reader'

module ColorDecomposition
  def self.quadtree(path, similarity)
    unless similarity.between?(0, 100)
      raise ArgumentError, 'Similarity value must be between 0 and 100'
    end
    image = ImageReader.new(path)
    quadtree = Quadtree.new(image.height, image.width)
    image.add_image_data(quadtree)
    quadtree.generate_similarity_tree(similarity)
    puts 'Similarity quadtree complete'
    quadtree.root
  end
end
