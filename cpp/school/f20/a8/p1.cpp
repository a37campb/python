/*
Adam Campbell (a37campb)
20649284
Assignment 8, Problem 1
Written: November 19, 2020
*/

#include <iostream>
#include <cmath>
#include <string>
#include <complex.h>
using namespace std;

const int N = 3;

void back_sub(complex<double> aA[][N], complex<double> aB[N], complex<double> aC[N]){
    for (int i = N - 1; i >= 0; i--){
        aC[i] = aB[i];
        for (int j = i+1; j < N; j++){
            aC[i] -= aA[i][j] *aC[j];
        }
        aC[i] /= aA[i][i];
    }
}

void gauss( complex<double> aA[][N], complex<double> aB[N], complex<double> aC[N]){
    for (int i=0;i<N;i++){
        if (aA[i][i] == complex<double>(0.0,0.0)){
            exit(-1);
        }
        for (int j = i + 1; j < N; j++){
            complex<double> d = aA[j][i] / aA[i][i];
            for (int k = i + 1;k < N;k++){
                aA[j][k] -= d*aA[i][k];
            }
            aB[j] -= d*aB[i];
        }
    }
}

void show(complex<double> mat[]){
    /*
    Printing to the terminal, the result.
    */
    for (int j=0; j < N; j++){
        if (j == N -1){
            cout << mat[j] << endl;
        } else {
            cout << mat[j] << "\n";
        }
    }
}

int main(){
    const int dim = 3;
    const complex<double> ji(0.0,1.0), uni(1.0, 0.0);
    complex<double> A[dim][dim] = {{uni, 0, ji}, {-ji,uni,-ji}, {-uni, 0, ji}}, B[dim] = {ji, 0, -ji}, C[dim];
    gauss(A, B, C);
    back_sub(A, B, C);
    show(C);
    return 0;
}
