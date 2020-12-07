class FreqStack:

    def __init__(self):
        self.stack = []
        self.dict = {}
        
    def push(self, x: int) -> None:
        if x not in self.dict:
            self.dict[x] = (1,[len(self.stack)])
        else:
            self.dict[x] = (self.dict[x][0]+1,self.dict[x][1]+[len(self.stack)])
        self.stack += [x]

    def pop(self) -> int:
        maxFreq = 0
        idx = 0
        val = 0
        for i in self.dict:
            temp = self.dict[i]
            if temp[0] >= maxFreq and temp[1][-1] > idx:
                idx = temp[1][-1]
                maxFreq  = temp[0]
                val = i
        pulled = self.dict[val][1].pop(-1)
        self.dict[val][0] -= 1

        return self.stack.pop(idx)

#["FreqStack","push","push","push","push","push","push","pop","pop","pop","pop"]
xx = [5,7,5,7,4,5]
y = [[],[],[],[]]
obj = FreqStack()
for ii in xx:
    obj.push(ii)
for _ in y:
    obj.pop()

print(obj)