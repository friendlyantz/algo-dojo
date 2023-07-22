# Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
#
# Implement the MinStack class:
#
#     MinStack() initializes the stack object.
#     void push(int val) pushes the element val onto the stack.
#     void pop() removes the element on the top of the stack.
#     int top() gets the top element of the stack.
#     int getMin() retrieves the minimum element in the stack.
#
# You must implement a solution with O(1) time complexity for each function.
#
# Example 1:
#
# Input
# ["MinStack","push","push","push","getMin","pop","top","getMin"]
# [[],[-2],[0],[-3],[],[],[],[]]
#
# Output
# [null,null,null,null,-3,null,0,-2]
#
# Explanation
# MinStack minStack = new MinStack();
# minStack.push(-2);
# minStack.push(0);
# minStack.push(-3);
# minStack.getMin(); // return -3
# minStack.pop();
# minStack.top();    // return 0
# minStack.getMin(); // return -2
#
# Constraints:
#
#     -231 <= val <= 231 - 1
#     Methods pop, top and getMin operations will always be called on non-empty stacks.
#     At most 3 * 104 calls will be made to push, pop, top, and getMin.
#
import unittest
import ipdb

class StackNode:
    def __init__ (self, val, next=None, min=None):
        self.val = val
        self.next = next
        self.min = min

class MinStack:
    def __init__(self):
       self.head = None

    def push(self, val: int) -> None:
        new_node = StackNode(val, self.head)
        ipdb.set_trace()
        if not self.head or val < self.head.min:
            new_node.min = val
        else:
            new_node.min = self.head.min
        self.head = new_node

    def pop(self) -> None:
        self.head = self.head.next

    def top(self) -> int:
        return self.head.val

    def getMin(self) -> int:
        return self.head.min

# obj = MinStack()
# obj.push(val)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()


class TestMinStack(unittest.TestCase):
    def test_min_stack(self):
        min_stack = MinStack()
        min_stack.push(-2)
        min_stack.push(0)
        min_stack.push(-3)
        self.assertEqual(min_stack.getMin(), -3)
        min_stack.pop()
        self.assertEqual(min_stack.top(), 0)
        self.assertEqual(min_stack.getMin(), -2)
        
if __name__ == '__main__':
    unittest.main()
