require File.join(__dir__, '../lib/node')

ROOT = Node.new('/')

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

def execute_command(command)
  case command.first.scan(/cd|ls/).first
  when 'cd'
    folder = get_folder_name(command.first)
    go_to(folder)
  when 'ls'
    command[1..-1]
      .each do |comm|
      case file_or_dir?(comm)
      when ['dir']
        dir = comm.split.last
        unless already_exists?(dir)
          new_dir = Stacker.new.insert(cursor, dir)
          new_dir.parent = cursor
        end
      else
        Stacker.new.insert(cursor, comm) unless already_exists?(comm)
      end
    end
  end
end

def get_node(filename)
  @cursor.children.find { |c| c.data.eql? filename }
end

def total_size_of_children(dir)
  size = 0
  dir.children.each do |item|
    size += if item.children.empty?
              get_size(item)
            else
              total_size_of_children(item)
            end
  end
  size
end

def get_size(node)
  node.data.scan(/^\d+/).first.to_i
end

def go_to(folder)
  case folder
  when '/'
    cursor = ROOT
  when '..'
    @cursor = @cursor.parent
  else
    @cursor = @cursor.children.find { |c| c.data.eql? folder }
  end
end

def already_exists?(name)
  cursor.children.find { |c| c.data.eql? name } ? true : false
end

def file_or_dir?(input)
  input.scan(/dir/)
end

def get_folder_name(command)
  command
    .scan(/\S+$/)
    .first
end

def cursor
  @cursor ||= ROOT
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
