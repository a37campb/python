clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%
% CIRCLE 
%%%%%%%%%%%%%%%%%%%%%%%%
v2 = rand;
m = rand;
h_bar = 1.05457180013e-34;
r = sqrt(2*m*v2)/h_bar;
%number of points
n = 1000;
c = 0;
theta = linspace(0,pi/2,n);
x = c + r*cos(theta);
y = c + r*sin(theta);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAN AND COT SET UP
%%%%%%%%%%%%%%%%%%%%%%%%%%
b = 4;
d = (b * h_bar)/(sqrt(2*m*v2));
xt = linspace(0,5*pi,n);
k2 = (sqrt(2*m*((v2*xt)-v2)))/h_bar;
a2 = (sqrt(2*m*(v2-(v2*xt))))/h_bar;
%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAN CURVE
%%%%%%%%%%%%%%%%%%%%%%%%%%
x_axis = 2*(k2.*(d/2))*tan(k2.*(d/2));
y_axis = a2*d;
%%%%%%%%%%%%%%%%%%%%%%%%%%
% COT CURVE
%%%%%%%%%%%%%%%%%%%%%%%%%%
y1_axis = a2*d;
x2_axis = -2*(k2.*(d/2))/(tan(k2.*(d/2)));
plot(x,y,x_axis,y_axis,x1_axis,y1_axis);