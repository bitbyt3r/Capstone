function [ target_Az, target_El, max_value ] = Target_Match_Amplitude( minX, maxY, dx, dy, scan_plot )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [max_value, index] = max(scan_plot(:));
    [subscript_Y,subscript_X] = ind2sub(size(scan_plot), index);
    target_Az = (subscript_X * dx) + minX;
    target_El =  maxY - (subscript_Y * dy);
    

end

