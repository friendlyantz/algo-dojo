arr = [10, 20, 20, 10, 10, 30, 50, 10, 20]
def sockMerchant(_n, ar)
  # ar.to_h
  # puts ar
  color_hash = {}

  ar.each do |color|
    if color_hash[color].nil?
      color_hash[color] = 1
    elsif color_hash.key?(color)
      # puts color.to_s.insert(" adding")
      color_hash[color] += 1
    else
      puts 'error'
    end
  end
  p color_hash
  matched_pairs = 0
  color_hash.each_value do |value|
    # p value
    matched_pairs += (value / 2)
  end

  p matched_pairs
end

sockMerchant(7, arr)
