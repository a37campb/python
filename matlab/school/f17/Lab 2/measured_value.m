x_val = [1,2,4,5,8,16,32,64];
for i = 1:length(x_val)
    actual_val = -2*(x_val(i))*sin((x_val(i))^2);
    try
        measured_val = richardson22(@Dc,@f2d,x_val(i),0.1,5,10^-10);
        abs_error = abs( measured_val - actual_val );
        relative_error = abs( (measured_val - actual_val)/actual_val );
        fprintf('Richardson Extrapolation for x=%4.0f  resulted in approximately %16.16e \n',x_val(i),measured_val)
        fprintf('The absolute error in this value is approximately %16.16e \n',abs_error)
        fprintf('The relative error in this value is approximately %16.16e \n',relative_error)
        if i ~= 8
            disp('-----------------------------------------------')
        end
    catch
        fprintf('Richardson`s extrapolation did not converge for a value of x=%4.0f \n',x_val(i))
    end
end