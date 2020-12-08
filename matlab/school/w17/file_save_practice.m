clear all
clc

a = [1,2,3,4,5,6,7,8,9,10;2,3,4,5,6,7,8,9,10,11]';
%{
fileID = fopen('my_data.txt','w');
fprintf(fileID,'%6s %12s\r\n','x','y');
fprintf(fileID,'%6.2f %12.8f\r\n',a);
fclose(fileID);
%} 

file_ID = ('my_data.csv');
csvwrite(file_ID,a)
filename =('my_data.csv');
delimiterln1 = ' ';
headerln1 = 1;
apples = importdata(filename,delimiterln1,headerln1);
disp(apples.data);


%{
filename = ('my_data.csv');
delimiterln1 = ',';
headerln1 = 1;
apple = importdata(filename,delimiterln1,headerln1);
disp(apple.colheaders);
disp(apple.data);
%}