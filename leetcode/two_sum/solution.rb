# frozen_string_literal: true
#
# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

# You may assume that each input would have exactly one solution, and you may not use the same element twice.

# You can return the answer in any order.

# Example 1:

# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

# Example 2:

# Input: nums = [3,2,4], target = 6
# Output: [1,2]

# Example 3:

# Input: nums = [3,3], target = 6
# Output: [0,1]

# Constraints:

#     2 <= nums.length <= 104
#     -109 <= nums[i] <= 109
#     -109 <= target <= 109
#     Only one valid answer exists.

# Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?

def two_sum(nums, target)
  # n^2 solution
  # Doesn't pass time limit on LEETCODE
  # nums.each_with_index do |num, index|
  #   nums[index.next..].each_with_index do |num2, index2|
  #     return [index, index.next + index2] if (num + num2) == target
  #   end
  # end
  #

  # Runtime: 399 ms - 20% off solutions
  # Memory Usage: 211 MB - 99% better than other submissions STABLE!!!!
  last_index = nums.size - 1
  nums.size.times do |index|
    num = nums.pop # poping from tail is faster, shift wont pass time limit
    nums.each_with_index do |num2, index2|
      return [index2, last_index - index] if (num + num2) == target
    end
  end
end

RSpec.describe 'Solution' do
  it 'works' do
    expect(two_sum([2,7,11,15], 9)).to eq([0,1])
    expect(two_sum([3,2,4], 6)).to eq [1,2]
    expect(two_sum([3,3], 6)).to eq [0,1]
  end
end
