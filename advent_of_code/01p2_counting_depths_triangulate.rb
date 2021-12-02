require_relative '01a_inputs'
require_relative '01_calibration_data'

# DEPTHS = CAL_DEPTHS # calibration data

DEPTHS.map!(&:to_i)

def counting_depths(_data)
  depth_increase_count = 0
  previous_triangle_sum = DEPTHS[0, 3].sum

  DEPTHS.each_cons(3) do |current_triangle|
    p current_triangle

    if current_triangle.sum < previous_triangle_sum
      puts "#{current_triangle.sum} -> decrease. #{previous_triangle_sum}. COUNTER: #{depth_increase_count}"
      previous_triangle_sum = current_triangle.sum
    elsif current_triangle.sum > previous_triangle_sum
      depth_increase_count += 1
      puts "#{current_triangle.sum} -> increase. #{previous_triangle_sum}. COUNTER: #{depth_increase_count}"
      previous_triangle_sum = current_triangle.sum
    elsif current_triangle.sum == previous_triangle_sum
      puts "#{current_triangle.sum} -> no depth change. #{previous_triangle_sum}. COUNTER: #{depth_increase_count}"
    else
      puts "#{current_triangle.sum} -> error. COUNTER: #{depth_increase_count}"
    end
  end
  p depth_increase_count
end

counting_depths(DEPTHS)
