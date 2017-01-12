require_relative 'colour_converter'
require_relative 'colour_comparator'
require_relative 'diff'
require 'rmagick'

include Magick

# pixels = []
# img = ImageList.new("mushroom.png")
# scanline = img.export_pixels(0, 0, img.columns, 1, "RGB");
#
# scanline.each_slice(3) do |pixel|
#   rgb = { red: (pixel[0]/65535)*255, green: (pixel[1]/65535)*255, blue: (pixel[2]/65535)*255 }
#   pixels.push(rgb)
# end
#
# p pixels

# x, y, z = ColourConverter.rgb_to_xyz(120, 17, 17)
# p "XYZ: #{x} #{y} #{z}"
#
# l, a, b = ColourConverter.xyz_to_lab(x, y, z)
# p "LAB: #{l} #{a} #{b}"
#
# l, c, h = ColourConverter.lab_to_lch(l, a, b)
# p "LCH: #{l} #{c} #{h}"

l1, a1, b1 = ColourConverter.rgb_to_lab(120, 17, 17)
l2, a2, b2 = ColourConverter.rgb_to_lab(189, 40, 40)

value = ColourComparator.ciede2000(l1, a1, b1, l2, a2, b2)
p "CIEDE2000: #{value}"
