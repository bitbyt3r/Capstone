function [ U,V ] = azel2UV( az,el )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
U=cosd(el)*sind(az);
V=sind(el);

end

