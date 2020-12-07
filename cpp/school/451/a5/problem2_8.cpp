#include <iostream>
using namespace std;

int main() {
    int** m = new int*[2];
    m[0] = new int [3];
    m[1] = new int [2];
    for (int i = 0; i < 3; i++) m[0][i] = i;
    for (int i = 0; i < 2; i++) m[1][i] = i+3;
    cout << (*m)[1];
}