clc
clear

two_theta = [21.544,30.6403,33.1806,35.5363,39.9025,41.9281];
%two_theta = [38.43,44.67,65.02,78.13,82.33,98.93, 111.83,116.36];
lambda = 1.5418;
%lambda = 1.540562
theta = (1/2).* two_theta;
sine_sq = zeros(1,length(theta));

for i = 1:length(theta)
    sine_sq(i) = (sind(theta(i)))^2;
end   

z = 6;
ratio = sine_sq ./ sine_sq(1);
z_ratio = ratio.*z;
h2k2l2 = round(z_ratio);

a = zeros(1,length(theta));
for i = 1:length(a)
    a(i) = sqrt((lambda^2)*(h2k2l2(i))/4);
end

disp('sine squared theta:');
disp(sine_sq);
disp('------------------------------');
disp('sine squared ratio:');
disp(ratio);
disp('------------------------------');
disp('z value');
disp(z);
disp('------------------------------');
disp('z times ratio');
disp(z_ratio);
disp('------------------------------');
disp('h^2 + k^2 + l^2 values');
disp(h2k2l2);
disp('------------------------------');
disp('a values in Angstrom');
disp(a);
