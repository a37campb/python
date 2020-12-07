class Stack:
    def __init__(self):
        self.stack = []
    
    def size(self):
        return len(self.stack)

    def is_empty(self):
        return self.size() == 0

    def pop(self):
        if self.is_empty() != True:
            self.stack.pop()
        return None

    def insert(self,val):
        self.stack.append(val)

    def peak(self):
        if not self.is_empty():
            return self.stack[-1]
        return None
