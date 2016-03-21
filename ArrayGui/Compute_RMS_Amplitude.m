function [ rms_sum ] = Compute_RMS_Amplitude( shifted_data )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    rms_sum = rms(sum(cell2mat(shifted_data),2));

end

