require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    #
    #--- Day 8: Treetop Tree House ---

    # The expedition comes across a peculiar patch of tall trees all planted carefully in a grid. The Elves explain that a previous expedition planted these trees as a reforestation effort. Now, they're curious if this would be a good location for a tree house.

    # First, determine whether there is enough tree cover here to keep a tree house hidden. To do this, you need to count the number of trees that are visible from outside the grid when looking directly along a row or column.

    # The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For example:

    # 30373
    # 25512
    # 65332
    # 33549
    # 35390

    # Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

    # A tree is visible if all of the other trees between it and an edge of the grid are shorter than it. Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

    # All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view. In this example, that only leaves the interior nine trees to consider:

    #     The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
    #     The top-middle 5 is visible from the top and right.
    #     The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
    #     The left-middle 5 is visible, but only from the right.
    #     The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
    #     The right-middle 3 is visible from the right.
    #     In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

    # With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

    # Consider your map; how many trees are visible from outside the grid?

    describe 'implementation' do
      let(:tree_map) { TreeMap.new(example_input) }
      it 'generates map with correct heights' do
        result = tree_map.matrix
                         .map { _1.map { |i| i[:value] } }
        expect(result).to eq(
          [[3, 0, 3, 7, 3, 0],
           [2, 5, 5, 1, 2, 0],
           [6, 5, 3, 3, 2, 0],
           [3, 3, 5, 4, 9, 0],
           [3, 5, 3, 9, 0, 0]]
        )
      end
      describe 'scans horizontally' do
        it 'scannin from left the line with index 1 marks top left "5" as visible' do
          result = scan_left(tree_map, 1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false, false],
             [false, true, false, false, false, false],
             [false, false, false, false, false, false],
             [false, false, false, false, false, false],
             [false, false, false, false, false, false]]
          )
        end

        it 'scannin from right the line with index 1 marks top left "5" as visible' do
          result = scan_right(tree_map, 1)
                   .matrix
                   .map { _1.map { |i| i[:visible?] } }
          expect(result).to eq(
            [[false, false, false, false, false, false],
             [false, false, true, false, false, false],
             [false, false, false, false, false, false],
             [false, false, false, false, false, false],
             [false, false, false, false, false, false]]
          )
        end
      end
    end

    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(solution_pt1(example_input)).to eq true
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(solution_pt1(custom_input)).to eq true
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # DESCRIPTION Part 2
    #
    context 'example input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(example_input)).to eq true
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(custom_input)).to eq true
      end
    end
  end
end
