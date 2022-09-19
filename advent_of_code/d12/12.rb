require 'pry'

def solve_puzzle
  read_data
    .map { |data| prepare(data) }
    .then { |data| list_nodes(data) }
    .then { |data| build_paths(data) }
    .then do |data|
      pp data.flatten
             .reject(&:nil?)
             .join
             .split('end')
             .uniq
             .count
    end
end

def list_nodes(data)
  data.each_with_object({}) do |(a, b), nodes|
    nodes[a] ||= []
    nodes[b] ||= []
    nodes[a] = nodes[a] << b unless nodes[a].include?(b)
    nodes[b] = nodes[b] << a unless nodes[b].include?(a)
  end
end

def build_paths(key = 'start', path_so_far = [], nodes)
  return path_so_far + ['end'] if key == 'end'

  connections = nodes[key]

  connections.map do |name|
    next if name == 'start'
    next if path_so_far.include?(name) && name.match(/[a-z]/)

    build_paths(name, path_so_far + [key], nodes)
  end
end

def read_data
  DATA.read.split("\n")
end

def prepare(data)
  data.split('-')
end

solve_puzzle

__END__
ax-end
xq-GF
end-xq
im-wg
ax-ie
start-ws
ie-ws
CV-start
ng-wg
ng-ie
GF-ng
ng-av
CV-end
ie-GF
CV-ie
im-xq
start-GF
GF-ws
wg-LY
CV-ws
im-CV
CV-wg
