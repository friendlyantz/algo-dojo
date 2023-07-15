# 110. Balanced Binary Tree

# Given a binary tree, determine if it is
# height-balanced

# Example 1:

# Input: root = [3,9,20,null,null,15,7]
# Output: true

# Example 2:

# Input: root = [1,2,2,3,3,null,null,4,4]
# Output: false

# Example 3:

# Input: root = []
# Output: true

# Constraints:

#     The number of nodes in the tree is in the range [0, 5000].
#     -104 <= Node.val <= 104

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


from typing import Optional
import pdb
import unittest

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        # LEETSTATS:
        # Runtime Details 65ms Beats 67.91%of users with Python3
        # Memory Details 20.97mb Beats 97.22%of users with Python3k
        # Guard clause for empty root
        if root is None:
            return True

        def depth(node):
            # PRE
            if node == None:
                return 0
            parent_depth = 1
            
            # RECURSION
            l_depth = depth(node.left) # returns int or False
            r_depth = depth(node.right) # returns int or False

            # print(f"node.val: {node.val}, l_depth: {l_depth}, r_depth: {r_depth}")

            # POST
            # circuit breakers
            # ========================
            # ======== NOTE!!!!!! ====
            # ========================
            # in Python, 0 is Falsy and is 0 == False is True
            # so we need to check for False explicitly:
            if (l_depth is False) or (r_depth is False):
                return False
            if abs(l_depth - r_depth) > 1:
                return False

            return max(l_depth, r_depth) + parent_depth

        if depth(root):
            return True
        else:
            return False

    # below solution is from LEET example, I wasn't ablew to solve as per above
    # def isBalanced(self, root):
    #     if root == None:
    #         return True
    #     l = self.depth(root.left)
    #     r = self.depth(root.right)
        return (abs(l-r) <2) and self.isBalanced(root.left) and self.isBalanced(root.right)
    
    # def depth(self,node):
    #     if node == None: return 0
    #     return max(self.depth(node.left),self.depth(node.right))+1

class TestSolution(unittest.TestCase):
    def test_isBalanced(self):
        # Example 1
        root1 = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        self.assertEqual(Solution().isBalanced(root1), True)

        # Example 2
        root2 = TreeNode(1, TreeNode(2, TreeNode(3, TreeNode(4), TreeNode(4)), TreeNode(3)), TreeNode(2))
        self.assertEqual(Solution().isBalanced(root2), False)

        # Single node
        root3 = TreeNode(1)
        self.assertEqual(Solution().isBalanced(root3), True)

        # Empty tree
        root4 = None
        self.assertEqual(Solution().isBalanced(root4), True)

        # Unbalanced tree
        root5 = TreeNode(1, TreeNode(2, TreeNode(3, TreeNode(4), TreeNode(4)), None), None)
        self.assertEqual(Solution().isBalanced(root5), False)

if __name__ == '__main__':
    unittest.main()