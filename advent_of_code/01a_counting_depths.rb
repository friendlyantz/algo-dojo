require_relative  '01a_inputs'

DEPTHS.map!(&:to_i)

p DEPTHS.first.class

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

# Michael Milewski <saramic@gmail.com>
# DEPTHS.map(&:to_i).reduce({last: nil, count: 0}){|acc,a| { count: (acc[:last] && acc[:last] < a) ? acc[:count] + 1 : acc[:count], last: a } }[:count]
