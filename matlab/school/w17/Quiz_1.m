
k = 0;
code = '1234';
counter = -1;
while k < 1
    pass = input('Please enter the passcode for your account.');
    if ((length(pass) < 4) || (length(pass) > 4))
        pass = '0000';
    end
    if pass == code
        k = k + 2; 
    end
end

while counter ~= 0
    withdraw = input('How much to withdraw?','s');
    withdraw_amt = str2num(withdraw);
    if (withdraw_amt > 200)
        disp('Not enough money in account')
    elseif (withdraw_amt < 0)
        disp('Invalid value entered')
    else
        disp('Here is your cash')
        counter = 0;
    end   
end