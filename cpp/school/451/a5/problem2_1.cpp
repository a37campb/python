#include <iostream>
using namespace std;

int *myFunction(int *aI, int *aJ) {
    *aI = *aI*(*aJ);
    return aI;
}

int main() {
    int *aI;
    int *aJ;
    *aI = 2;
    *aJ = 3;
    cout << (*myFunction(aI, aJ)) << endl;
}