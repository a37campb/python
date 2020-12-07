/*
Adam Campbell (a37campb)
20649284
Assignment 5, Problem 1
Written: October 31, 2020
*/

#include <iostream>
#include <fstream>
#include <string>
using namespace std;

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
    for (int i=-1; ++i<dim[0];){
        mat[i] = new double [dim[1]];
    }
    init_matrix(&mat, dim); //initialize function to zeros into mat_memory
    return mat;
}

double** matrix_form(ifstream* file, int dim[2]){
    /*
    Reads the information from the file, and applies it to a structure created in mat_memory
    */
    double** mat = mat_memory(dim);
    for (int i=0;i<dim[0];i++){
        for (int j=0;j<dim[1];j++){
    //  deepcode ignore MissingOpenCheckOnFile: <check completed after filename in main>
            *file >> mat[i][j];
        }
    }
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

void show(double** mat, int dim[2]){
    /*
    Printing to the terminal, the result.
    */
    for (int i=0; i < dim[0]; i++){
        for (int j=0; j < dim[1]; j++){
            if (j == dim[1] -1){
                cout << mat[i][j] << endl;
            } else {
                cout << mat[i][j] << "\t";
            }
        }
    }
}

double** multiply(double** mat1, double** mat2, int dim_out[2],int dim1[2]){
    /*
    Matrix multiplication from the slides.
    */
    double** out = mat_memory(dim_out);
    for (int i = 0; i < dim_out[0]; i++){
        for (int j = 0; j < dim_out[1]; j++){
            for (int k=0; k < dim1[1]; k++){
                out[i][j] += mat1[i][k] * mat2[j][k];
            }
        }
    }
    return out;
}

void switch_dim(int dim[2]){
    /*
    Helper function to switch the dimensions of the array.
    */
    int temp = dim[0];
    dim[0] = dim[1];
    dim[1] = temp;
}

int square_check(int dim[2]){
    /*
    Checks if the matrx is square.
    */
    if (dim[0] == dim[1]){
        return 1;
    }
    return 0;
}

double** transpose(double** mat, int dim[2]){
    /*
    Create temp matrix, transposes the matrix the regular way, then trash the temp matrix. 
    */
   int temp[2] = {dim[0],dim[1]};
   if (square_check(dim) == 0){
       switch_dim(temp); //swaps the dimensions if the maxtrix is not squaure.
   }
    double** out = mat_memory(temp); 
    for (int i = 0; i < dim[0]; i++){
        for (int j = 0; j < dim[1]; j++){
            out[j][i] = mat[i][j];
        }
    }
    return out;
}

int main(){
    string fname = "da2";
    ifstream filename(fname);
    //  deepcode ignore MissingOpenCheckOnFile: <check completed after filename in main>
    if (!filename) {
        cout << "Error Opening File" << endl;
        exit(-1);
    }
    int dim_mA1[2], dim_mA2[2]; //Defining the dimentions
    filename >> dim_mA1[0] >> dim_mA1[1];
    double** mA1 = matrix_form(&filename, dim_mA1);
    filename >> dim_mA2[0] >> dim_mA2[1];
    double** mA2 = matrix_form(&filename, dim_mA2);
    filename.close();
    int dim_out[2] = {dim_mA1[0], dim_mA2[1]}; //from matrix math, new mat size = R1xC2
    if (dim_mA1[1] == dim_mA2[0]){
        mA2 = transpose(mA2, dim_mA2);
        double** mO = multiply(mA1,mA2, dim_out, dim_mA1);
        show(mO, dim_out);
        cleanup(mA1, dim_mA1);
        cleanup(mA2, dim_mA2);
        cleanup(mO, dim_out);
        return 0;
    } else {
        cout << "Matrix dimensions do not agree, please use agreeing matrix sizes." << endl;
        cleanup(mA1, dim_mA1);
        cleanup(mA2, dim_mA2);
        return 0;
    }
}