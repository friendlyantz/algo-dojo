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

def TreeNode(val=0, left=None, right=None):
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


from typing import Optional
import pdb
import unittest

class Solution:
    # def isBalanced(self, root: Optional[TreeNode]) -> bool:
    #     print(f"node.val: #{root}")
    #     def depth(node):
    #         #PRE
    #         if node == None:
    #             return 0
    #         #REC
    #         print(f"node.val: {node.val}, l_depth: {l_depth}, r_depth: {r_depth}")
    #         l_depth = depth(node.left) # returns int or False
    #         r_depth = depth(node.right) # returns int or False

    #         #POST
    #         # circuit breakers
    #         print(f"node.val: {node.val}, l_depth: {l_depth}, r_depth: {r_depth}")
    #         if (l_depth == False) or (r_depth == False):
    #             return False


    #         if abs(l_depth - r_depth) > 1:
    #             return False
    #         return max(l_depth, r_depth)

    #     result = depth(root)
    #     if result:
    #         return True
    #     else:
    #         return False

    # below solution is from LEET example, I wasn't ablew to solve as per above
    def isBalanced(self, root):
        """
        :type root: TreeNode
        :rtype: bool
        """ 
        if root == None:
            return True
        l = self.depth(root.left)
        r = self.depth(root.right)
        return (abs(l-r) <2) and self.isBalanced(root.left) and self.isBalanced(root.right)
    
    def depth(self,node):
        if node == None: return 0
        return max(self.depth(node.left),self.depth(node.right))+1


root1 = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
Solution().isBalanced(root1) 
