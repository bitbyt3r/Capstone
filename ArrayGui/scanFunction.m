function [ data_to_plot,X,Y, message ] = scanFunction(datain, az_min, az_max, el_min, el_max, dx, dy, numX , numY, plotChoice)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
time = tic;


beam_num = 0;
data_to_plot = zeros((az_max-az_min)*(dx^-1)+1,(el_max-el_min)*(dx^-1)+1);
%data_to_plot = zeros(((180*((dx)^-1))+1),((180*((dy)^-1))+1));

%max_beam = ((180*((dx)^-1))+1)*((180*((dy)^-1))+1);

index_y = 1;
index_x = 1;

for i = el_min:dy:el_max
    disp('start loop');
    index_x = 1;
    for j = az_min:dx:az_max
        
        beam_num = beam_num + 1;
       
        delayed_signal = Make_Delay(datain,steering(numX,numY,j,i),31250);
        
        if (plotChoice == 1)
        summedBuffer = Compute_RMS_Amplitude(delayed_signal);
        elseif(plotChoice ==2)
        summedBuffer = Compute_Predominant_Frequency(delayed_signal,31250);
        end % add phase option
        data_to_plot(index_y,index_x) = summedBuffer;
        
       disp(data_to_plot);
        index_x = index_x + 1;
        
    end
    
    index_y = index_y + 1;
    disp('stop loop');
end
time = toc(time);
message = cellstr('*************scan completed*************************');
message = [message;cellstr(sprintf('scan time: %d', time))];
[X,Y] = meshgrid(az_min:dx:az_max,el_min:dy:el_max);
disp(data_to_plot);
% figure(1);
% surf(X,Y,20*log10(test1),'EdgeColor','none');
% xlabel('Azimuth','FontSize',20)
% ylabel('Elevation','FontSize',20)
% title('dB over Max Scan Volume','FontSize',20);
% view(2);
% 
% figure(2);
% [U,V] = azel2UV(X,Y);
% surf(U,V,20*log10(test1),'EdgeColor','none');
% xlabel('U','FontSize',20)
% ylabel('V','FontSize',20)
% title('dB over Max Scan Volume','FontSize',20);
% view(2);
end

