//	Gravitational field of a point earth. Illustrates simple 3-dimensional
//	plotting routines.

#include <iostream>
#include "dislin.h"

using namespace std;

const float KM = 1000;	// Note this procedure!
//	An alternate naming
//	convention capitalizes
//	all global constants

const float GRAVITATIONALCONSTANT = 6.67e-11; 
const float EARTHMASS = 5.97e24;

const float EARTHRADIUS = 6380 * KM;
 
const int MATSIZE = 20;	// This MUST be declared a const int
//	to be used in the subsequent
//	type statements!

float gravitationalField(float aX, float aY) 
{
    return GRAVITATIONALCONSTANT * EARTHMASS / (aX * aX + aY * aY);
} 

int main ( ) 
{
    float position[MATSIZE];
    float field[MATSIZE][MATSIZE];

    float offset = MATSIZE / 2 - 0.5;
    // x and y coordinate positions
    // the gravitational field CHANGE TO

    // FLOAT FOR S.P. DISLIN LIBARY

    // Determines the starting point of the
    
    grid;
    
    for (int loop = 0; loop < MATSIZE; loop++) 
    {
        position[loop] = 0.1 * EARTHRADIUS * (loop - offset);
    }
    float x, y;
    for (int outerLoop = 0; outerLoop < MATSIZE; outerLoop++)
    {
         x = position[outerLoop];

        for (int innerLoop = 0; innerLoop < MATSIZE; innerLoop++) 
        {
            y = position[innerLoop];
            field[outerLoop][innerLoop] = gravitationalField(x,y);
        }
    }

    metafl("PDF");
    disini();	// required for 3-dimensional plots
    int iPlot = 1;	// set to 1 for surface plot, 2 for color plot anything else gives contour
    if (iPlot == 1)	// surface plot

    //	The conversion function (explicit cast) float* below (which returns the first
    //	memory location occupied by the matrix) is required by dislin.
    //	REPLACE ALL (double*) BELOW by (float*) ONLY IF YOU ARE USING THE
    //	SINGLE PRECISION DISLIN LIBRARY

    qplsur((float*) field, MATSIZE, MATSIZE);
    else if (iPlot == 2)	// color plot

    qplclr((float*) field, MATSIZE, MATSIZE);
    else 
    {	// contour plot
        int numberOfContours = 30;
        qplcon((float*) field, MATSIZE, MATSIZE, numberOfContours);
    }  
}

// file deepcode ignore CppSameEvalBinaryExpressiontrue: <dislin causing a deepcode problem>
