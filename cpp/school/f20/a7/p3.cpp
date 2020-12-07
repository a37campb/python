/*
Adam Campbell (a37campb)
20649284
Assignment 7, Problem 3
Last Modified: November 16, 2020
*/

#include <discpp.h>
#include <iostream>
#include <cmath>
using namespace std;

double funx(double aD){
    return aD*pow(fabs(aD),0.5);
}

double sinx(double aD){
    return sin(aD);
}

class newtonsMethod{
    private:
        double (*fun)(double);
        double iDx;
        int iter;        
        double der(double aX){
            /*
            First order derivative from previous assignment
            */
            return ( (*fun)(aX + iDx) - (*fun)(aX - iDx))/(2*iDx);
        }
    public:
        void setDx(double new_val){
            iDx = new_val;
        }
        double getDx(){
            return iDx;
        }
        void setcount(int count=1){
            iter = count;
        }
        int newtonCnt(double xi, double err){
            /*
            Calculates the newton's method approximation
            */
            double xni = xi - fun(xi)/der(xi);
            if (iter > 1e10){
                printf("Process diverged, pick a better guess. \n Number of runs required is greater than %f", 1e10);
                exit(-1);
            } else if (fabs(xni - xi) < err){
                return iter;
            } else {
                iter++;
                return newtonCnt(xni, err);
            }                
        }
        void draw(double x[], double y[], int run, const char* x_label, const char* y_label, const char* typ){
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
        newtonsMethod(double aDx, double aF(double)): iDx(aDx){
            fun = aF;
            iDx = aDx;
            setcount();
        }
};

int main(){
    double err = 1e-4, del = 1e-1, ini_x = 0.1;
    const int len = 10;
    double iterx[len], iters[len], dx_x[len], dx_s[len];
    newtonsMethod NX(del ,funx);
    newtonsMethod NS(del, sinx);
    for (int i = 0; i < len; i++){
        dx_x[i] = NX.getDx();
        iterx[i] = NX.newtonCnt(ini_x, err);
        dx_s[i] = NS.getDx();
        iters[i] = NS.newtonCnt(ini_x, err);
        NX.setDx(NX.getDx()/1.3);
        NS.setDx(NS.getDx()/1.3);
        NX.setcount();
        NS.setcount();
    }
    NX.draw(dx_x, iterx, len, "dx Value for the Derivative of x**3/2","Iterations of Newton`s Method of x**3/2", "LOG");
    NS.draw(dx_s, iters, len, "dx Value for the Derivative of Sin(x)","Iterations of Newton`s Method of Sin(x)", "LOG");
    return 0;
}
