require 'rmagick'

module ColorDecomposition
  class Image
    include Magick
    attr_reader :height, :width

    def initialize(path)
      @image = ImageList.new(path)
      @height = @image.rows
      @width = @image.columns
    end

    def add_image_data(quadtree)
      quadtree.base_nodes.each do |node|
        pixels = export_pixel_data(node)
        node.rgb = {
          r: ((pixels[0] / 65_535.0) * 255).to_i,
          g: ((pixels[1] / 65_535.0) * 255).to_i,
          b: ((pixels[2] / 65_535.0) * 255).to_i
        }
      end
    end

    private

    def export_pixel_data(node)
      @image.export_pixels(
        node.rect[:left], node.rect[:top],
        node.rect[:bottom] - node.rect[:top],
        node.rect[:right] - node.rect[:left], 'RGB'
      )
    end
  end
end
