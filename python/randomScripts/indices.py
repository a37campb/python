#output the indicies of the tuples that sum to some number,c, form a list,l.

def twoSum(l,c):
    ans = []
    u = {}
    for i in l:
        if c-i in u:
            ans.append((i,c-i))
        else:
            u[i] = 1
    return ans

            
print(twoSum([3,3,5,5,5],8))
