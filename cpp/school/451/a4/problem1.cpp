/*
Adam Campbell (a37campb)
20649284
Assignment 4, Problem 1
Written: October 19, 2020
*/

//#include <discpp.h>
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;


double root2(double value, int N, int i){ 
    /*
    This is where the recursion is done. 
    The recursion criteria is that the gloabl variable i, is less than the inputted integer N. 
    The recursion follows the continued fraction (shown in assignment question1).
    When the recursion is finished, we return the final value (continued fraction N times). 
    i is the counter variable, pushed into the function so the function can be called multiple times with different starting and ending values in the same file. 
    */
    if (i <= N-1){
        i += 1;
        value = 1/(2 + value);
        return root2(value,N, i);
    } else{
        return (value + 1);
    }
}

int main(){
    double rep_val = 0; 
    //Starting with a really bad guess yields and acceptable aproximation for sqrt(2)
    int end = 10;
    int start = 0;
    for (int j = 1; j <= end; j++){
        cout << setprecision(15);
        cout << "The value of sqrt(2) for " << j << " continued fractions = " << root2(rep_val, j, start) << endl;
    }
}