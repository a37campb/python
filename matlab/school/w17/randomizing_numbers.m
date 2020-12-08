% You have a set of numbers, and you need to randomize them.
clc
clear all

llim = 10;
ulim = 20;
results = linspace(llim,ulim,ulim-llim+1);
datap = length(results);
r = round( (ulim-llim) * rand + llim );
list(1) = r;
for i = 2:datap
    flag = 1;
    while flag == 1
        r = round( (ulim - llim) * rand + llim );
        same = 0;
        for k = 1:length(list)
            if r == list(k)
                same = same + 1;
            end
        end
        if same == 0 
            flag = 0;
        end
    end
    list(i) = r;
end
disp(list)