import random

class queue:
    def __init__(self):
        self.queue =[]

    def size(self):
        return len(self.queue)

    def isEmpty(self):
        return self.size() == 0

    def putInQueue(self,val):
        self.queue.insert(0,val)

    def removeFromQueue(self):
        if self.isEmpty != True:
            return (self.queue.pop())
        return None



a = 'hello'
a.count('l')
a.index('l')
        