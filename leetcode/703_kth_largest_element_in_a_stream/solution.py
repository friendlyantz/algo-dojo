# Design a class to find the kth largest element in a stream. Note that it is the kth largest element in the sorted order, not the kth distinct element.

# Implement KthLargest class:

#     KthLargest(int k, int[] nums) Initializes the object with the integer k and the stream of integers nums.
#     int add(int val) Appends the integer val to the stream and returns the element representing the kth largest element in the stream.

# Example 1:

# Input
# ["KthLargest", "add", "add", "add", "add", "add"]
# [[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]
# Output
# [null, 4, 5, 5, 8, 8]

# Explanation
# KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
# kthLargest.add(3);   // return 4
# kthLargest.add(5);   // return 5
# kthLargest.add(10);  // return 5
# kthLargest.add(9);   // return 8
# kthLargest.add(4);   // return 8

# Constraints:

#     1 <= k <= 104
#     0 <= nums.length <= 104
#     -104 <= nums[i] <= 104
#     -104 <= val <= 104
#     At most 104 calls will be made to add.
#     It is guaranteed that there will be at least k elements in the array when you search for the kth element.

from typing import List
import unittest

class LinkNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

import pdb

import heapq

class KthLargest:
    # LEETCODE STATS:
    # Runtime 106ms Beats 70.65%of users with Python3
    # UNSTABLE / narrow band Memory Details 20.41mb Beats 47.03%of users with Python3
    def __init__(self, k: int, nums: List[int]) -> None:
        self.heap = []
        self.k = k
        for e in nums:
            heapq.heappush(self.heap, e)
        while len(self.heap) > k:
            heapq.heappop(self.heap)

    def add(self, val: int) -> int:
        if not self.heap or len(self.heap) < self.k:
            heapq.heappush(self.heap, val)
        elif val > self.heap[0]:
            heapq.heappushpop(self.heap,val)
            
        return self.heap[0]

class KthLargestTest(unittest.TestCase):
    def test_kth_largest(self):
        kthLargest = KthLargest(3, [4, 5, 8, 2])
        self.assertEqual(kthLargest.add(3), 4)
        self.assertEqual(kthLargest.add(5), 5)
        self.assertEqual(kthLargest.add(10), 5)
        self.assertEqual(kthLargest.add(9), 8)
        self.assertEqual(kthLargest.add(4), 8)

    def test_kth_largest_empty(self):
        kthLargest = KthLargest(3, [])
        self.assertEqual(kthLargest.add(3), 3)
        self.assertEqual(kthLargest.add(5), 3)
        self.assertEqual(kthLargest.add(10), 3)
        self.assertEqual(kthLargest.add(9), 5)
        self.assertEqual(kthLargest.add(4), 5)

    def test_kth_largest_single(self):
        kthLargest = KthLargest(1, [4])
        self.assertEqual(kthLargest.add(3), 4)
        self.assertEqual(kthLargest.add(5), 5)
        self.assertEqual(kthLargest.add(10), 10)
        self.assertEqual(kthLargest.add(9), 10)
        self.assertEqual(kthLargest.add(4), 10)

if __name__ == '__main__':
    unittest.main()
