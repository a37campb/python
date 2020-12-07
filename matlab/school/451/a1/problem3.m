
%Name: Adam Campbell
%Quest ID: a37campb
%Date: September 20, 2020
%Due date: September 25, 2020
%Assignment 1 Problem 3


for i = 1:100
    noGausRC = randi(2,100,100)-1; %This generates the randonm integer between 1 and 0
    noGausEigR = eig(noGausRC)'; %Finds the eigen values of the matrix
    gausRC = randn(100,100); %This generates a normal distribution of random numbers between 1 and 0
    gausEigR = eig(gausRC)'; 
    %The if statement below finds the absolute value (for all -- if one, it does not append into an matrix)
    if i == 1
        gausAbsR = abs(gausEigR); 
        noGausAbsR = abs(noGausEigR);
    else
        gausAbsR = [gausAbsR abs(gausEigR)];
        noGausAbsR = [noGausAbsR abs(noGausEigR)];
    end    
end

%Printing the solution based on the requirements as per the question. 
bins = 200;
subplot(2,1,1)
histogram(noGausAbsR,bins)
subplot(2,1,2)
histogram(gausAbsR,bins)


