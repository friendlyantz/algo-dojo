class SevenDigitMap
  attr_accessor :tt, :tl, :tr, :mm, :br, :bl, :bb

  def initialize
    @tt = ''
    @tl = ''
    @tr = ''
    @mm = ''
    @bl = ''
    @br = ''
    @bb = ''
  end

  def decode_message(array)
    decoded_digit = ''
    array.each do |encoded_digit|
      case encoded_digit.size
      when 2
        decoded_digit << '1'
      when 3
        decoded_digit << '7'
      when 4
        decoded_digit << '4'
      when 5
        decoded_digit << decode_two_five_three(encoded_digit)
      when 6
        decoded_digit << decode_six_nine_zero(encoded_digit)
      when 7
        decoded_digit << '8'
      else
        p '---errror'
      end
    end
    decoded_digit.to_i
  end

  def decode_two_five_three(encoded_digit)
    if encoded_digit.include?(@br) && encoded_digit.include?(@tr)
      '3'
    elsif encoded_digit.include?(@br) && !encoded_digit.include?(@tr)
      '5'
    elsif !encoded_digit.include?(@br) && encoded_digit.include?(@tr)
      '2'
    else
      puts 'error'
    end
  end

  def decode_six_nine_zero(encoded_digit)
    if !encoded_digit.include?(@mm)
      '0'
    elsif !encoded_digit.include?(@bl)
      '9'
    elsif !encoded_digit.include?(@tr)
      '6'
    else
      puts 'error'
    end
  end

  def decypher(ten_codes_sorted_by_code_length)
    draft_one_tr_br(ten_codes_sorted_by_code_length[0]) # first 2digit ab
    decode_seven_tt(ten_codes_sorted_by_code_length[1]) # second 3digit ab+c
    draft_four_tl_mm(ten_codes_sorted_by_code_length[2]) # third 4 digit ab+de
    decode_two_three_five(ten_codes_sorted_by_code_length[3, 3])
  end

  def draft_one_tr_br(this_code)
    this_code.each_char do |c|
      @tr << c
      @br << c
    end
  end

  def decode_seven_tt(this_code)
    @tt = this_code.delete(@br || @tr)
  end

  def decode_three_mm_bb_tl(array_of_codes)
    code_three = array_of_codes.find { |code| code.count(@br) == 2 }
    @mm = (code_three.chars & @tl.chars).first # overlap with 4 - detecting @mm - miodline
    @tl.delete! @mm # based on 4shape, cleaning midline from tl
    @bb = code_three.delete @tt + @tl + @tr + @mm + @br + @bl + @bb
  end

  def decode_five_br_tr(array_of_codes)
    code_five = array_of_codes.find { |code| code.count(@tl) == 1 } # only five has tl
    @br = (code_five.chars & @tr.chars).first # math vs 1
    @tr.delete! @br # based on one, cleaning up br
  end

  def decode_two_bl(array_of_codes)
    code_two = array_of_codes.find do |code|
      !code.delete(@tt + @tl + @tr + @mm + @br + @bl + @bb).empty?
    end

    @bl = code_two.delete @tt + @tl + @tr + @mm + @br + @bl + @bb
  end

  def decode_two_three_five(array_of_codes)
    decode_three_mm_bb_tl(array_of_codes)
    decode_five_br_tr(array_of_codes)
    decode_two_bl(array_of_codes)
  end

  def draft_four_tl_mm(this_code)
    @mm = this_code.delete(@br || @tr)
    @tl = this_code.delete(@br || @tr)
  end
end
