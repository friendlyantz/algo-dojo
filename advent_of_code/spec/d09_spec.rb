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
  
  describe 'data prep' do
    subject { data_prep(cal_data) }
    
    it 'breaks down data into lines' do
      expect(subject).to eq([2199943210,
3987894921,
9856789892,
8767896789,
9899965678,
])
    end
  end

  describe 'example' do
    subject { 5 } # refer explicit_subject_spec.rb. This is no_name subject with block providing Integer '5' as a return

    context 'with classic syntax' do
      it 'should equal 5' do
        expect(subject).to eq(5)
      end
    end

    context 'with one line syntax' do
      it { is_expected.to eq(5) } # rspec helper generates test text (green/red) - only works with subject
    end
  end
end
