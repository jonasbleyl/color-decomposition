require 'color_decomposition/quadtree/node'
require 'rmagick'

class ImageReader
  include Magick

  def initialize(path)
    @image = ImageList.new(path)
  end

  def base_image_nodes
    @nodes ||= create_pixel_nodes
  end

  private

  def create_pixel_nodes
    nodes = []
    @image.rows.times do |i|
      scanline = @image.export_pixels(0, i, @image.columns, 1, 'RGB')
      row = []
      scanline.each_slice(3).with_index do |pixel, j|
        rgb = { r: (pixel[0] / 65_535.0) * 255,
                g: (pixel[1] / 65_535.0) * 255,
                b: (pixel[2] / 65_535.0) * 255 }
        row.push(Node.new(rgb, left: i, top: j, right: i + 1, bottom: j + 1))
      end
      nodes.push(row)
    end
    nodes
  end
end
