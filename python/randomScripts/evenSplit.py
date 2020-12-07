s = 'RLLLLRRRRLRL'
r_count =0
l_count=0
ans = 0
for i in s:
    if i == 'R':
        r_count +=1
    elif i == 'L': 
        l_count +=1
    if l_count == r_count:
        r_count = 0
        l_count = 0
        ans+=1
print(ans)