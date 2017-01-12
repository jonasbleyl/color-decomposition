module ColourComparator
  def self.ciede2000(lab1, lab2)
    c1_star = Math.sqrt(lab1[:a]**2 + lab1[:b]**2)
    c2_star = Math.sqrt(lab2[:a]**2 + lab2[:b]**2)
    c_bar_star = (c1_star + c2_star) / 2

    g = 0.5 * (1 - Math.sqrt(c_bar_star**7 / (c_bar_star**7 + 25**7)))
    a1_prime = (1 + g) * lab1[:a]
    a2_prime = (1 + g) * lab2[:a]
    c1 = Math.sqrt(a1_prime**2 + lab1[:b]**2)
    c2 = Math.sqrt(a2_prime**2 + lab2[:b]**2)

    h1 = if lab1[:b] == 0 && a1_prime == 0
           0
         else
           Math.atan2(lab1[:b], a1_prime) * 180 / Math::PI
         end

    h2 = if lab2[:b] == 0 && a2_prime == 0
           0
         else
           Math.atan2(lab2[:b], a2_prime) * 180 / Math::PI
         end

    l_delta = lab2[:l] - lab1[:l]
    c_delta = c2 - c1

    h = if c1 * c2 == 0
          0
        elsif (h2 - h1).abs <= 180
          h2 - h1
        elsif (h2 - h1) > 180
          (h2 - h1) - 360
        else
          (h2 - h1) + 360
        end
    h_delta = 2 * Math.sqrt(c1 * c2) * Math.sin(radians(h) / 2)

    l_bar = (lab1[:l] + lab2[:l]) / 2
    c_bar = (c1 + c2) / 2

    h_bar = if (c1 * c2) == 0
              h1 + h2
            elsif (h1 - h2).abs <= 180
              (h1 + h2) / 2
            elsif (h1 - h2).abs > 180 && (h1 + h2) < 360
              (h1 + h2 + 360) / 2
            else
              (h1 + h2 - 360) / 2
            end

    t = 1 - 0.17 * Math.cos(radians(h_bar - 30)) +
        0.24 * Math.cos(radians(2 * h_bar)) +
        0.32 * Math.cos(radians(3 * h_bar + 6)) -
        0.20 * Math.cos(radians(4 * h_bar - 63))

    delta_o = 30 * Math.exp(-((h_bar - 275) / 25)**2)
    rc = 2 * Math.sqrt(c_bar**7 / (c_bar**7 + 25**7))
    sl = 1 + 0.015 * (l_bar - 50)**2 / Math.sqrt(20 + (l_bar - 50)**2)
    sc = 1 + 0.045 * c_bar
    sh = 1 + 0.015 * c_bar * t
    rt = -Math.sin(radians(2 * delta_o)) * rc

    Math.sqrt((l_delta / sl)**2 + (c_delta / sc)**2 + (h_delta / sh)**2 +
              rt * (c_delta / sc) * (h_delta / sh)).clamp(0, 100)
  end

  private

  def self.radians(num)
    num * Math::PI / 180
  end
end
