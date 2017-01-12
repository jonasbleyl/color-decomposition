require_relative 'colour_converter'
require_relative 'colour_comparator'
require 'rmagick'

include Magick

# pixels = []
# img = ImageList.new("mushroom.png")
# scanline = img.export_pixels(0, 0, img.columns, 1, "RGB");
#
# scanline.each_slice(3) do |pixel|
#   rgb = { r: (pixel[0]/65535)*255, g: (pixel[1]/65535)*255, b: (pixel[2]/65535)*255 }
#   pixels.push(rgb)
# end
#
# p pixels

lab1 = ColourConverter.rgb_to_lab({ r: 120, g: 17, b: 17 })
lab2 = ColourConverter.rgb_to_lab({ r: 189, g: 40, b: 40 })

value = ColourComparator.ciede2000(lab1, lab2)
p "CIEDE2000: #{value}"
