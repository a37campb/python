#include <iostream>
using namespace std;

class myClass {
    public:
        int i; 
        myClass& square() {i=i*i; return *this;}
};

int main(){
    myClass myClass1;
    myClass1.i = 4;
    cout << myClass1.square().square().i;
}