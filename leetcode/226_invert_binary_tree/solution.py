# Given the root of a binary tree, invert the tree, and return its root.

# Example 1:

# Input: root = [4,2,7,1,3,6,9]
# Output: [4,7,2,9,6,3,1]

# Example 2:

# Input: root = [2,1,3]
# Output: [2,3,1]

# Example 3:

# Input: root = []
# Output: []

# Constraints:

#     The number of nodes in the tree is in the range [0, 100].
#     -100 <= Node.val <= 100

import unittest
from typing import Optional

class TreeNode:
   def __init__(self, val=0, left=None, right=None):
       self.val = val
       self.left = left
       self.right = right

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        return True
        

class TestSolution(unittest.TestCase):
    def test_invertTree_example1(self):
        # Input: root = [4,2,7,1,3,6,9]
        # Output: [4,7,2,9,6,3,1]
        root = TreeNode(4, TreeNode(2, TreeNode(1), TreeNode(3)), TreeNode(7, TreeNode(6), TreeNode(9)))
        expected = TreeNode(4, TreeNode(7, TreeNode(9), TreeNode(6)), TreeNode(2, TreeNode(3), TreeNode(1)))
        solution = Solution()
        self.assertEqual(solution.invertTree(root), expected)

    def test_invertTree_example2(self):
        # Input: root = [2,1,3]
        # Output: [2,3,1]
        root = TreeNode(2, TreeNode(1), TreeNode(3))
        expected = TreeNode(2, TreeNode(3), TreeNode(1))
        solution = Solution()
        self.assertEqual(solution.invertTree(root), expected)

    def test_invertTree_example3(self):
        # Input: root = []
        # Output: []
        root = None
        expected = None
        solution = Solution()
        self.assertEqual(solution.invertTree(root), expected)

if __name__ == '__main__':
    unittest.main()