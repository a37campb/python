

#include <discpp.h>
#include <iostream>
#include <cmath>
#include <string>
using namespace std;

class IntCalculator{
    private:
        double (*fun)(double, int);
    public:
        IntCalculator(double func(double, int)){
            fun = func;
        }
        double simping(double rVal, double lVal, int len, double n){
            /*
            Simpson's Rule calculation given the R, L, number of steps and the power of the function. 
            */
            double dx = (rVal-lVal)/len, y=0;
            for (int i = 0; i < len; i++){
                y += (*fun)(lVal + i*dx, n) + 4*(*fun)(((lVal+i*dx) + (lVal + (i+1)*dx))/2,n) + (*fun)(lVal+(i+1)*dx, n);
            }
            // lVal + i*dx is equiv to x[i]
            // lVal + (i+1)*dx is equiv to x[i+1]
            return (dx*y/6);
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
};
double fx(double val, int n){
    return pow(val, n);
}

int main(){
    int exp = 10, step;
    const int runs = 10;
    double R = 2.0, L = 0.0, expect = (pow(R,exp+1) - pow(L,exp+1))/(exp+1);
    IntCalculator IC(fx);
    double log_dx[runs], log_err[runs];
    for (int i = 0;i < runs; i++){
        step = exp*(i+1);
        log_err[i] = log10(fabs(IC.simping(R, L, step, exp) - expect));
        log_dx[i] = log10((R-L)/step);
    }
    IC.draw(log_dx,log_err, runs, "Log10 of the Change in dx Value","Log10 of Error in Simpson's Rule", "LOG");
    double x2 = log_dx[runs-1], x1 = log_dx[0], y2 = log_err[runs-1], y1 = log_err[0], slope = (y2-y1)/(x2-x1);
    printf("The degree of the error is %.15f, therefore the approximate order of the error is %.1f .\n", slope, round(slope));
    return 0;
}
