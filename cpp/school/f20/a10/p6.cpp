#include <iostream>
using namespace std;

class C{
    public:
        virtual void print() = 0;
        int i;
};

class D : public C{
    public:
        int i;
        void print("in D");
};

class E : public C{
    public:
        void print() {cout << "in E";}
};

int main() {
    D D1;
    E E1;
    C C[3] = {D1, E1};
    C[1].print();
}
