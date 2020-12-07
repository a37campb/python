#include <iostream>
using namespace std;

class B {
    public:
        int x;
        virtual void print() {cout << x << endl;}
};

class D : public B {
    public: 
        void print(int i) {cout << 3*i<< endl;}
};

class E : public B {
    public:
        void print() {cout << 2*x << endl;}
};

int main(){
    D D1;
    D* D2 = &D1;
    D2 ->x = 2;
    D2 -> print(2);
    E* E1 = (E*) D2;
    E1->print();
} 
