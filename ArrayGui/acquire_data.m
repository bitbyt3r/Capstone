function [ output_data, scan_time ] = acquire_data(time)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 
 global root;
 
 root.configuration.s.DurationInSeconds = time; 
 [output_data,scan_time] = root.configuration.s.startForeground;


%demoTest_1_tay = Apply_Taper(demoTest_1,'taylor');
 %starts a scan and applies tapers and filtering if needed;
end

