/*Demonstrates the DISLIN plotting program */
#include <iostream>
#include "dislin.h"
 

// Includes the DISLIN plotting routines
 
using namespace std;

float f( float aX) 
{
    // Function to be graphed
    return aX*aX;
}

int main()
{

    //double x[11], y[11];	// IF YOU ARE USING THE S.P. DISLIN LIBRARY
    // SUBSTITUTE THE FOLLOWING LINE
    float x[11], y[11];	// 11 element arrays to hold the x-y pairs to be plotted

    float del = 0.1;	// Spacing between x values
    for (int loop = 0; loop < 11; loop++ )
    {	// Fill the x and y arrays, starting from x=0
        x[loop] = loop * del;
        y[loop] = f(x[loop]);
    }
    

    //metafl("XWIN");
    //Other choices – metafl("TIFF"); 
    //metafl("POST");
    metafl("PDF");
    disini();

    name("X-axis","x"); // Initializes the output device – here the terminal

    // use to open and print plot in MS-Paint
    // use to create a postscript plot file
    // use to open and print plot in Adobe Acrobat
    // Initializes the plotting package

    // x and y axis labels
    name("Y-axis","y");
    
    qplsca(x,y,11);
    disfin();
    
    // plotting routine
    // exits DISLIN
}
