# 206. Reverse Linked List

# Given the head of a singly linked list, reverse the list, and return the reversed list.

# Example 1:

# Input: head = [1,2,3,4,5]
# Output: [5,4,3,2,1]

# Example 2:

# Input: head = [1,2]
# Output: [2,1]

# Example 3:

# Input: head = []
# Output: []

# Constraints:

#     The number of nodes in the list is the range [0, 5000].
#     -5000 <= Node.val <= 5000

# Follow up: A linked list can be reversed either iteratively or recursively. Could you implement both?

import unittest

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
import pdb

class Solution:
    def reverseList(self, head: ListNode, tail=None) -> ListNode:
        # Runtime O(n) # Details # 46ms # Beats 87.44%of users with Python3 
        # Memory O(1) # Details # 17.71mb # Beats 98.35%of users with Python3

        # if head is None:
        #     return None

        # # # initial assignment
        # current_pointer = head
        # next_pointer = head.next
        # current_pointer.next = None

        # while next_pointer is not None:
        #     # Buffer the next next pointer
        #     next_next_pointer = next_pointer.next

        #     # Reverse the pointer direction
        #     next_pointer.next = current_pointer

        #     # Move the pointers forward
        #     current_pointer = next_pointer
        #     next_pointer = next_next_pointer
        # return current_pointer
        
        # -----
        # recursive implementation 
        # -----
        # Runtime 46ms Beats 87.44%of users with Python3
        # Memory Details 17.71mb Beats 98.35%of users with Python3
        def reverse_helper(current_head, new_head):
            # PRE RECURSE - check before winding the stack
            if current_head is None: # None, 5
                # POST RECURSE - stack unwinding
                return new_head

            # RECURSE STAGE, I.E.[2, 3, 4, 5]
            next_head = current_head.next # 3 | 4 | 5 | None
            current_head.next = new_head # 2 -> None | 3 -> 2 | 4 -> 3 | 5 -> 4
            return reverse_helper(next_head, current_head) # 3, 2 | 4, 3 | 5, 4 | None, 5

        return reverse_helper(head, None)
        