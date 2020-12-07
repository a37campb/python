
#include <discpp.h>
#include <iostream>
#include <cmath>
using namespace std;

class Semiconductor{
    private:
        double iElectronDensity, iHoleDensity, iIntrinsicCarrierDensity;
    public:
        Semiconductor(double intrinsicCarrierDensity){
            iIntrinsicCarrierDensity = intrinsicCarrierDensity;
            //Setting the constructor for the class (init for the class)
        }
        double electronDensity(){
            return iElectronDensity;
            //Getter for the electron density
        }
        void setElectronDensity( double aElectronDensity){
            iElectronDensity = aElectronDensity;
            iHoleDensity = (pow(iIntrinsicCarrierDensity,2)/iElectronDensity);
            //Changing the value based on the input from the user
        }
        double holeDensity(){
            return iHoleDensity;
            //getter for the hole density
        }
        void setHoleDensity(double aHoleDensity){
            iHoleDensity = aHoleDensity;
            iElectronDensity = (pow(iIntrinsicCarrierDensity,2)/iHoleDensity);
            //Changing the value based on the input from the user
        }
        double intrinsicCarrierDensity(){
            return iIntrinsicCarrierDensity;
            //read only
        }
        void print(){
            cout << "Intrinsic Carrier Density = " << intrinsicCarrierDensity() << endl;
            cout << "Electron Density = " << electronDensity() << endl;
            cout << "Hole Density = " << holeDensity() << endl;
            //Output everything
        }
};

int main(){
    Semiconductor Silicon(1.5e10);
    Silicon.setElectronDensity(1.0e10);
    Silicon.print();
}