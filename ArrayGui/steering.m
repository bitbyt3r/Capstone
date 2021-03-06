


function [delay] = steering(az , el, Azimuth, Elevation)
%clear;
[X,Y]=meshgrid(0:az-1, 0:el-1);

%[X,Y]=meshgrid(0:100, 0:100);
%Y = Y .* 2;

%Azimuth =azang;

%Elevation = elang;

c = 13397.244;

% Radar Coordinates
%---------------------------
Wx = sind(Azimuth).*cosd(Elevation);
Wy = sind(Elevation);


% Conical Coordinates
%---------------------------
%Wx = sind(Azimuth);
%Wy = sind(Elevation);


%Polar Coordinates
%---------------------------
%theta = 45;
%phi = 0;

%Wx = cosd(phi).*sind(theta);
%Wy = sind(phi).*sind(theta);
%---------------------------


delay = (((X .* Wx)+(Y .* Wy)) ./ c);

