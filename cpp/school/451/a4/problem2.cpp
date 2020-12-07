/*
Adam Campbell (a37campb)
20649284
Assignment 4, Problem 2
Written: October 19, 2020
*/

#include <dislin.h>
#include <iostream>
#include <cmath>
using namespace std;

const double R = 0.082;

class Gas{
    public:
        double iA;
        double iB;
        Gas(double aA, double aB){
            iA = aA;
            iB = aB;
        }
};

class VanDerWaalsCalculator{
    public:
        Gas iGas;
        float iVolume[100];
        float iPressure[100];
        float iTemperature;
        float iNumberOfMoles;
        int numPoints;
        
        VanDerWaalsCalculator(Gas aGas, double aMinimumVolume, double aMaximumVolume, double aTemperature, double aNumberOfMoles, int aNumberOfPoints) :iGas(aGas){
                iTemperature = aTemperature;
                iNumberOfMoles = aNumberOfMoles;
                iVolume[0] = aMinimumVolume;
                numPoints = aNumberOfPoints;
                double stepVol = (aMaximumVolume - aMinimumVolume) / numPoints;
                for (int i = 1; i <= numPoints; i++){
                    iVolume[i] = iVolume[i-1] + stepVol;  
                }
            }

// Use the Van der Waals formula to generate the pressure
// vector

    void generatePressure(){
        for (int j = 0; j <= numPoints; j++){
            iPressure[j] = (iNumberOfMoles * R * iTemperature)/(iVolume[j] - iGas.iB *  iNumberOfMoles) - (iGas.iA * pow(iNumberOfMoles,2))/( pow(iVolume[j],2));
        }
    }

// Graph the pressure as a function of volume.
    void draw(){
        metafl("PDF");
        disini();

        name("Pressure of the System [Pa]", "Y"); 
        // x and y axis labels
        name("Volume of the System [m^3]", "X");
        titlin("Graph Showing Pressure vs Volume for the System",2);
        qplot(iVolume, iPressure ,numPoints);
       disfin();
        
        // plotting routine
        // exits DISLIN
    }
};

int main() {
    Gas Oxygen(0.027, 0.0014);
    int numberOfPoints = 100;
    float minimumVolume = 1;
    float maximumVolume = 10;
    float temperature = 300;
    float numberOfMoles = 1;
    VanDerWaalsCalculator VDW(Oxygen, minimumVolume, maximumVolume, temperature, numberOfMoles, numberOfPoints);
    VDW.generatePressure();
    VDW.draw();
}