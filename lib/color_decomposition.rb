require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/image'
require 'color_decomposition/version'

module ColorDecomposition
  module_function

  def quadtree(path, similarity)
    unless similarity.between?(0, 100)
      raise ArgumentError, 'Similarity value must be between 0 and 100'
    end
    image = Image.new(path)
    puts 'Generating initial quadtree structure'
    quadtree = Quadtree.new(image.width, image.height)
    image.add_image_data(quadtree)
    puts 'Checking quadtree levels'
    quadtree.generate_similarity_tree(similarity)
    puts 'Quadtree complete'
    quadtree.root
  end
end
