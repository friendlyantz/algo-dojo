# frozen_string_literal: true

require_relative 'd13_p1'
require 'pry'

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

RSpec.describe 'Day 13 part 1' do
  let(:origami) { TransparentOrigami.new(TEST_DATA) }

  describe 'object initialization' do
    it 'reads data and formats it' do
      expect(origami.instructions).to eq ['fold along y=7', 'fold along x=5']
      expect(origami.coordinates).to eq ['6,10', '0,14', '9,10', '0,3', '10,4', '4,11', '6,0', '6,12', '4,1', '0,13',
                                         '10,12', '3,4', '3,0', '8,4', '1,10', '2,14', '8,10', '9,0']
    end

    it 'returns a correct anwser' do
      expect(origami.solution).to eq 'hey'
    end
  end
end
