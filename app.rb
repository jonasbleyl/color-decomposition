require_relative 'lib/color/color_converter'
require_relative 'lib/color/color_comparator'
require_relative 'lib/quadtree'
require_relative 'lib/node'
require 'rmagick'

include Magick

quadtree = Quadtree.new
img = ImageList.new('tiny.png')

img.rows.times do |i|
  scanline = img.export_pixels(0, i, img.columns, 1, 'RGB')
  row = []
  scanline.each_slice(3).with_index do |pixel, j|
    rgb = { r: (pixel[0] / 65_535.0) * 255,
            g: (pixel[1] / 65_535.0) * 255,
            b: (pixel[2] / 65_535.0) * 255 }
    lab = ColorConverter.rgb_to_lab(rgb)
    row.push(Node.new(lab))
  end
  quadtree.nodes.push(row)
end

quadtree.generate
p quadtree.root

file = File.open('quadtree.txt', 'w')
file.write(quadtree.nodes)
