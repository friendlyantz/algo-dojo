import unittest
from typing import List


class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # naive O(n^2)
        # Runtime316 ms Beats 42.6% Memory17.2 MB Beats 77.35%
        # size = len(nums)
        # for i in range(size):
        #     tail = nums.pop()
        #     for j in nums:
        #         if tail + j == target:
        #             return [nums.index(j), size - 1- i]

        # using HashMap O(n) for Time and Space
        # Runtime76 ms Beats 70.2% Memory17.7 MB Beats 35.80%
        hash_map = {}
        for i, arg_one in enumerate(nums):
            arg_two = target - arg_one
            if arg_two in hash_map:
                return [hash_map[arg_two], i]
            hash_map[arg_one] = i


s = Solution()
result = s.twoSum([2, 7, 11, 15], 9)
print(result)
