from typing import List

class Solution():

    def __init__(self, nums: List=NotImplemented):
        self.nums = nums
        return None

    def singleInArray(self,nums: List[int]) -> int:
        for i in set(nums):
            if nums.count(i) == 1:
                return i

    def duplicatesInArray(self,nums: List[int]) -> List[int]:
        u = dict()
        ans = []
        for i in nums: 
            if i not in u:
                u[i] = 1
            else:
                u[i] += 1
                if u[i] == 2:
                    ans.append(i)
        return ans

    def phoneLetters(self, num: str) -> List[str]:
        tele = {'2':'abc','3':'def','4':'ghi','5':'jkl','6':'mno','7':'pqrs','8':'tuv','9':'wxyz','0':' '}
        ans = []
        if len(num) == 0:
            return ans
        elif len(num) == 1:
            return list(tele[num[0]])
        prev = self.phoneLetters(num[:-1])
        last = tele[num[-1]]
        for s in prev:
            for c in last:
                ans.append(s+c)
        return ans
    
    def firstMissingPositive(self,nums: List[int]) -> int:
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
    
    def twoSum(self, l: List[int],c:int) -> List[tuple]:
        ans = []
        u = {}
        for i in l:
            if c-i in u:
                ans.append((i,c-i))
            else:
                u[i] = 1
        return ans

    def removeDuplicates(self, nums: List[int]) -> int:
        '''
        if len(nums) >= 2:
            for i in range(len(nums)):
                if i <= len(nums)-2:
                    if nums[i] == nums[i+1]:
                        nums.pop(i)
        return len(nums)
        '''
        return len(set(nums))

    def removeElement(self, nums: List[int],val:int) -> int:
        if len(nums) > 0:
            for i in nums: 
                if i == val:
                    nums.remove(i)
        return len(nums)

    def multiplyString(self, num1:str, num2:str) -> str:
        u = {'0':0,'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9}
        num1_int = 0
        num2_int = 0
        #if len(num1) > 1:
        for i in range(len(num1)):
            num1_int += u[num1[i]]*10**(len(num1)-1-i)
        for j in range(len(num2)):
            num2_int += u[num2[j]]*10**(len(num2)-1-j)
        return str(num1_int*num2_int)

    def powerOfN(self,num:int,N:int)->bool:
        if num==0:
            return False
        while(num%N==0):
            num = num/N
        if num==1:
            return True
        return False

    def matrix2DSearch(self,m: List[List[int]],target:int) -> bool:
        for i in m:
            if i == []:
                continue
            if i[0] <= target <= i[-1]:
                if target == i[0]:
                    return True
                elif target == i[-1]:
                    return True
                for j in i:
                    if j < target:
                        continue
                    elif j == target:
                        return True
                    else:
                        break
        return False

    def pick(self,target:int) -> int:
        from random import choice as c
        nums = self.nums
        u = dict()
        for i in range(len(nums)): 
            if nums[i] in u:
                u[nums[i]] += (i,)
            else:
                u[nums[i]] = (i,)
        return c(u[target])

    def fizzBuzz(self,n:int) -> List[str]:
        ans = []
        for i in range(1,n+1):
            if i%3 == 0 and i%5 == 0:
                ans.append('FizzBuzz')
            elif i%3 == 0:
                ans.append('Fizz')
            elif i%5 == 0:
                ans.append('Buzz')
            else:
                ans.append(str(i))
        return ans

    def thirdMax(self,nums: List[int]) -> int:
        ans = (-2**32,-2**32,-2**32)
        #tuple -> max,second,third
        if len(nums) >= 3:
            for i in nums:
                if i not in ans:
                    if i > ans[0]:
                        ans = (i,ans[0],ans[1])
                    elif ans[0] > i > ans[1]:
                        ans = (ans[0],i,ans[1])
                    elif ans[1] > i > ans[2]:
                        ans = (ans[0],ans[1],i)
            return ans[-1]
        return max(nums)

    def addStrings(self,num1:str,num2:str) -> str:
        num1_s,num2_s = 0,0
        u = {'0':0,'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9}
        for i in range(len(num1)):
            num1_s += u[num1[i]]*10**(len(num1)-1-i)
        for j in range(len(num2)):
            num2_s += u[num2[j]]*10**(len(num2)-1 -j)
        return str(num2_s+num1_s)

    def hammingDist(self,n1:int,n2:int) -> int:
        n1_b = bin(n1)[2:]
        n2_b = bin(n2)[2:]
        ans = 0
        diff = abs(len(n2_b)-len(n1_b))
        if len(n2_b) > len(n1_b):
            n1_b = '0'*diff + n1_b
        elif len(n1_b) > len(n2_b):
            n2_b = '0'*diff + n2_b
        for i in range(len(n1_b)):
            if n1_b[i] != n2_b[i]:
                ans += 1
        return ans

    def totalHammingDist(self, nums:List[int]) -> int:
        summa = 0
        for i in range(len(nums)):
             for j in range(i+1,len(nums)):
                summa += self.hammingDist(nums[i],nums[j])   
        return summa

    def uniqueEmail(self,emails:List[str]) -> int:
        uniques = set()
        for mail in emails:
            local,domain = mail.split('@')
            local = local.split('+')[0]
            local = local.replace('.','')
            email = local + '@' + domain
            uniques.add(email)
        return(len(uniques))


    def firstUniqChar(self, s: str) -> int:
        u = {}
        for i in range(len(s)):
            if s[i] not in u:
                u[s[i]] = (1,(i,))
            else:
                count = u[s[i]][0] + 1
                index = u[s[i]][1] + (i,)
                u[s[i]] = (count,index)
        idx = []
        for t in u:
            if u[t][0] == 1:
                idx += [u[t][1][0]]
        if len(idx) != 0:
            return min(idx)
        return -1

    def smallestRepunitDivByK(self, K: int) -> tuple:
        if K % 2 ==0 or K % 5==0:
            return -1    
        digits = 1
        N = 1
        t = False
        while t == False:
            if N % K == 0:
                t = True
                return (digits,N)
            else:
                N = N*10+1
                digits += 1

    def maxConsecutiveOnes(self, nums:List[int]) -> int:
        counter = 0
        maxval = 0
        for i in range(len(nums)): 
            if nums[i] == 1:
                counter += 1
                if i == len(nums) - 1:
                    maxval = max(maxval,counter)
            elif nums[i] == 0:
                maxval = max(maxval,counter)
                counter = 0
        return maxval

    def perfectNum(self, num: int) -> bool:
        su = -num
        for i in range(1,num+1):
            if num % i == 0:
                su += i
        return su == num


#print(Solution().perfectNum(15))
#print(Solution().maxConsecutiveOnes([1,0,0,0,0,0,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1]))
#print(Solution().smallestRepunitDivByK(101))
#print(Solution().firstUniqChar('ddddddccccbbbaaa'))

#b= [9750610,4935630,2783689,8304436,1228041,468907,2407229,690244,7924850,6969637,5777986,2886944,4701083,5064310,7278914,476585,8121952,4177503,1679127,8899966,5096718,5944837,2825672,6429070,4908074,2233532,4378058,9165985,8074002,6146564,7765913,299460,9646103,6748483,1869980,8394979,4982441,7108209,96943,8112888,9457344,5518798,3191786,20950,9848250,5971110,3617628,2923790,7315207,4560814,8116096,7695733,1595022,5516788,5608585,2162982,6490431,5163845,3107522,7689925,8575679,9714226,1996143,1028474,7452076,8303449,13600,5447801,6954898,3556792,6638028,9685932,1040619,6686958,3867105,1650592,5283356,1605788,6279662,4009842,3665858,9022579,5456118,68140,6084000,927391,4047274,5901150,7709264,6122605,156669,707926,6481646,8550658,8331259,1568246,775980,537156,9207971,617036,5124752,4424117,6316353,7436700,6856241,3950796,3649516,8423917,8227739,8459344,9878416,8907492,243245,2245332,5354101,7164469,6513783,2538773,3852850,4188117,814513,1198042,6140872,6377804,3921677,3391463,8111351,4830850,1690300,9189199,6549631,3388755,6322461,658456,199669,902056,2533243,5185227,3436687,663274,4154373,6950351,1456896,7961844,7382592,7892843,6678944,688319,8640597,5826006,3040037,3334688,9741950,6610456,5841839,734445,2537324,9745729,337864,1298752,2328751,7714100,8212079,8161389,1881295,7864494,8186635,907393,18000,7625888,6504242,2566498,7568525,4558078,9887723,5713553,8007512,6574270,6364980,6009446,2907557,9373309,6381332,9966263,2540752,9021458,4461694,1980770,914217,3930613,3655480,7317910,9820578,2277207,6911271,6242492,7432543,486274,7454264,8938721,9872070,5963005,4755181,4944640,3942827,8506420,1403126,5469298,3245733,7316977,642915,6316172,7373211,5890864,894241,5598715,8264360,3902045,2948504,6575180,9719328,7882547,5418516,440370,9321605,6139893,2746751,466048,968416,6974516,7124095,849878,6265308,1249652,7195695,2765012,1530651,9604526,9522802,6675245,7968605,2573677,256644,5274569,4882322,5402534,6549720,1418065,6627984,4981954,5075623,1017860,3962690,7367084,2136020,4624875,2802855,3066862,1022597,5257270,232275,941764,8606842,7759833,1226320,6002683,2064816,6649184,9473443,8827047,3382931,7964537,3775291,8000561,3947235,6576343,9052114,3251995,6547078,8877328,2744764,5116538,4080552,8850049,8388368,6071587,9218899,2511219,4646795,6279716,5923509,4763267,755398,3304994,798003,5654494,9343368,2475234,7284101,249760,232673,5418996,5854287,1290936,9836039,9091231,4020837,489489,1014813,7774984,8373799,48737,3139893,8361722,1178376,6302121,179498,1065506,7558033,770102,7760943,7286824,1558846,8624225,9915914,862645,4518297,8037946,6124507,9254137,9001153,676958,7696270,2574382,2670179,5720667,6703511,8179353,8181953,8278798,7858020,981273,985003,9307134,9642819,6103562,7245501,1592452,8688976,1968614,9951727,3380534,5129338,2890420,5594370,398258,8935976,1782854,1201099,3488758,5741658,505337,3601237,3197633,6033079,4656655,1432136,1697413,6492969,1971987,7069248,6350439,1054259,5153835,2671477,4376287,9140587,5454684,2546835,7610638,3526915,206223,1405979,9955404,6783029,790802,3498087,4306874,8183032,9573417,6706306,9783098,519957,5121155,4671028,1182236,9755273,7460895,4403072,9836484,7913301,100771,7687062,3447547,7917849,5670008,4759544,5968735,3013292,7251540,53170,9415789,997936,4199910,959486,7238851,1979679,7387248,4879945,1500095,3059525,1601413,7265837,1472049,6576536,2892932,2836777,3284560,7287100,8792844,1739422,979274,9906411,5174589,2657353,1724774,7782895,128111,9818175,7463830,525305,976126,7943639,7610026,3545430,2777229,5869660,2915457,6054363,5764443,8734008,2759659,5210581,9040963,4877495,8032078,324031,8807521,4963227,8332735,6331180,3811089,9838835,5702539,5920238,9729393,4345113,1474703,371492,3110927,751805,3572687,3785293,5462910,5350484,2860591,3786659,6727472,327280,5276821,2945441,2850918,127546,3665622,4963235,7214880,5421062,8804836,1088743,7245024,9026246,8307231,371362,4954882,2062987,7205690,7635309,6004656,2492671,529048,4449327,4737399,7899477,434982,1314309,465827,3146291,4257285,2756489,9109391,6243400,5897363,9312112,6423733,8231891,1401874,1773491,4355312,7180610,4071104,3126735,4757040,3884007,4593306,528872,2360294,3840167,3011404,4300080,4560874,7003206,490323,6330608,6455885,5801534,2075999,5210663,1717894,3052201,3316413,6578692,9389025,4244610,6904764,3628833,3355804,6409027,7220572,1177150,3055027,6737684,7548187,8020736,1820347,5985861,194730,917307,5908441,4935458,2183752,5311620,635234,3327582,6586942,77441,758553,5857123,3504855,9399605,6351736,6317203,5312274,5767257,8837927,6865868,8788540,6377070,1508674,1322089,5376263,8646845,1874698,9202917,9217636,3179802,4653662,5970720,696720,965404,6228721,7235657,7429122,1950971,2387270,7225799,3348872,6008880,9514751,4524202,1344613,8609509,3713302,1221107,3838525,1215888,795170,3277241,8858401,5417030,5114323,4868827,227692,7855752,8357928,4694241,4743194,3511598,2422559,2021822,2478337,4931153,5066595,3087643,1968685,3038600,2556650,8814410,7022184,5515348,9452504,7897384,4693331,4730000,689017,5655307,7328992,7678908,601691,304538,793627,8856552,4601088,7031880,2978841,4678674,8773113,7525239,2547455,1283736,3846614,769066,9661180,8851113,9293792,8078004,1331066,7551459,5778063,1966881,6015728,6244710,6097622,7581478,3083950,6187699,7915993,6720637,521104,1192472,8722503,3289147,4594564,984367,2084395,1682324,419991,6584018,9116862,9731385,2295011,3255165,1811736,1597650,1107452,4191809,7661446,4815259,8307160,7238043,1482824,234760,3669050,3662633,3904559,8925768,6887575,3922488,2042915,1244987,9174352,1293437,3901012,3035805,6666087,3652808,4714452,7542891,704664,8160480,5214331,7991902,9972132,9229282,257079,2585614,5047758,3548073,311550,2596511,101192,2290654,2531688,1738500,6521776,8129435,6433573,3782328,6271420,2417326,4588945,7844591,1599802,968115,2617299,2507884,3528029,5892466,934723,4025688,9074135,8979232,2464466,1464390,2233681,5583544,780741,5318305,8610319,3342305,5639559,6116621,5554716,2576546,7267814,805465,29772,5828737,5993843,4225093,5079166,734618,8648999,5177311,4927763,8992331,9900982,3106833,7011368,4341882,4576020,4034183,4581956,3540334,288623,6776735,6213409,9673118,134344,7048361,495410,9996927,5134046,5865353,6759044,5156306,9866062,8237059,6657294,8724324,430429,1450884,9343869,2849542,5263116,4501330,9056219,1375731,1135779,6954275,6980054,2582772,1694441,4251698,3528158,9494168,2049986,3507351,7760253,6819194,2431067,8693798,539813,9575104,9562536,1020318,7992673,9115219,6789862,8532698,7165250,1807806,5039717,6372320,9066179,5093183,5019580,6844759,2497065,2562095,542280,7325238,219699,3257200,3846225,2964853,5992734,9266398,8659156,8525474,5842126,458166,2740510,29936,2095796,1054510,1449504,6761255,7216695,9085633,3522627,9436564,3323227,5423123,3964465,9794775,3887362,6659258,1124474,1058918,7702516,7290703,8874509,1822653,5000756,42281,8709212,1937976,2941749,6036452,9055799,9597967,2231800,2289756,859069,5410823,138030,862320,6109911,2993501,2579558,7632545,5779196,6032435,7557413,8105341,2951781,2385876,9291772,9806331,8401722,3198175,4668517,3912438,3255676,3820180,937472,8592508,619207,4084904,9261757,8504092,2490185,8916403,391486,3269594,7661093,9537632,551235,3315123,4242418,4262242,8787165,6901267,4304133,7747066,1156420,9578496,4494768,2112087,6888013,3742130,4311435,9356559,5091816,3601121,4712286,3139376,8250635,7391925,8690795,1230059,5286899,4494143,5241534,7755522,1977655,3460524,8526910,8847778,2724293,1364840,7967631,7637258,6301075,3087311,4922695,8960789,7042232,4416085,667285,2176048,6304448,725234,3178780,1765974,7589583,5366464,5026075,3273868,4166589,9546286,8073877,1801268,1767951,817022,3185517,3651778,6701552,7240908,6811879,3549194,9932800,5183801,9988059,9995324,9198514,6910215,9363299,8935596,159216,4293710,6157329,7350313,5897844,3276770,9292702,3008884,7104505,5157905,2068077,7990298,3104348,880242,835676,4242871,4224857,4488583,5855946,4334062,4183836]
#print(Solution().totalHammingDist(b))
#print(Solution().addStrings('10','21'))
#print(Solution().thirdMax([2,2,3,1,10,12,12,30,4,5,6,8]))
#print(Solution().fizzBuzz(125))
#obj = Solution([1,2,3,1,2,3,5,6,3,2,1,4,6,3,2,1,9,5,4,3])
#print(obj.pick(1))

"""
a = [
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
"""
#print(Solution().matrix2DSearch(a,13))
#print(Solution().powerOfN(16,4))
#print(Solution().multiplyString('10','1'))
#print(Solution().removeElement([1],3))
#print(Solution().removeDuplicates([1,1,2,2,4,5,5,6,7,8,10,11]))
#print(Solution().phoneLetters('239'))
#print(Solution().singleInArray([1,1,2,2,3,3,4,4,6,6,7,7,8,8,9]))
#print(Solution().duplicatesInArray([4,3,2,7,8,2,3,1]))
#print(Solution().firstMissingPositive([0,1,2,3,-1,-10,-2,4,5,6,7,8,9,11]))
#print(Solution().twoSum([3,3,5,5,5],8))