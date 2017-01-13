require 'color_comparator'
require 'test/unit'
require 'csv'

class TestColorComparator < Test::Unit::TestCase
  def setup
    @sample_data = []
    CSV.foreach('test/data/sample.csv') do |row|
      lab1 = { l: row[0].to_f, a: row[1].to_f, b: row[2].to_f }
      lab2 = { l: row[3].to_f, a: row[4].to_f, b: row[5].to_f }
      @sample_data.push(lab1: lab1, lab2: lab2, ciede2000: row[6].to_f)
    end
  end

  def test_ciede2000
    @sample_data.each do |data|
      value = ColorComparator.ciede2000(data[:lab1], data[:lab2])
      assert_equal(data[:ciede2000], value.round(4))
    end
  end
end
