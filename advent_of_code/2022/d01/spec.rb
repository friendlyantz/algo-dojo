require File.join(__dir__, 'solution')
require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'final result for pt1' do
    context 'example input data' do
      it 'return correct result' do
        expect(solution_pt1(example_input)).to eq 'lala'
      end
    end

    context 'custom input data' do
      it 'return correct result' do
        expect(solution_pt1(custom_input)).to eq 'test input'
      end
    end
  end

  describe 'final result for pt2' do
    context 'example input data' do
      it 'return correct result' do
        expect(solution_pt1(example_input)).to eq 'solution for part 2'
      end
    end

    context 'custom input data' do
      it 'return correct result' do
        expect(solution_pt1(custom_input)).to eq 'solution for part 2'
      end
    end
  end
end
