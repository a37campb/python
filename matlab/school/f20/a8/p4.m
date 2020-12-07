

% Monte Carlo Method for x^2 + y^2 = 1

f = @(x) sqrt(1 - x.^2);

nPointsBase = 1000;
xL = 0;
xR = 1;
yL = 0;
yR = 1;
region = (yR - yL)*(xR - xL);
for iVal = 1:10
    nPoints = nPointsBase*(2^iVal);
    xVals = rand(1,nPoints) * (xR-xL) + xL;
    yVals = rand(1, nPoints) * (yR-yL) + yL;
    ptsCurve = sum(yVals < f(xVals) );
    soln = abs(4*(region*ptsCurve/nPoints + yL * (xR-xL)) - pi);
    if iVal == 1
        log_int = log10(soln);
        log_pts = log10(nPoints);
    else
        log_int = [log_int log10(soln)];
        log_pts = [log_pts log10(nPoints)];
    end 
end

plot(log_pts,log_int);
xlabel('Log10 of the Number of Steps');
ylabel('Log10 of the Error in the Method');
title('Graph Showing the Log of the Error in the Monte Carlo Integral vs Log of the Number of Points');