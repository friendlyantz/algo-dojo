# You are given the heads of two sorted linked lists list1 and list2.
#
# Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
#
# Return the head of the merged linked list.
#
# Input: list1 = [1,2,4], list2 = [1,3,4]
# Output: [1,1,2,3,4,4]
#
# Example 2:
#
# Input: list1 = [], list2 = []
# Output: []
#
# Example 3:
#
# Input: list1 = [], list2 = [0]
# Output: [0]
#
#  
#
# Constraints:
#
#     The number of nodes in both lists is in the range [0, 50].
#     -100 <= Node.val <= 100
#     Both list1 and list2 are sorted in non-decreasing order.
#

import unittest
import ipdb
from typing import Optional

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        pass

class TestSolution(unittest.TestCase):
    def test_mergeTwoLists(self):
        # Test case 1
        list1 = ListNode(1, ListNode(2, ListNode(4)))
        list2 = ListNode(1, ListNode(3, ListNode(4)))
        expected_output = ListNode(1, ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(4))))))
        s = Solution()
        self.assertEqual(s.mergeTwoLists(list1, list2).__dict__, expected_output.__dict__)

        # Test case 2
        list1 = None
        list2 = None
        expected_output = None
        s = Solution()
        self.assertEqual(s.mergeTwoLists(list1, list2), expected_output)

        # Test case 3
        list1 = None
        list2 = ListNode(0)
        expected_output = ListNode(0)
        s = Solution()
        self.assertEqual(s.mergeTwoLists(list1, list2).__dict__, expected_output.__dict__)

if __name__ == '__main__':
    unittest.main()