#include <iostream>
using namespace std;

static int b=3;

int myFun(int &i){
    static int b;
    b+=i;
    return(b);
}

int main(){
    int n =2;
    myFun(n);
    cout << myFun(n);
}

