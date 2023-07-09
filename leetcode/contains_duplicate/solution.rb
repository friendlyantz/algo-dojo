# frozen_string_literal: true

# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

# Example 1:

# Input: nums = [1,2,3,1]
# Output: true

# Example 2:

# Input: nums = [1,2,3,4]
# Output: false

# Example 3:

# Input: nums = [1,1,1,3,3,4,3,2,4,2]
# Output: true

# Constraints:

#     1 <= nums.length <= 105
#     -109 <= nums[i] <= 109

def contains_duplicate(nums)
  # nums.tally.any? { |_k, v| v > 1 }
  nums.uniq != nums
end

RSpec.describe 'Solution' do
  let(:input_one) { [1, 1, 1, 3, 3, 4, 3, 2, 4, 2] }
  let(:input_two) { [1, 2, 3, 4] }
  it 'return true for double up values and false if all unique' do
    expect(contains_duplicate(input_one)).to eq true
    expect(contains_duplicate(input_two)).to eq false
  end
end
