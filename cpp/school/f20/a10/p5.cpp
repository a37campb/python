#include <iostream>
using namespace std;

template <class T> T myMin(T a, T b){
    return a < b ? a : b;   // ? : means if then else
}

class C {
    public:
        double iC;
        operator int () const {return iC;};
};

int main(){
    C C1, C2;
    C1.iC = 3.0;
    C2.iC = 6.0;
    cout << min(C2, C1) << endl;
}
