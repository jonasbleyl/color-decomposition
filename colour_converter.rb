require 'matrix'

module ColourConverter
  def self.rgb_to_xyz(rgb)
    r = xyz_channel(rgb[:r] / 255.0)
    g = xyz_channel(rgb[:g] / 255.0)
    b = xyz_channel(rgb[:b] / 255.0)

    # sRGB D65 illuminant and 2° observer values
    s = Matrix[[0.4124, 0.3576, 0.1805],
               [0.2126, 0.7152, 0.0722],
               [0.0193, 0.1192, 0.9505]]

    xyz = (s * Matrix[[r], [g], [b]]) * 100
    { x: xyz[0, 0], y: xyz[1, 0], z: xyz[2, 0] }
  end

  def self.xyz_to_lab(xyz)
    # CIEXYZ white point values (D65)
    x = f(xyz[:x] / 95.047)
    y = f(xyz[:y] / 100.000)
    z = f(xyz[:z] / 108.883)

    l = (116 * y - 16)
    a = 500 * (x - y)
    b = 200 * (y - z)
    { l: l.clamp(0, 100), a: a, b: b }
  end

  def self.rgb_to_lab(rgb)
    xyz = rgb_to_xyz(rgb)
    xyz_to_lab(xyz)
  end

  private

  def self.xyz_channel(colour)
    if colour > 0.04045
      ((colour + 0.055) / 1.055)**2.4
    else
      colour / 12.92
    end
  end

  def self.f(t)
    if t > 0.008856
      t**(1.0 / 3)
    elsif t <= 0.008856
      7.787 * t + 16 / 116.0
    end
  end
end
