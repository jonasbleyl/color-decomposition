require_relative 'lib/color/color_converter'
require_relative 'lib/color/color_comparator'
require_relative 'lib/quadtree/quadtree'
require_relative 'lib/quadtree/node'
require 'rmagick'
require 'pp'

include Magick

quadtree = Quadtree.new
img = ImageList.new('tiny-c.png')

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
p quadtree.root

file = File.open('quadtree.txt', 'w')
file.write(quadtree.nodes.pretty_inspect)
