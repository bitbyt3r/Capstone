function [ target_Az, target_El, closest_value] = Target_Match_Frequency( target_freq, minY, maxX, dx, dy, scan_plot )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    difference_abs = abs(scan_plot - target_freq);
    [index_temp_1, index_temp_2] = min(difference_abs(:));
    
    [subscript_X,subscript_Y] = ind2sub(size(scan_plot), index_temp_2);
    target_Az = (subscript_X * dx) + minX;
    target_El = (subscript_Y * dy) - maxY;
    closest_value = scan_plot(index_temp_2);
    
   

end

