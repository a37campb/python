/* 
Name: Adam Campbell (a37campb)
20649284
Assignment 9 Problem 2
Last Modified: November 27, 2020
*/

#include <discpp.h>
#include <iostream>
#include <cmath>
#include <string>
#include <complex.h>
using namespace std;

class diffuse{
    private:
        double D, x0, xf, t0, dt;
        double (*fun)(double);
        void draw(double x[], double y[], int run, const char* x_label, const char* y_label, const char* typ){
            double minX, maxX, minY, maxY,stepX, stepY;
            Dislin g;
            g.metafl("PNG");
            g.disini();
            g.name(x_label,"x");
            g.name(y_label,"y");
            g.labels(typ,"xy");
            g.setscl(x,run,"x");
            g.setscl(y,run,"y");
            g.incmrk(-1);
            g.marker(21);
            g.hsymbl(20);
            g.graf(minX, maxX, minX, stepX, minY,maxY, minY, stepY);
            g.curve(x,y,run);
            g.endgrf();
            g.disfin();
        }
        void init_matrix(double*** mat, int dim[2]){
            /*
            Assigns an initial value to every matrix that is dynamically allocated.
            */
            for (int i=0; i<dim[0]; i++){
                for (int j=0; j<dim[1]; j++){
                    (*mat)[i][j] = 0;
                }
            }
        }
        double** mat_memory(int dim[2]){
            /*
            Sets up the dynamic memory with the correct dimensions.
            */
            double** mat = new double* [dim[0]];
            for (int i=-1;++i<dim[0];){
                mat[i] = new double [dim[1]];
            }
            init_matrix(&mat, dim); //initialize function to add zeros into new matrix from mat_memory
            return mat;
        }
        void cleanup(double** mat, int dim[2]){
            /*
            Cleaning up the matrix of matrices
            */
            for (int k=0;k<dim[0];k++){
                delete [] mat[k];
            }
            delete [] mat;
        }
    public: 
        void showPartDiff(int dim[] ,const char* tpt){
            double final_temp[dim[0]], dist[dim[0]], final_temp_time[dim[1]], time[dim[1]];
            double dx = (xf - x0)/dim[0];
            double** temp = mat_memory(dim);
            for (int j = 0; j < dim[1]; j++) {
                // no change to x0 and xf in t
                for (int i = 0; i < dim[0]; i++) {
                    if (j == 0) {
                        temp[i][j] = fun(x0 + i*dx);
                    } else if ((i == 0) || (i == (dim[0] - 1))) {
                        //same value using the last boundary
                        temp[i][j] = temp[i][j-1];
                        // D*dt/(pow(dx,2)) * (temp[i+1][j-1] - 2*temp[i][j-1] + temp[dim[0]-1][j-1] ) + temp[i][j-1];
                    } else {
                        // calculating the inner square of the array -- no modifications needed to the diff algorithm
                        temp[i][j] = D*dt/(pow(dx,2)) * (temp[i+1][j-1] - 2*temp[i][j-1] + temp[i-1][j-1] ) + temp[i][j-1];
                    }
                }
                time[j] = t0 + j*dt;
                final_temp_time[j] = temp[dim[0] - 1][j];
            }
            for (int i = 0; i < dim[0]; i++){
                dist[i] = x0 + i*dx;
                final_temp[i] = temp[i][dim[1] - 1];
            }
            cleanup(temp, dim);
            draw(dist, final_temp, dim[0], "Distance Measurement", tpt, "FLOAT");
            draw(time, final_temp_time, dim[1], "Time Measurement", tpt, "FLOAT");
            printf("first final temp %f\tLast final temp %f\n", final_temp[0], final_temp[dim[0]-1]);
            printf("first pos %f\tLast pos %f\t PI %f \n", dist[0], dist[dim[0]-1], xf);
            printf("first time %f\tLast time %f\n", time[0], time[dim[1]-1]);
        }
        diffuse(double d, double inix, double finx, double init, double iDt, double func(double)){
            fun = func;
            D = d;
            x0 = inix;
            xf = finx;
            t0 = init;
            dt = iDt;
        }
};
double initT(double aX){
    return 10*sin(aX);
}
int main(){
    int tgrid = 10001, xgrid1 = 101, xgrid2 = 10000;
    int dim1[2] = {xgrid1,tgrid}, dim2[2] = {xgrid2,tgrid};
    //cmath defines the constant M_PI
    double intx = 0, finx = M_PI, intt = 0, dt = 0.01, D = 0.02;
    diffuse df(D, intx, finx, intt, dt, initT );
    df.showPartDiff(dim1, "Final Temperature at with 100 Grid Points");
    // df.showPartDiff(dim2, "Final Temperature with 10,000 Grid Points");
    return 0;
}
