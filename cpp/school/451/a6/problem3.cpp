/*
Adam Campbell (a37campb)
20649284
Assignment 6, Problem 3
Written: November 2, 2020
*/

#include <discpp.h>
#include <iostream>
#include <cmath>
#include <string>
using namespace std;

double func_n(double aD,int n){
    /*
    Finds the value of x**n
    */
    return pow(aD,n);
}

class DerivativeCalculator{
    private:
        double (*iF)(double,int);
        double iDx;
    public:
        void setDx(double aDx){
            iDx = aDx;
        }

        double dx(){
            return iDx;
        }
    
        double deriv_cust(double aX, int n){
            double num, denom;
            num = 3*(*iF)(aX + 2*iDx,n) + 6*(*iF)(aX + iDx,n) - 2*(*iF)(aX + 3*iDx,n) - 7*(*iF)(aX,n);
            denom = 6*iDx;
            return (num/denom);
        }
        
        void draw(double x[], double y[], int n){
            int x_size = *(&x + 1) - x; //mem of end of array - mem of start of array = size
            int y_size = *(&y + 1) - y; //mem of end of array - mem of start of array = size
            double minX = 0, maxX = 10, minY = 0, maxY = 10 ,stepX = (maxX - minX)/x_size, stepY = (maxY - minY)/y_size;
            // double minX, maxX, minY, maxY ,stepX, stepY;
            Dislin g;
            g.metafl("PNG");
            g.disini();
            if (n == 1){
                g.name("Log of Absolute Error of Derivative","y");
                g.name("Log of Step Length","x");
                g.labels("EXP","xy");
            } else if (n == 2){
                g.name("Absolute Error of Derivative","y");
                g.name("Step Length Squared","x");
                g.labels("EXP","xy");
            }
            g.incmrk(1);
            g.setscl(x,10,"x");
            g.setscl(y,10,"y");
            g.graf(minX, maxX, minX, stepX, minY,maxY, minY, stepY);
            g.curve(x,y,10);
            g.disfin();
        }

        DerivativeCalculator(double aDx, double aF(double,int)): iDx(aDx){
            iF = aF;
            iDx = aDx;
        }
};

int main(){
    double del = 1.e-1;
    DerivativeCalculator DC1(del,func_n);
    double x_val = 1.0;
    int n = 6; //Power to raise x, in function call. 
    double error[10], log_error[10], log_dx[10], dx_pow2[10];
    for (int i = 0; i < 10; i++){
        log_error[i] = log10(abs(DC1.deriv_cust(x_val, n) - n)/3);
        error[i] = abs(DC1.deriv_cust(x_val, n) - n)/3;
        log_dx[i] = log10(DC1.dx());
        dx_pow2[i] = pow(DC1.dx(),2);
        DC1.setDx( DC1.dx()/1.3);
    }
    DC1.draw(dx_pow2, error, 2);
    DC1.draw(log_dx, log_error, 1);
    return 0;
}