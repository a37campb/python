/*
Adam Campbell (a37campb)
20649284
Assignment 7, Problem 4
Last Modified: November 16, 2020
*/

#include <discpp.h>
#include <iostream>
#include <cmath>
using namespace std;

double funx(double aD, int n){
    return pow(aD,n);
}

class newtonsMethod{
    private:
        double (*fun)(double, int);
        double iDx;
        int iter;        
        double der(double aX, int n){
            /*
            First order derivative from previous assignment
            */
            return ( (*fun)(aX + iDx, n) - (*fun)(aX - iDx, n))/(2*iDx);
        }
        void setcount(int count=1){
            iter = count;
        }
    public:
        void setDx(double new_val){
            iDx = new_val;
        }
        double getDx(){
            return iDx;
        }
        double newton(double xi, double err, int n){
            /*
            Calculates the newton's method approximation
            */
            double xni = xi - (*fun)(xi, n)/der(xi, n);
            // printf("bingo \n");
            if (iter > 1e10){
                printf("Process diverged, pick a better guess. \n Number of runs required is greater than %f", 1e10);
                exit(-1);
            } else if (fabs(xni - xi) < err){
                return xi;
            } else {
                iter++;
                return newton(xni, err, n);
            }
        }
        void draw(double x[], double y[], const int run, const char* x_label, const char* y_label, const char* typ){
            double minX, maxX, minY, maxY,stepX, stepY;
            Dislin g;
            g.metafl("PNG");
            g.disini();
            g.name(x_label,"x");
            g.name(y_label,"y");
            g.labels(typ,"xy");
            g.incmrk(1);
            g.setscl(x,run,"x");
            g.setscl(y,run,"y");
            g.graf(minX, maxX, minX, stepX, minY,maxY, minY, stepY);
            g.curve(x,y,run);
            g.disfin();
        }
        newtonsMethod(double aDx, double aF(double, int)): iDx(aDx){
            fun = aF;
            iDx = aDx;
            setcount();
        }
};

int main(){
    double err = 1e-4, del = 1e-1, ini_x = 0.1;
    const int len = 33;
    int n = 3;
    double log_newtx[len], logdx_x[len];
    newtonsMethod NX(del ,funx);
    for (int i = 0; i < len; i++){
        logdx_x[i] = log10(NX.getDx());
        log_newtx[i] = log10(NX.newton(ini_x, err, n));
        NX.setDx(NX.getDx()/pow(10, 0.5));
    }
    NX.draw(logdx_x, log_newtx, len, "Log10 dx Value for the Derivative of x**3","Log10 of Newton`s Method of x**3", "LOG");
    return 0;
}
