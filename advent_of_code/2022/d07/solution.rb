require File.join(__dir__, '../lib/node')

ROOT = Node.new('/')

def solution_pt1(input)
  input
    .then { |data| separate_commands_with_their_outputs(data) }
    .each { |data|  execute_command(data) }
    .then do
      get_folder_sizes_incl_children
        .find_all { |i| i < 100_000 }
        .sum
    end
end

def solution_pt2(input)
  input
    .then { |data| separate_commands_with_their_outputs(data) }
    .each { |data|  execute_command(data) }
    .then {  get_folder_sizes_incl_children }
    .then do |data|
      acceptable_sizes = []
      data.each do |size|
        acceptable_sizes << size if 70_000_000 - data[-1] + size > 30_000_000
      end
      acceptable_sizes
    end
    .then &:min
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
    cd_to(folder)
  when 'ls'
    command[1..-1]
      .each do |comm|
      if file?(comm)
        Stacker.new.insert(cursor, comm) unless already_exists?(comm)
      else
        dir = comm.split.last
        unless already_exists?(dir)
          new_dir = Stacker.new.insert(cursor, dir)
          new_dir.parent = cursor
        end
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

def cd_to(folder)
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

def file?(input)
  input.match?(/^\d+/)
end

def get_folder_name(command)
  command
    .scan(/\S+$/)
    .first
end

def cursor
  @cursor ||= ROOT
end

def get_folder_sizes_incl_children
  @cursor = ROOT

  get_list_of_all_subdir_sizes(@cursor, []) << total_size_of_children(@cursor)
end

def get_list_of_all_subdir_sizes(current_node, stack_so_far)
  current_node.children.each do |subdir|
    stack_so_far << total_size_of_children(subdir) unless total_size_of_children(subdir) == 0
    next if no_more_folders? subdir

    get_list_of_all_subdir_sizes(subdir, stack_so_far)
  end
  stack_so_far
end

def no_more_folders?(folder)
  return false if folder.children.find { |i| i.data.match?(/^\D+$/) }
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
