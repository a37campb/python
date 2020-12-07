#include <iostream>
using namespace std;

class Base {
    public:
        void print() {cout << " Base Class "<<endl;}
};

class Derived: public Base {
    public:
        void print() { cout << " Derived Class " << endl;}
};

int main(){
    Derived D1;
    Base* B1 = &D1;
    B1 ->print();
}
