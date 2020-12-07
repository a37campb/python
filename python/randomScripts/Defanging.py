class Solution:
    def defangIPaddr(self, address: str) -> str:
        ans =''
        for val in address:
            if val != ".":
                ans+=val
            if val == ".":
                ans+="[.]"
            return ans

new = "1.1.1.1"
test = Solution()
print(test.defangIPaddr(new))