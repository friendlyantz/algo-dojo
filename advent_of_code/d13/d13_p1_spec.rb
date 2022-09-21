# frozen_string_literal: true

require_relative 'd13_p1'
require 'pry'
require 'super_diff/rspec'

TEST_DATA = '6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5'

RSpec.describe 'Day 13 part 1' do # rubocop:disable Metrics/BlockLength
  let(:origami) { TransparentOrigami.new(TEST_DATA) }
  let(:matrix) do
    "...#..#..#.
     ....#......
     ...........
     #..........
     ...#....#.#
     ...........
     ...........
     ...........
     ...........
     ...........
     .#....#.##.
     ....#......
     ......#...#
     #..........
     #.#........"
      .split.map(&:chars)
  end
  let(:folded_origami) do
    "#####
         #...#
         #...#
         #...#
         #####
         .....
         ....."
      .split.map(&:chars)
  end
  describe 'object initialization' do
    it 'reads data and formats it' do
      expect(origami.instructions).to eq ['fold along y=7', 'fold along x=5']
      expect(origami.coordinates).to eq [[6, 10], [0, 14], [9, 10], [0, 3], [10, 4], [4, 11], [6, 0], [6, 12], [4, 1],
                                         [0, 13], [10, 12], [3, 4], [3, 0], [8, 4], [1, 10], [2, 14], [8, 10], [9, 0]]
    end
  end

  describe 'data preparation' do
    it 'generate_empty_matrix draws a matrix of a correct height(Y=15) and width(X=11)' do
      expect(origami.generate_empty_matrix.size).to eq 15
      expect(origami.generate_empty_matrix.first.size).to eq 11
      expect(origami.generate_empty_matrix.last.size).to eq 11
    end

    it 'mark_coordinates marks according to coordinates' do
      matrix = origami.generate_empty_matrix
      expect(origami
        .mark_coordinates(matrix)).to eq matrix
    end
  end

  describe 'folding' do
    context 'only 1 fold' do
      before do
        origami.instructions.pop
      end
      let(:expected) do
        "#.##..#..#.
         #...#......
         ......#...#
         #...#......
         .#.#..#.###
         ...........
         ..........."
          .split.map(&:chars)
      end
      it 'folds matrix as per instructions' do
        expect(origami.fold(matrix)).to eq expected
      end
    end

    context 'all instruction folds' do
      it 'folds matrix as per instructions' do
        expect(origami.fold(matrix)).to eq folded_origami
      end
    end
  end

  describe 'count dots' do
    context 'only after first fold' do
      let(:staged_origami) do
        "#.##..#..#.
         #...#......
         ......#...#
         #...#......
         .#.#..#.###
         ...........
         ..........."
          .split.map(&:chars)
      end
      it 'counts total number of dots after folwing' do
        expect(
          origami.count_dots(staged_origami)
        ).to eq 17
      end

      it '.solve_puzzle solves the 1st part of the puzzle all at one' do
        expect(
          origami.solve_puzzle_one
        ).to eq 17
      end
    end
  end
end
