import unittest
from typing import List

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # Runtime316 ms Beats 42.6% Memory17.2 MB Beats 77.35%
        size = len(nums)
        for i in range(size):
            tail = nums.pop()
            for j in nums:
                if tail + j == target:
                    return [nums.index(j), size - 1- i]


s = Solution()
result = s.twoSum([2,7,11,15], 9)
print(result)
# class TestSolution(unittest.TestCase):
#     # todo
# if __name__ == '__main__':
#     unittest.main()
