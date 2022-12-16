module MyColorize
  require 'colorize'

  def colors
    String.colors.reject { |c| %i[white black default].include?(c) }.shuffle.cycle
  end

  def gradient(num)
    {
      0 => :black,
      1 => :blue,
      2 => :light_blue,
      3 => :cyan,
      4 => :light_cyan,
      5 => :light_yellow,
      6 => :yellow,
      7 => :light_magenta,
      8 => :magenta,
      9 => :light_red
    }[num]
  end

  def print_out(data_for_clr)
    output = data_for_clr
    output.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        value = output[i][j] > 9 ? 'x' : output[i][j].to_s

        output[i][j] = if value == 'x'
                         value.colorize(
                           color: :black,
                           background: :red
                         )
                       else
                         value.colorize(
                           color: gradient(output[i][j] - 1),
                           background: gradient(output[i][j])
                         )
                       end
      end
    end
    output.each do |row|
      puts row.join
    end; nil
  end
end
