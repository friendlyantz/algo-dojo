# Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

# You must implement a solution with a linear runtime complexity and use only constant extra space.

 

# Example 1:

# Input: nums = [2,2,1]
# Output: 1

# Example 2:

# Input: nums = [4,1,2,1,2]
# Output: 4

# Example 3:

# Input: nums = [1]
# Output: 1

# Constraints:

#     1 <= nums.length <= 3 * 104
#     -3 * 104 <= nums[i] <= 3 * 104
#     Each element in the array appears twice except for one element which appears only once.

def single_number(nums)
  # naive implemetation using Ruby tally cheat - super fast, but a bit more memory used
  # Runtime: 94 ms
  # Memory Usage: 212.9 MB
  nums.tally.find { |_k, v| v == 1 }.first

  # proper implementation (Note: you can use `Set` instead of array)
  # LeetCode runtime: 2136 ms
  # Memory Usage: 212.6 MB
  uniq_stack = []
  nums.each do |num|
    if uniq_stack.include?(num)
      uniq_stack.delete(num)
    else
      uniq_stack << num
    end
  end
  uniq_stack.first

  # similar to above, but using 'Set'
  # LeetCode Runtime: 81 ms
  # Memory Usage: 214.1 MB
  s = Set.new
  nums.each do |n|
    if s.include?(n)
      s.delete(n)
    else
      s << n
    end
  end
  s.first

  # using XOR - fasted / least memory
  # Runtime: 97 ms
  # Memory Usage: 212.5 MB
  nums.reduce(:^)
end

RSpec.describe 'Solution' do
  let(:input_one) { [2,2,1] }
  let(:input_two) { [4,1,2,1,2] }
  it 'return uniq number' do
    expect(single_number(input_one)).to eq 1
    expect(single_number(input_two)).to eq 4
  end
end
