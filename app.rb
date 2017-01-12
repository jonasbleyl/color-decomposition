require_relative 'colour_converter'
require_relative 'colour_comparator'
require_relative 'diff'
require 'rmagick'

include Magick

pixels = []
img = ImageList.new("mushroom.png")
scanline = img.export_pixels(0, 0, img.columns, 1, "RGB");

scanline.each_slice(3) do |pixel|
  rgb = { red: (pixel[0]/65535)*255, green: (pixel[1]/65535)*255, blue: (pixel[2]/65535)*255 }
  pixels.push(rgb)
end

p pixels
