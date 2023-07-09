# frozen_string_literal: true

# Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.

# Example 1:

# Input: nums1 = [1,2,2,1], nums2 = [2,2]
# Output: [2,2]

# Example 2:

# Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
# Output: [4,9]
# Explanation: [9,4] is also accepted.

# Constraints:

#     1 <= nums1.length, nums2.length <= 1000
#     0 <= nums1[i], nums2[i] <= 1000

# Follow up:

#     What if the given array is already sorted? How would you optimize your algorithm?
#     What if nums1's size is small compared to nums2's size? Which algorithm is better?
#     What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?

def intersect(nums1, nums2)
  # FASTEST SOLUTION, but WORST MEMORY USAGE
  # I think it is a bit cheeky and defeats the purpose of this exercise
  # Runtime: 64 ms 100% faster than anyone out there
  # Memory Usage: 211.5 MB lowest 5% of submissions
  short_hash, long_hash = [nums1.tally, nums2.tally].sort_by(&:size)
  short_hash.each_with_object([]) do |(key, value), result|
    next unless long_hash[key]

    result << Array.new([value, long_hash[key]].min, key)
  end.flatten

  # SLOW, but GOOD MEMORY USAGE
  # Runtime: 121 ms - beats 10% of submissions
  # Memory Usage: 211.1 MB - beats 80% of submissions
  nums1.each_with_object([]) do |num, result|
  nums1, nums2 = [nums1, nums2].sort_by(&:size)
    next unless nums2.include?(num)

    nums2.delete_at(nums2.index(num))
    result << num
  end
end

RSpec.describe 'Solution' do
  let(:input_one) { [2, 2, 1] }
  let(:input_two) { [4, 1, 2, 1, 2] }
  it 'return intersections' do
    nums1 = [1, 2, 2, 1]
    nums2 = [2, 2]
    expect(intersect(nums1, nums2)).to eq [2, 2]
    nums1 = [4, 9, 5]
    nums2 = [9, 4, 9, 8, 4]
    expect(intersect(nums1, nums2)).to eq [4, 9]
  end
end
