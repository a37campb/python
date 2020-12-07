

#include <discpp.h>
#include <iostream>
#include <cmath>
#include <string>
using namespace std;

class euler{
    private: 
        double ia, ib, ic, fi;
        double dt;
        double diffx(double vi, double xi, double dt){
            return (vi*dt + xi);
        }
        double diffv(double vi, double xi, double dt, double ti, double ia, double ib, double ic, double fi){
            return ( -dt*( (ia*pow(xi,3) + ib*xi + ic*vi) ) + fi*dt*cos(ti) + vi );
        }
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
            g.hsymbl(5);
            g.graf(minX, maxX, minX, stepX, minY,maxY, minY, stepY);
            g.curve(x,y,run);
            g.endgrf();
            g.disfin();
        }
    public:
        double orig_x,orig_v, miT;
        int len;
        void setDt(double adt){
            dt = adt;
        }
        void setConsts(double a, double b, double c, double f){
            ia = a;
            ic = c;
            ib = b; 
            fi = f;
        }
        void setIniCond(double aorig_x, double aorig_v, double amiT){
            orig_x = aorig_x;
            orig_v = aorig_v;
            miT = amiT;
        }
        void showEulerCalc(double orig_x, double orig_v, double miT){
            double x[len], v[len], t[len];
            t[0] = miT;
            x[0] = orig_x;
            v[0] = orig_v;
            for (int i=1;i<len;i++){
                t[i] = miT + i*dt;
                v[i] = diffv(v[i-1], x[i-1], dt, t[i-1], ia, ib, ic, fi);
                x[i] = diffx(v[i-1], x[i-1], dt);
            }
            draw(x, v, len, "Position of the Oscillator [m]", "Correct Velocity of the Oscillator [m/s]", "FLOAT");
        }
        void showEulerCalcMod(double orig_x, double orig_v, double miT){
            double x[len], v[len], t[len];
            t[0] = miT;
            x[0] = orig_x;
            v[0] = orig_v;
            for (int i=1;i<len;i++){
                t[i] = miT + i*dt;
                v[i] = diffv(v[i-1],x[i],dt,t[i-1], ia, ib, ic, fi);
                x[i] = diffx(v[i-1], x[i-1], dt);
            }
            draw(x, v, len, "Position of the Oscillator [m]", "Incorrect Velocity of the Oscillator [m/s]", "FLOAT");
        }
        euler(double a, double b, double c, double f, double adt, const int alen){
            ia = a;
            ic = c;
            ib = b; 
            fi = f;
            dt = adt;
            len = alen;
        }
};

int main(){
    const int len = 40000;
    double miT = 0, dt = 0.03, a = 1, b = 0, c = 0.3, f = 10, orig_x = 1, orig_v = 6;
    euler gg(a, b , c , f , dt , len );
    gg.showEulerCalc(0, 0, 0);
    gg.showEulerCalc(orig_x, orig_v, miT);
    gg.showEulerCalcMod(orig_x, orig_v, miT);    
    return 0;
}
