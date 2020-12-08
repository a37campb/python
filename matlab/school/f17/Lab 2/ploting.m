x1 = linspace(0,5,100); % linspace for the x axis
for i= 1:length(x1)
    y1(i) = f2b(x1(i));
    y2(i) = 4*(1-2*x1(i))*exp(-2*x1(i)) + 4*x1(i)*(-2+x1(i))*exp(-x1(i)) - (exp(-(x1(i)/2))/2);
    y3(i) = Dc(@f2b,x1(i),0.1);
end
figure = plot(x1,y1,'k',x1,y2,'b',x1,y3,'r');