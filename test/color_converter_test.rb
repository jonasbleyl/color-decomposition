require 'color_decomposition/color/color_converter'
require 'test/unit'
require 'csv'

class TestColorConverter < Test::Unit::TestCase
  def setup
    @conversion_data = []
    CSV.foreach('test/data/csv/test-data-conversion.csv', headers: true) do |row|
      rgb = { r: row[0].to_f, g: row[1].to_f, b: row[2].to_f }
      xyz = { x: row[3].to_f, y: row[4].to_f, z: row[5].to_f }
      lab = { l: row[6].to_f, a: row[7].to_f, b: row[8].to_f }
      @conversion_data.push(rgb: rgb, xyz: xyz, lab: lab)
    end
  end

  def test_rgb_to_xyz
    @conversion_data.each do |data|
      xyz = ColorConverter.rgb_to_xyz(data[:rgb])
      xyz.update(xyz) { |_k, v| v.round(3) }
      assert_equal(data[:xyz], xyz)
    end
  end

  def test_xyz_to_lab
    @conversion_data.each do |data|
      lab = ColorConverter.xyz_to_lab(data[:xyz])
      lab.update(lab) { |_k, v| v.round(3) }
      assert_equal(data[:lab], lab)
    end
  end
end
