arr = [10, 20, 20, 10, 10, 30, 50, 10, 20]
def sockMerchant(n, ar)
  # ar.to_h
  # puts ar
  color_hash = {}

  ar.each do |color|
      if color_hash[color].nil?
        color_hash[color] = 0
      elsif color_hash.key?(color)
          # puts color.to_s.insert(" adding")
          color_hash[color] += 1
      else
        puts "error"
      end
        
  end
  color_hash

end

sockMerchant(7, arr)