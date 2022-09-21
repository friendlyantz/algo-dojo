# frozen_string_literal: true

# You reach another volcanically active part
# of the cave. It would be nice if you could
# do some kind of thermal imaging so you could
# tell ahead of time which caves are too hot
# to safely enter.

# Fortunately, the submarine seems to be
# equipped with a thermal camera! When you
# activate it, you are greeted with:

# Congratulations on your purchase! To
# activate this infrared thermal imaging
# camera system, please enter the code found on page 1 of the manual.

# Apparently, the Elves have never used this
# feature. To your surprise, you manage to
# find the manual; as you go to open it, page
# 1 falls out. It's a large sheet of
# transparent paper! The transparent paper is
# marked with random dots and includes
# instructions on how to fold it up (your
# puzzle input). For example:

# 6,10
# 0,14
# 9,10
# 0,3
# 10,4
# 4,11
# 6,0
# 6,12
# 4,1
# 0,13
# 10,12
# 3,4
# 3,0
# 8,4
# 1,10
# 2,14
# 8,10
# 9,0

# fold along y=7
# fold along x=5

# The first section is a list of dots on the
# transparent paper. 0,0 represents the
# top-left coordinate. The first value, x,
# increases to the right. The second value, y,
# increases downward. So, the coordinate 3,0
# is to the right of 0,0, and the coordinate
# 0,7 is below 0,0. The coordinates in this
# example form the following pattern, where #
# is a dot on the paper and . is an empty,
# unmarked position:

# ...#..#..#.
# ....#......
# ...........
# #..........
# ...#....#.#
# ...........
# ...........
# ...........
# ...........
# ...........
# .#....#.##.
# ....#......
# ......#...#
# #..........
# #.#........

# Then, there is a list of fold instructions.
# Each instruction indicates a line on the
# transparent paper and wants you to fold the
# paper up (for horizontal y=... lines) or
# left (for vertical x=... lines). In this
# example, the first fold instruction is fold
# along y=7, which designates the line formed
# by all of the positions where y is 7 (marked
# here with -):

# ...#..#..#.
# ....#......
# ...........
# #..........
# ...#....#.#
# ...........
# ...........
# -----------
# ...........
# ...........
# .#....#.##.
# ....#......
# ......#...#
# #..........
# #.#........

# Because this is a horizontal line, fold the
# bottom half up. Some of the dots might end
# up overlapping after the fold is complete,
# but dots will never appear exactly on a fold
# line. The result of doing this fold looks
# like this:

# #.##..#..#.
# #...#......
# ......#...#
# #...#......
# .#.#..#.###
# ...........
# ...........

# Now, only 17 dots are visible.

# Notice, for example, the two dots in the
# bottom left corner before the transparent
# paper is folded; after the fold is complete,
# those dots appear in the top left corner (at
# 0,0 and 0,1). Because the paper is
# transparent, the dot just below them in the
# result (at 0,3) remains visible, as it can
# be seen through the transparent paper.

# Also notice that some dots can end up overlapping; in this case, the dots merge together and become a single dot.

# The second fold instruction is fold along x=5, which indicates this line:

# #.##.|#..#.
# #...#|.....
# .....|#...#
# #...#|.....
# .#.#.|#.###
# .....|.....
# .....|.....

# Because this is a vertical line, fold left:

# #####
# #...#
# #...#
# #...#
# #####
# .....
# .....

# The instructions made a square!

# The transparent paper is pretty big, so for
# now, focus on just completing the first
# fold. After the first fold in the example
# above, 17 dots are visible - dots that end
# up overlapping after the fold is completed
# count as a single dot.

# How many dots are visible after completing
# just the first fold instruction on your
# transparent paper?
class TransparentOrigami
  attr_reader :instructions, :coordinates

  def initialize(input) # rubocop:disable Metrics/MethodLength
    partitioned_input = input
                        .lines
                        .partition { |e| e.start_with?(/[0-9]/) }

    @coordinates = partitioned_input
                   .first
                   .map(&:strip)
                   .map do |string|
      string.split(',')
            .map(&:to_i)
    end

    @instructions = partitioned_input
                    .last
                    .map(&:strip)
                    .reject(&:empty?)
  end

  def solution
    p 'hey'
  end

  def generate_empty_matrix # rubocop:disable Metrics/MethodLength
    width = @coordinates.map(&:first).max + 1
    height = @coordinates.map(&:last).max + 1
    matrix_array = []
    height.times do
      line = []
      width.times do
        line << '.'
      end
      matrix_array << line
    end
    matrix_array
  end

  def mark_coordinates(matrix)
    @coordinates.each do |coord|
      matrix[coord.first][coord.last] = '#'
    end
    matrix
  end

  def fold(matrix) # rubocop:disable Metrics/AbcSize
    @instructions.each do |instruction|
      fold_line = instruction[/\d+/].to_i - 1

      if instruction.include?('x=')
        matrix.each_with_index do |line, i|
          first_half = line[0..fold_line]
          second_half = line[(fold_line + 2)..]
          sm_half = compare(first_half, second_half).first
          lg_half = compare(first_half, second_half).last

          sm_half.each_with_index do |char, j|
            lg_half[-1 - j] = char if char.eql?('#')
          end
          matrix[i] = lg_half
        end
        matrix

      elsif instruction.include?('y=')
        first_half =  matrix[0..fold_line]
        second_half = matrix[(fold_line + 2)..]

        sm_half = compare(first_half, second_half).first
        lg_half = compare(first_half, second_half).last

        sm_half.each_with_index do |line, i|
          line.each_with_index do |char, j|
            lg_half.reverse[i][j] = char if char.eql?('#')
          end
        end
        matrix = lg_half
      end
    end
    matrix
  end

  def compare(first_half, second_half)
    if first_half.size >= second_half.size
      sm_half = second_half
      lg_half = first_half
    else
      sm_half = first_half
      lg_half = second_half
    end
    [sm_half, lg_half]
  end
end
