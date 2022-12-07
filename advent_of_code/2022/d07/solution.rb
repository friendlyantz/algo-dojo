FSYS = {}

def solution_pt1(input)
  input
  # .then { |data| binding.pry }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def separate_commands_with_their_outputs(input)
  input
    .split('$')
    .map(&:lines)[1..-1]
    .map! { |line| line.map(&:chomp) }
end

def read_command(command)
  case command.first.scan(/cd|ls/).first
  when 'cd'
    folder = get_folder_name(command.first)
    FSYS[folder] ||= {}
  when 'ls'
    command[1..-1]
      .each do |comm|
      current_pos
      case file_or_dir?(comm)
      when ['dir']
        dir = comm.split.last
        current_pos[dir] ||= {}
      else
        current_pos[comm.split.last] = comm.split.first.to_i
      end
    end

  end
end

def file_or_dir?(input)
  input.scan(/dir/)
end

def get_folder_name(command)
  command
    .scan(/\S+$/)
    .first
end

def current_pos
  @current_pos ||= FSYS['/']
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
