function [new_tensor, direction_cos] = transformation(old_tensor, old_ref_axis, new_ref_axis)
% This function changes the coordinate basis vector of a tensor.
if ~isequal(size(old_tensor),[3,3]) || ~isequal(size(old_ref_axis),[3,3]) || ~isequal(size(new_ref_axis),[3,3])
    throw(MException('MATLAB:numeric_exception', 'James... Prof Ting said I didn"t have to error check. Please use the right input as specified by Prof. TIng.')); %Outputs a detailed error, explaining why the function failed.
end
[new_tensor, direction_cos] = deal((new_ref_axis*old_ref_axis')*old_tensor*(new_ref_axis*old_ref_axis')', (new_ref_axis* old_ref_axis')); %The deal function assigns inputs to outputs. Each of the inputs is the linear algebra method to find a and the transformation.
end