# --- Part Two ---

# Considering every single measurement isn't as useful as you expected: there's just too much noise in the data.

# Instead, consider sums of a three-measurement sliding window. Again considering the above example:

# 199  A      
# 200  A B    
# 208  A B C  
# 210    B C D
# 200  E   C D
# 207  E F   D
# 240  E F G  
# 269    F G H
# 260      G H
# 263        H

# Start by comparing the first and second three-measurement windows. The measurements in the first window are marked A (199, 200, 208); their sum is 199 + 200 + 208 = 607. The second window is marked B (200, 208, 210); its sum is 618. The sum of measurements in the second window is larger than the sum of the first, so this first comparison increased.

# Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum. So, compare A with B, then compare B with C, then C with D, and so on. Stop when there aren't enough measurements left to create a new three-measurement sum.

# In the above example, the sum of each three-measurement window is as follows:

# A: 607 (N/A - no previous sum)
# B: 618 (increased)
# C: 618 (no change)
# D: 617 (decreased)
# E: 647 (increased)
# F: 716 (increased)
# G: 769 (increased)
# H: 792 (increased)

# In this example, there are 5 sums that are larger than the previous sum.

# Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?

# Your puzzle answer was 1471.

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
