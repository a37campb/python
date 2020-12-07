
%Name: Adam Campbell
%Quest ID: a37campb
%Date: September 20, 2020
%Due date: September 25, 2020
%Assignment 1 Problem2


angle = pi/2;
testRC = -1i*[0 1 0;-1 0 0; 0 0 0];
vec1_C = [0 2 0]';
r_theta_1_RC = rotations(angle, testRC)
x_rot_C = r_theta_1_RC*[1 0 0]'
y_rot_C = r_theta_1_RC*[0 1 0]'
function [rotRC] = rotations(theta,lRC)

% This function calculates the infitessimal rotation of a matrix of vectors -- as described in the Lecture 2 slides. 

%Inputs: 
%theta: this is the angle (in radians) by which the vector is to be roated by. 
%lRC: This is the Lie group of rotations we would like to rotate through. The size of the Lie group that is inputted must relate to the size of the be roated.

%Output: 
%rotRC: The rotated vector. 
    rotRC = expm( -1i*theta * lRC);
end


