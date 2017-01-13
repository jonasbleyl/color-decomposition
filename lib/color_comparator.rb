module ColorComparator
  def self.ciede2000(lab1, lab2)
    lch1, lch2 = to_lch(lab1, lab2)

    l_bar = (lch1[:l] + lch2[:l]) / 2
    c_bar = (lch1[:c] + lch2[:c]) / 2
    h_bar = mean_hue(lch1, lch2)

    l_delta = lch2[:l] - lch1[:l]
    c_delta = lch2[:c] - lch1[:c]
    h_delta = hue_angle(lch1, lch2)
    o_delta = 30 * Math.exp(-((h_bar - 275) / 25)**2)

    t = 1 - 0.17 * Math.cos(radians(h_bar - 30)) +
        0.24 * Math.cos(radians(2 * h_bar)) +
        0.32 * Math.cos(radians(3 * h_bar + 6)) -
        0.20 * Math.cos(radians(4 * h_bar - 63))

    rc = 2 * Math.sqrt(c_bar**7 / (c_bar**7 + 25**7))
    sl = 1 + 0.015 * (l_bar - 50)**2 / Math.sqrt(20 + (l_bar - 50)**2)
    sc = 1 + 0.045 * c_bar
    sh = 1 + 0.015 * c_bar * t
    rt = -Math.sin(radians(2 * o_delta)) * rc
    Math.sqrt((l_delta / sl)**2 + (c_delta / sc)**2 + (h_delta / sh)**2 +
              rt * (c_delta / sc) * (h_delta / sh)).clamp(0, 100)
  end

  private

  def self.to_lch(lab1, lab2)
    c1_star = Math.sqrt(lab1[:a]**2 + lab1[:b]**2)
    c2_star = Math.sqrt(lab2[:a]**2 + lab2[:b]**2)
    c_bar_star = (c1_star + c2_star) / 2

    g = 0.5 * (1 - Math.sqrt(c_bar_star**7 / (c_bar_star**7 + 25**7)))
    [{ l: lab1[:l] }.merge(modified_hue(lab1, g)),
     { l: lab2[:l] }.merge(modified_hue(lab2, g))]
  end

  def self.modified_hue(lab, g)
    a = (1 + g) * lab[:a]
    c = Math.sqrt(a**2 + lab[:b]**2)

    h = lab[:b] != 0 || a != 0 ? degrees(Math.atan2(lab[:b], a)) : 0
    h += 360 if h < 0
    { c: c, h: h }
  end

  def self.hue_angle(lch1, lch2)
    h_diff = lch2[:h] - lch1[:h]
    h = if lch1[:c] * lch2[:c] == 0
          0
        elsif h_diff.abs <= 180
          h_diff
        elsif h_diff > 180
          h_diff - 360
        else
          h_diff + 360
        end
    2 * Math.sqrt(lch1[:c] * lch2[:c]) * Math.sin(radians(h) / 2)
  end

  def self.mean_hue(lch1, lch2)
    h_sum = lch1[:h] + lch2[:h]
    if (lch1[:c] * lch2[:c]) == 0
      h_sum
    elsif (lch1[:h] - lch2[:h]).abs <= 180
      h_sum / 2
    elsif (lch1[:h] - lch2[:h]).abs > 180 && h_sum < 360
      (h_sum + 360) / 2
    else
      (h_sum - 360) / 2
    end
  end

  def self.radians(num)
    num * Math::PI / 180
  end

  def self.degrees(num)
    num * 180 / Math::PI
  end
end
