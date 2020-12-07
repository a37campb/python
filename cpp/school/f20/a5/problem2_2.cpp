#include <iostream>
using namespace std;

void function(int *aI, int *aJ) {
    *aJ = 20;
    aI = aJ;
}

int main () {
    int j = 10;
    int k = 15;
    function(&j, &k);
    cout << j << '\t' << k << endl;
}