require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    #
    # DECRIPTION Part 1
    #
    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns correct result' do
          expect(solution_pt1(example_input)).to eq 'sample_input'
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(solution_pt1(custom_input)).to eq 'test input'
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # DECRIPTION Part 2
    #
    context 'example input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(example_input)).to eq 'solution for part 2'
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(custom_input)).to eq 'solution for part 2'
      end
    end
  end
end
