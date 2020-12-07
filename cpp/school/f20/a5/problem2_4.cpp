#include <iostream>
using namespace std;

int *myFunction() {
    int *aV = new int [3];
    for (int loop = 0; loop < 3; loop ++) aV[loop] = loop;
    return aV;
}

int main() {
    int *v;
    v = myFunction();
    cout << v[1] << endl;
}