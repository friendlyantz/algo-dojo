def solution_pt1(input)
  input
  .then { |data| prep_data(data) }
  .then { |data| cycle_through_instructions(data) }
  .then { |data| array_of_signals.sum } 
end

def solution_pt2(input)
  input
end

def x_register_inc(arg)
  @x_register += arg
end

def crt
  @crt ||= []
end

def cycle_count_inc(arg)
  @cycle_count += arg
  # puts "cycle: #{@cycle_count}, x_reg: #{@x_register}"
  check_cycle
end

def check_cycle
  if [20, 60, 100, 140, 180, 220].include?(@cycle_count)
    array_of_signals << @cycle_count * @x_register
  end
end

def array_of_signals
  @array_of_signals
end

def cycle_through_instructions(data)
  @cycle_count = 0
  @x_register = 1
  @array_of_signals = []
  data
  .each_with_index do |arg, _i|
    if arg == 0
      cycle_count_inc(1)
      next
    end

    increment_x_reg(arg)
  end
  nil
end

def increment_x_reg(arg)
  cycle_count_inc(1)
  cycle_count_inc(1)
  x_register_inc(arg)
end

def prep_data(data)
  data.lines.map(&:chomp).map do |line|
    line == 'noop' ? 0 : line.split.last.to_i
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
