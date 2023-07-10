# frozen_string_literal: true

# Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.

# Note that you must do this in-place without making a copy of the array.

# Example 1:

# Input: nums = [0,1,0,3,12]
# Output: [1,3,12,0,0]

# Example 2:

# Input: nums = [0]
# Output: [0]

# Constraints:

#     1 <= nums.length <= 104
#     -231 <= nums[i] <= 231 - 1

# Follow up: Could you minimize the total number of operations done?

def move_zeroes(nums); end

RSpec.describe 'Solution' do
  let(:input_one) { [0, 1, 0, 3, 12] }
  let(:input_two) { [0] }
  it 'returns incremented big num as an array of digits' do
    expect(move_zeroes(input_one)).to eq([1, 2, 4])
    expect(move_zeroes(input_two)).to eq [1, 0, 0]
  end
end
