/*
Adam Campbell (a37campb)
20649284
Assignment 6, Problem 1
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
    
        double deriv_4(double aX, int n){
            return ( (*iF)(aX-2*iDx,n)-8*(*iF)(aX - iDx,n) + 8*(*iF)(aX+iDx,n) - (*iF)(aX+2*iDx,n) )/(12*iDx);
        }
        
        void draw(double x[], double y[], int n){

            int x_size = *(&x + 1) - x, y_size = *(&y + 1) - y;
            double minX = 0, maxX = 1, minY = 0, maxY = 10 ,stepX = (maxX - minX)/x_size, stepY = (maxY - minY)/y_size;
            Dislin g;
            g.metafl("PNG");
            g.disini();
            if (n == 0){
                g.name("Log of Error in 4th Order Derivative","y");
                g.name("Log of Step Length","x");
                g.labels("LOG","xy");
            } else if (n == 1){
                g.name("4th Order Derivative","y");
                g.name("Step Length Cubed","x");
                g.labels("EXP","xy");
            } else if ( n == 2){
                g.name("4th Order Derivative","y");
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
    double log_dx[10], dx_pow3[10], dx_pow4[10], y_4th[10], error_4th[10];
    for (int i = 0; i < 10; i++){
        y_4th[i] = DC1.deriv_4(x_val, n);
        error_4th[i] = log10(abs(y_4th[i] - n));
        log_dx[i] = log10(DC1.dx());
        dx_pow3[i] = pow(DC1.dx(),3);
        dx_pow4[i] = pow(DC1.dx(),4);
        DC1.setDx( DC1.dx()/1.3);
    }
    DC1.draw(dx_pow3, y_4th, 1); //y' vs dx^3
    DC1.draw(dx_pow4, y_4th, 2); //y' vs dx^4
    DC1.draw(log_dx, error_4th, 0); //log(y' - 6) vs log(dx) 
    return 0;
}