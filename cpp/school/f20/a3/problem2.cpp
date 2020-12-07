
#include <dislin.h>
#include <iostream>
#include <cmath>
using namespace std;

class Rectangle{
    private:
        double iLength, iWidth;
    public:
        Rectangle(double len, double wid){
            iLength = len;
            iWidth = wid;
            //Constructrs class with length and width
        }
        void setLength(double aLength){
            iLength = aLength;
            //Overwrites length from user
        }
        void setWidth(double aWidth){
            iWidth = aWidth;
            //Overwrites length from user
        }
        double getLength(){
            return iLength;
            //Prints Length to terminal
        }
        double getWidth(){
            return iWidth;
            //Prints Width to terminal
        }
        void area(){
            cout << "Area of the rectangle = " << getWidth()*getLength() << endl;
            //Calculates area and prints to terminal
        }
};

int main(){
    Rectangle temp(10,20);
    temp.area();
}