# require_relative '../d09/09_smoke'
require_relative '../d09/09_smoke'

RSpec.describe 'Day 9 Smoke' do
  let(:cal_data) do
    "2199943210
3987894921
9856789892
8767896789
9899965678
"
  end

  describe 'data_prep' do
    subject { data_prep(cal_data) }
    it 'breaks down data into lines' do
      expect(subject).to eq([2_199_943_210,
                             3_987_894_921,
                             9_856_789_892,
                             8_767_896_789,
                             9_899_965_678])
    end
  end

  describe 'low points' do
    let(:array_of_lines) do
      [2_199_943_210,
       3_987_894_921,
       9_856_789_892,
       8_767_896_789,
       9_899_965_678]
    end
    subject do
      find_low_points(array_of_lines)
    end

    it 'find_low_points outputs array of low point values' do
      expect(subject).to eq [1, 0, 5, 5]
    end

    it 'find_low_points_of_line outputs array of low point values' do
      expect(find_low_points_of_line(2_199_943_210)).to eq [1, 0]
      expect(find_low_points_of_line(3_987_894_921)).to eq []
      expect(find_low_points_of_line(9_856_789_892)).to eq [5]
      expect(find_low_points_of_line(8_767_896_789)).to eq []
      expect(find_low_points_of_line(9_899_965_678)).to eq [5]
    end

    it 'calculates the sum of risk factors of low points' do
      expect(low_points_risk_factor([1, 0, 5, 5])).to eq 16
    end
  end
end
