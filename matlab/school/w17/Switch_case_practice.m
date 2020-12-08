month = input('Please enter the month of the year, as a number (between 1 to 12 inclusive)  ');
day = 0;
switch month
    case 1
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = day;
    case 2
        while day < 1 || day > 28
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = 31 + day;
    case 3
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = 31 + 28 + day;
    case 4
        while day < 1 || day > 30
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (2 * 31) + 28 + day;
    case 5
         while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (2 * 31 )+ 28 + 30 + day;
    case 6
        while day < 1 || day > 30
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (3 * 31 )+ 28 + (30) + day;
    case 7
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (3 * 31)+ 28 + (2* 30) + day;
    case 8
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (4 * 31)+ 28 + (2 * 30) + day;
    case 9
        while day < 1 || day > 30
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (5 * 31)+ 28 + (2* 30) + day;
    case 10
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (5 * 31)+ 28 + (3* 30) + day;
    case 11
        while day < 1 || day > 30
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (6 * 31)+ 28 + (3* 30) + day;
    case 12
        while day < 1 || day > 31
            day = input ('Please enter the day of the month as a number   ');
        end
        total_days = (6 * 31)+ 28 + (4* 30) + day;
    otherwise
        disp('Invalid input');
end
disp(['The total number of days passed is: ', num2str(total_days)]);