
x_0 = 1;
v_0 = 0;
m = 1;
k = 1;
y = [0,1,2,4];
tf = 20;
t = zeros(100,4);
x = zeros(100,4);

for i = 1:4
    [t_i,x_i] = ans1(m,k,y(i),x_0,v_0,tf);
    t(:,i) = t_i;
    x(:,i) = x_i(:,2);
end

subplot(4,1,1)
plot(t(:,1),x(:,1))
title(['Position of Harmonic Oscillator when {\gamma} = ' int2str(y(1))])
subplot(4,1,2)
plot(t(:,2),x(:,2))
title(['Position of Harmonic Oscillator when {\gamma} = ' int2str(y(2))])
subplot(4,1,3)
plot(t(:,3),x(:,3))
title(['Position of Harmonic Oscillator when {\gamma} = ' int2str(y(3))])
subplot(4,1,4)
plot(t(:,4),x(:,4))
title(['Position of Harmonic Oscillator when {\gamma} = ' int2str(y(4))])

function [t_fC,xR] = ans1(mass,spring, damp, x_init, v_init, t_final)

%This function solves the differential equation for the motion of a simple harmonic oscillator. 
%The function inputs are described below: 
%mass: mass of the oscillator
%spring: spring constant of the system
%damp: dampening coefficient of the system
%x_init: position of the mass at t=0
%v_init: speed of the mass at t=0
%t_final: length of time the oscillator motion is being recorded for

%The function outputs are defined below: 
%t_fC: final time array for the system (column vector)
%xRC: final array (position and speed) for the system.

t_span = linspace(0,t_final,100); %creates the time linspace

odeR = @(t,xR) [xR(2); -(spring*xR(1))/mass - damp*xR(2)]; %system of ODEs
[t_fC,xR] = ode23(odeR,t_span,[0 x_init], [0 v_init]); %runs ode23 to solve.
end
