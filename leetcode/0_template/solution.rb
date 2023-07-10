# frozen_string_literal: true

RSpec.describe 'Solution' do
  let(:input_one) { [1, 2, 3] }
  let(:input_two) { [9, 9] }
  it 'returns incremented big num as an array of digits' do
    expect(plus_one(input_one)).to eq([1, 2, 4])
    expect(plus_one(input_two)).to eq [1, 0, 0]
  end
end
