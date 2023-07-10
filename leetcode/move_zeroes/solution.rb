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

def move_zeroes(nums)
  # naive count 0, delete, push 0 * count.times
  # MEMhog - doesnt even make to rankings on LEETCODE
    # count = nums.count(0)
    # nums.delete(0)
    # nums + Array.new(count, 0)

  # proper'ish solution. using delete_at and push
  # delete_at magic shifts the tails, so we don't need to worry about it
  # Runtime: 111-124-149 ms 20-80-(97)% better than other submissions UNSTABLE
  # Memory Usage: 212.6-8 MB 90+% better than other submissions - STABLEish
  stop_index = nums.size - 1
  index = 0
  until index == stop_index
    if nums[index] == 0
      nums.delete_at(index)
      nums << 0
      stop_index -= 1
    else
      index += 1
    end
  end
  nums
end

RSpec.describe 'Solution' do
  let(:input_one) { [0, 1, 0, 3, 12] }
  let(:input_two) { [0] }
  it 'returns incremented big num as an array of digits' do
    expect(move_zeroes(input_one)).to eq([1, 3, 12, 0, 0])
    expect(move_zeroes(input_two)).to eq [0]
  end
end
