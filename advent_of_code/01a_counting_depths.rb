require_relative  '01a_inputs'

DEPTHS.map!(&:to_i)

def counting_depths(data)
  current_depth = 0
  depth_increase_count = 0
  previous_depth = DEPTHS.first #TODO

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
