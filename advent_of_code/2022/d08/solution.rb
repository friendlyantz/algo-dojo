require File.join(__dir__, '../lib/colorize')

include MyColorize

def solution_pt1(input)
  input
    .then { |data| tree(data) }
    .then do |map|
      height = map.matrix.size
      width = map.matrix.first.length
      height.times do |i|
        scan_left(i)
        scan_right(i)
      end

      width.times do |i|
        scan_top(i)
        scan_bottom(i)
      end
      map
    end
    .then { |data| tally_visible(data) }
end

def solution_pt2(input)
  input
    .then { |data| tree(data) }
    .then do |forest|
       forest.matrix.each_with_index do |line, line_i|
          line.each_with_index do |cell, column_i|
            cell[:final_scenic_score] = scenic_score(line_i, column_i, forest) 
          end
       end
       forest
    end
  .then { |data|   
    data.matrix.flatten.map { _1[:final_scenic_score] }.max 
  }
end

def tree(data = nil)
  @tree ||= TreeMap.new(data)
end

def tally_visible(data)
  data.matrix.flatten.map { _1[:visible?] }.tally[true]
end

def tally_score(data)
  data.matrix.flatten.map { _1[:scenic_score] }
    .then { |data| data.compact.inject(:*) }
end

class TreeMap
  attr_reader :matrix

  def initialize(data)
    @matrix = generate_map(data)
  end

  def generate_map(data)
    data.lines.map(&:strip).map do |line|
      line.chars.map do |n|
        {
          value: n.to_i,
          visible?: false,
          scenic_score: nil,
          final_scenic_score: nil
        }
      end
    end
  end
end

def scenic_score(line_num, column_num, tree_map)
  tree_map
    .then do |map|
      our_height = map.matrix[line_num][column_num][:value]

      scan_left(line_num, { max: our_height, start: column_num })
      scan_right(line_num, { max: our_height, start: column_num })
      scan_top(column_num, { max: our_height, start: line_num })
      scan_bottom(column_num, { max: our_height, start: line_num })
      tree
    end
    .then do |forest|
      result = tally_score(forest) == 0 ? 1 : tally_score(forest)
      cleanup_scores(forest)
      result
  end
end

def cleanup_scores(tree_map)
  tree_map.matrix.each do |line|
    line.each do |tree|
      tree[:scenic_score] = nil
      tree[:visible?] = false
    end
  end
end

def scan(line, params = {})
  stack = []
  scenic_score_buffer_tree = line.last
  scenic_score_buffer_tree[:scenic_score] = 0
  max_height = params[:max] || hight_of_the_tallest_tree_in_line(line)
  line
    .each_cons(2)
    .with_index do |(prev_cell, next_cell), i|
    if i.eql? 0
      stack << prev_cell[:value] unless params[:start]
      prev_cell[:visible?] = true
    end
    if params[:start]
      if next_cell[:value] <= max_height
        scenic_score_buffer_tree[:scenic_score] += 1
        next_cell[:visible?] = true
      elsif next_cell[:value] > max_height

        scenic_score_buffer_tree[:scenic_score] += 1
        next_cell[:visible?] = true
        break
      end
    else
      visible_above(next_cell, stack)
    end

    stack << next_cell[:value]

    break if stack.max.eql?(max_height)
  end
  tree_map
end

def visible_above(next_cell, stack)
  next_cell[:visible?] = true if next_cell[:value] > stack.max
end

def scan_top(column_num, params = {})
  start = params[:start] || 0
  line = tree.matrix.transpose[column_num][start..]
  scan(line, params)
end

def scan_bottom(column_num, params = {})
  start = params[:start] || -1
  line = tree.matrix.transpose[column_num][..start].reverse
  scan(line, params)
end

def scan_left(line_num, params = {})
  start = params[:start] || 0

  line = tree.matrix[line_num][start..]
  scan(line, params)
end

def scan_right(line_num, params = {})
  stop = params[:start] || -1
  line = tree.matrix[line_num][..stop].reverse
  scan(line, params)
end

def hight_of_the_tallest_tree_in_line(line)
  line.map { _1[:value] }.max
end
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  MyColorize.print_out(
    generate_map(input)
    .map { _1.map { |i| i[:value] } }
  )
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
