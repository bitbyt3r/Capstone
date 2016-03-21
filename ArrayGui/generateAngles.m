function [ angles ] = generateAngles( angMinY, angMinX, angMaxY, angMaxX, step )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


for i = angMinY:step:angMaxY
    for j = angMinX:step:angMaxX
        
        delays = steering(8,4,j,i);
       
        filename = sprintf('az_%s_el_%s.txt',num2str(j),num2str(i));
        file = fullfile('C:','Users','Tyler','Documents','MATLAB','scanDirectory',filename);
       
        arrayFileWriter(delays,file);
      
        
    end
end

end

