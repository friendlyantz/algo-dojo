# frozen_string_literal: true

require_relative 'chiton'
require 'pry'

RSpec.describe Chiton do
  context 'example input' do
    let(:input) do
      <<~INPUT
        1163751742
        1381373672
        2136511328
        3694931569
        7463417111
        1319128137
        1359912421
        3125421639
        1293138521
        2311944581
      INPUT
    end

    let(:chilton) { described_class.new(input) }

    it 'solves puzzle one' do
      expect(chilton.solve_puzzle_one).to eq 40
    end
  end

  context 'simple' do
    let(:input) do
      <<~INPUT
        123
        111
        456
      INPUT
    end

    let(:chilton) { described_class.new(input) }
    let(:paths) do
      [[[0, 0], [1, 0], [2, 0], [2, 1]],
       [[0, 0], [1, 0], [1, 1], [2, 1]],
       [[0, 0], [1, 0], [1, 1], [1, 2]]]
    end
    it 'filters paths' do
      expect(chilton.filter_paths).to eq(paths)
    end

    it 'solves puzzle one' do
      expect(chilton.solve_puzzle_one).to eq 9
    end
  end
end
