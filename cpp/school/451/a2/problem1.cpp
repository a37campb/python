#include "dislin.h" 

const int N = 4;
int main()
{ 
    float x[N] = { 0 }, y[N] = { 0 };
    for ( int i = 0; i < N; i++ ) 
    {
        x[i] = i; 
        y[i] = i * i; 
    }
    
    //Dislin g; For if we use discpp library
    //g.qplot( x, y, N );
    qplot( x, y, N );
}         // 4 = number of points.