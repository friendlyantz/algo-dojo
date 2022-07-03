# --- Day 1: Sonar Sweep ---

# You're minding your own business on a ship at sea when the overboard alarm goes off! You rush to see if you can help. Apparently, one of the Elves tripped and accidentally sent the sleigh keys flying into the ocean!

# Before you know it, you're inside a submarine the Elves keep ready for situations like this. It's covered in Christmas lights (because of course it is), and it even has an experimental antenna that should be able to track the keys if you can boost its signal strength high enough; there's a little meter that indicates the antenna's signal strength by displaying 0-50 stars.

# Your instincts tell you that in order to save Christmas, you'll need to get all fifty stars by December 25th.

# Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

# As the submarine drops below the surface of the ocean, it automatically performs a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report (your puzzle input) appears: each line is a measurement of the sea floor depth as the sweep looks further and further away from the submarine.

# For example, suppose you had the following report:

# 199
# 200
# 208
# 210
# 200
# 207
# 240
# 269
# 260
# 263

# This report indicates that, scanning outward from the submarine, the sonar sweep found depths of 199, 200, 208, 210, and so on.

# The first order of business is to figure out how quickly the depth increases, just so you know what you're dealing with - you never know if the keys will get carried into deeper water by an ocean current or a fish or something.

# To do this, count the number of times a depth measurement increases from the previous measurement. (There is no measurement before the first measurement.) In the example above, the changes are as follows:

# 199 (N/A - no previous measurement)
# 200 (increased)
# 208 (increased)
# 210 (increased)
# 200 (decreased)
# 207 (increased)
# 240 (increased)
# 269 (increased)
# 260 (decreased)
# 263 (increased)

# In this example, there are 7 measurements that are larger than the previous measurement.

# How many measurements are larger than the previous measurement?

# Your puzzle answer was 1448.

require_relative '01a_inputs'

DEPTHS.map!(&:to_i)

def counting_depths(_data)
  current_depth = 0
  depth_increase_count = 0
  previous_depth = DEPTHS.first # TODO

  DEPTHS.each do |current_depth|
    if current_depth < previous_depth
      puts "#{current_depth} -> decrease. #{previous_depth}. COUNTER: #{depth_increase_count}"
      previous_depth = current_depth
    elsif current_depth > previous_depth
      depth_increase_count += 1
      puts "#{current_depth} -> increase. #{previous_depth}. COUNTER: #{depth_increase_count}"
      previous_depth = current_depth
    elsif current_depth == previous_depth
      puts "#{current_depth} -> no depth change. #{previous_depth}. COUNTER: #{depth_increase_count}"
    else
      puts "#{current_depth} -> error. COUNTER: #{depth_increase_count}"
    end
  end
  p depth_increase_count
end

counting_depths(DEPTHS)

# _______________________________________________________
# ALL SOLUTIONS REPOS
# https://github.com/gusgollings/adventofcode2021
# https://github.com/tomdalling/advent_of_code_2021
# https://github.com/trev/adventofcode2021/
# https://github.com/astley92/Aoc_2021/
# https://github.com/corroded/aoc-2021/

# Wei Zeng  < 1 minute ago
#   mine with elixir and TEST !!!
#   https://github.com/gzzengwei/advent-of-code_solutions

# _______________________________________________________
# EXTRA SOLUTION BY: Michael Milewski <saramic@gmail.com>

# DEPTHS.map(&:to_i).reduce({last: nil, count: 0}){|acc,a| { count: (acc[:last] && acc[:last] < a) ? acc[:count] + 1 : acc[:count], last: a } }[:count]

# _______________________________________________________
# # EXTRA SOLUTION BY: Tom Dalling <tomdalling@users.noreply.github.com>
# DEPTHS = DATA.lines.map(&:strip).map(&:to_i)

# puts(
#   DEPTHS.zip([nil] + DEPTHS).count do |(this_depth, prev_depth)|
#     prev_depth && this_depth > prev_depth
#   end
# )
# __END__
# 190
# 168
# 166
# 163
# 170
# 160
# 190
# 168
# 166
# 163
# 170
# 160
# 171
# 166
# 161
# 167
# 175
# 178
# 193
# 189
# 188
# 191
# 193
# 192
# 193
# 180
# 177
# 178
# 176
# 177
# 196
# 203
# 211
# 209
# 210
# 209
# 225
# 219
# 229
# 214
# 202
# 205
# 208
# 207
# 208
# 204
