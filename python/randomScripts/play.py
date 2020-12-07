class Solution(object):
    def hammingWeight(self, n):
        """
        :type n: int
        :rtype: int
        """
        ans=0
        for i in str(n):
            if i == '1':
                ans+=1
        return ans
