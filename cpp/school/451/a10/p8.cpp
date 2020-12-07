#include <iostream>
using namespace std;

class MyClass {
    public:
        static int iP;
        MyClass(int aX){iX = aX;iP++;}
        int iX;
};

int MyClass::iP = 3;

int main(){
    MyClass::iP = 0;
    MyClass M1(2);
    MyClass M2(M1);
    cout << M1.iP << endl;
}
