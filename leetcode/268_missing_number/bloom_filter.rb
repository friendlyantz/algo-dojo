# BLOOM FILTER SOLUTION for https://leetcode.com/problems/missing-number/description/
# https://en.wikipedia.org/wiki/Bloom_filter
#
# Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.
#
# Example 1:
# Input: nums = [3,0,1]
# Output: 2
# Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
#
# Example 2:
# Input: nums = [0,1]
# Output: 2
# Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
#
# Example 3:
# Input: nums = [9,6,4,2,3,5,7,0,1]
# Output: 8
# Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.

require 'digest'
require 'bitset'

class Solution
  BIT_ARRAY_SIZE = 1024
  NUM_HASHES = 4

  def initialize
    @bit_array = Bitset.new(BIT_ARRAY_SIZE)
  end
  
  def generate_hashes_for(element)
    Array
      .new(NUM_HASHES)
      .map do |i|
         Digest::SHA256.hexdigest("#{element}#{i}")
      end
  end
    
  def add_element(element)
    generate_hashes_for(element)
      .each do |h|
        index = h.to_i(16) % BIT_ARRAY_SIZE
        @bit_array.set(index)
      end
  end
  
  def query_element(element)
    generate_hashes_for(element)
      .all? do |h|
        index = h.to_i(16) % BIT_ARRAY_SIZE
        @bit_array[index]
      end
  end
  
  def missing_number(nums)
    nums.each { add_element(_1) }
  
    nums.size.times do |i|
      return i unless query_element(i)
    end
  end
end

RSpec.describe "Missing number" do
  it 'returns 2 for [3,0,1]' do
    nums = [3,0,1]
    expect(Solution.new.missing_number(nums)).to eq 2
  end

  it 'returns 2 for [0,1]' do
    nums = [0,1]
    expect(Solution.new.missing_number(nums)).to eq 2
  end

  it 'returns 8 for nums = [9,6,4,2,3,5,7,0,1]' do
    nums = [9,6,4,2,3,5,7,0,1]
    expect(Solution.new.missing_number(nums)).to eq 8
  end
end
