
def firstMissingPositive(nums):
    if nums == []:
        return 1
    lmt = max(nums)
    count = 0
    for _ in range(0,lmt+1):
        count += 1
        if count in nums:
            continue
        else:
            return count

print(firstMissingPositive([0,1,2,3,-1,-10,-2,4,5,6,7,8,9,11]))


# file deepcode ignore R1710: <ignore linter for return statements>