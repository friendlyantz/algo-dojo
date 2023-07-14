import unittest
from typing import List

class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        # TODO this is too simple just to get max value on ONE trade
        return True
        
    def multiTrade(self, prices: List[int]) -> int:
        # not this problem
        profits = []
        trade_buffer = 0
        for a, b in zip(prices, prices[1:]):
            if a < b:
                trade_buffer += (b - a)
            elif a > b:
                profits.append(trade_buffer)
                trade_buffer = 0
        profits.append(trade_buffer)
        return sum(profits)

        

class TestSolution(unittest.TestCase):
    def test_maxProfit(self):
        s = Solution()

        # # Test case 1
        # prices = [7, 1, 5, 3, 6, 4]
        # expected_output = 5
        # self.assertEqual(s.maxProfit(prices), expected_output)

        # Test case 1 multi trade
        prices = [7, 1, 5, 3, 6, 4]
        expected_output = 7
        self.assertEqual(s.multiTrade(prices), expected_output)

        # Test case 2
        # prices = [7, 6, 4, 3, 1]
        # expected_output = 0
        # self.assertEqual(s.maxProfit(prices), expected_output)

        # # Test case 3
        # prices = [1, 2, 3, 4, 5]
        # expected_output = 4
        # self.assertEqual(s.maxProfit(prices), expected_output)

        # Test case 4
        # prices = [5, 4, 3, 2, 1]
        # expected_output = 0
        # self.assertEqual(s.maxProfit(prices), expected_output)

if __name__ == '__main__':
    unittest.main()
