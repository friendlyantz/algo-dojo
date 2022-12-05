# https://github.com/seanhandley/adventofcode2021/

require 'pry'

def input
  @input ||= DATA.read.split("\n").map { |line| line.split('-') }
end

def nodes
  @nodes ||= input.each_with_object({}) do |(a, b), nodes|
    nodes[a] ||= []
    nodes[b] ||= []
    nodes[a] = nodes[a] << b unless nodes[a].include?(b)
    nodes[b] = nodes[b] << a unless nodes[b].include?(a)
  end
end

def build_paths(key = 'start', path_so_far = [])
  return path_so_far + ['end'] if key == 'end'

  connections = nodes[key]

  connections.map do |name|
    next if name == 'start'
    next if path_so_far.include?(name) && name =~ /[a-z]/

    build_paths(name, path_so_far + [key])
  end
end

@paths = []

def paths(x = build_paths)
  if x.none? { |e| e.is_a?(Array) } && !x.compact.empty?
    binding.pry
    @paths << x
    return
  end

  x.compact.map do |q|
    paths(q)
  end
  @paths
end

p paths.count if __FILE__ == $0

__END__
start-A
start-b
A-c
A-b
b-d
A-end
b-end
