require 'color_decomposition/version'
require 'color_decomposition/color/color_converter'
require 'color_decomposition/color/color_comparator'
require 'color_decomposition/quadtree/quadtree'
require 'color_decomposition/quadtree/node'
require 'rmagick'
require 'pp'

module ColorDecomposition
  include Magick

  def self.run
    quadtree = Quadtree.new
    img = ImageList.new('../color-decomposition/tiny-c.png')

    img.rows.times do |i|
      scanline = img.export_pixels(0, i, img.columns, 1, 'RGB')
      row = []
      scanline.each_slice(3).with_index do |pixel, j|
        rgb = { r: (pixel[0] / 65_535.0) * 255,
                g: (pixel[1] / 65_535.0) * 255,
                b: (pixel[2] / 65_535.0) * 255 }
        rect = { left: i, top: j, right: i + 1, bottom: j + 1 }
        row.push(Node.new(rgb, rect))
      end
      quadtree.nodes.push(row)
    end

    quadtree.generate(1)
    pp quadtree.root

    file = File.open('quadtree.txt', 'w')
    file.write(quadtree.nodes.pretty_inspect)
  end
end
