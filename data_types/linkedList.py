#Singly Linked list -> move in one direction
class node():
    def __init__(self,val1:int=None, val2:int=None):
        #Need a pointer and a value for a node
        self.val = val1 #Value
        self.next = val2 #Pointer


n1 = node(4)
n2=node(3)
n3 = node(2)
n4 = node(1)
n1.next = n2
n2.next = n3
n3.next = n4

a = n2.next
a = None
b = [1,2]
c = [1,2,3]
c.append(b)
print(b)
print(c)
print('---------')
b[0] = 2
print(c)
#print(a)
#print(n3)

#One right Below is someone else's implementation of a linked list
class nodeOperations(object):

    def __init__(self, data=None, next_node=None):
        self.data = data
        self.next_node = next_node

    def get_data(self):
        return self.data

    def get_next(self):
        return self.next_node

    def set_next(self, new_next):
        self.next_node = new_next

    def insert(self, data):
        new_node = nodeOperations(data)
        new_node.set_next(self.head)
        self.head = new_node

    def size(self):
        current = self.head
        count = 0
        while current:
            count += 1
            current = current.get_next()
        return count

    def search(self, data):
        current = self.head
        found = False
        while current and found is False:
            if current.get_data() == data:
                found = True
            else:
                current = current.get_next()
        if current is None:
            raise ValueError("Data not in list")
        return current

    def delete(self, data):
        current = self.head
        previous = None
        found = False
        while current and found is False:
            if current.get_data() == data:
                found = True
            else:
                previous = current
                current = current.get_next()
        if current is None:
            raise ValueError("Data not in list")
        if previous is None:
            self.head = current.get_next()
        else:
            previous.set_next(current.get_next())