# frozen_string_literal: true

require_relative 'chiton'
require 'pry'

RSpec.describe LegacyChiton do
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

RSpec.describe PriorityQueueChiton do
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

    describe 'legacy interface' do
      it 'solves puzzle one' do
        expect(chilton.solve_puzzle_one).to eq 40
      end
    end

    context 'elementary input' do
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

    describe 'Priority Queue interface' do
      it 'solves puzzle one' do
        expect(chilton.find_path).to eq 40
        print PriorityQueueChiton.new(File.read('input')).find_path.eql?(363) ? '😀' : '😔'
      end
    end
  end
end
