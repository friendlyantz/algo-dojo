require_relative '02p1_data'

CAL_DATA = %w[
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
]

current_travel = 0
current_depth = 0
current_aim = 0
NAVIGATION.each_slice(2) do |command_pair|
  case command_pair[0]
  when 'forward'
    current_travel += command_pair[1].to_i
    depth_delta = command_pair[1].to_i * current_aim
    current_depth += depth_delta
  when 'down'
    current_aim += command_pair[1].to_i
  when 'up'
    current_aim -= command_pair[1].to_i
  else
    puts 'error'
  end
end

p "Current traverse: #{current_travel}"
p "Current depth: #{current_depth}"
p "Multiplied: #{current_travel * current_depth}"
