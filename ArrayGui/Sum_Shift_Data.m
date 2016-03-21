function [ summed_shifted_data ] = Sum_Shift_Data( data, num_az, num_el, az, el, sample_rate )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    shifted_data = Make_Delay(data,steering(num_az,num_el,az,el),sample_rate);
    summed_shifted_data  = sum(cell2mat(shifted_data),2);
    

end

