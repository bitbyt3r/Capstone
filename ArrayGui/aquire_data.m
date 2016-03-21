function [ output_data, scan_time ] = aquire_data()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 
 global root;
 
 
 [output_data,scan_time] = root.configuration.s.startForeground;


%demoTest_1_tay = Apply_Taper(demoTest_1,'taylor');
 %starts a scan and applies tapers and filtering if needed;
end

