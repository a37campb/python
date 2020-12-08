
k = 0;
j = 0;
code = '1234';
counter = -1;
balance = 200;
while k < 1
    pass = input('Please enter the passcode for your account.  ','s');
    j = j + 1;
    if (j == 5)
        disp('You have entered too many incorrect passcodes.  ')
        disp('You will be locked out of the system.  ')
        disp('Contact your banker to change your passcode !  ')
        break
    end
    if ((length(pass) < 4) || (length(pass) > 4))
        pass = '0000';
    end
    if (pass == code)
        k = k + 2;
    end
end

while counter ~= 0
    if (j == 5)
        break
    end
    disp('Welcome to the main menu !   ')
    disp('Select the submenu you wish to enter, by typing it`s name, or exit, from the menu selection to quit.   ')
    selection = input('Withdraw Money,Deposit money, Check Balance, Transfer Money,Change Passcode, Exit   ', 's');
    if (selection == 'Withdraw Money')
        withdraw = input('How much to withdraw?  ','s');
        withdraw_amt = str2num(withdraw);
        if (withdraw_amt > balance)
            disp('Not enough money in account  ')
        elseif (withdraw_amt < 0)
            disp('Invalid value entered  ')
        else
            balabmce = balance - withdraw_amt;
            disp('Here is your cash  ')
            continue
        end
    elseif (selection == 'Deposit Money')
        deposit = input('How much to withdraw?  ','s');
        deposit_amt = str2num(deposit);
        balance = balance + deposit_amt;
        disp('The money has been deposited to your account')
        disp('Your new balance is', num2str(balance))
        continue
    elseif (selection == 'Check Balance')
        disp('Your Balance is,', num2str(balance) )
        continue
    elseif (selection == 'Transfer Money')
        transfer = input('How much money would you like to transfer?  ', 's');
        transfer_amt = str2num(transfer);
        if (transfer_amt > balance)
            disp('Not enough money in account  ')
        elseif (transfer_amt < 0)
            disp('Invalid value entered  ')
        else
            disp('The money has been transfered out of your account.  ')
            balance = balance - transfer;
            continue
        end
    elseif (selection == 'Change Passcode')
        code_1 = disp('Please enter your new passcode of length four.  ', 's');
        code_2 = disp('Please reenter your new passcode of length four.  ', 's');
        if ( (code_1 == code_2) && (length(code_1) == 4 && length(code_2) == 4) )
            code = code_1;
        else
            disp('New code could not be verrified, or was of incorrect length. If you wish to reset the code, please repeat the proces')
            continue
        end
    elseif (selection == 'Exit' | 'exit')
       counter = 0;
    end
end
