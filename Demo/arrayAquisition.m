



numAzElements = 8;
numElElements = 4;
MinY = -90;
MinX = -90;
MaxY = 90;
MaxX = 90;
% % %----------------------------------------
% % % aqcuire device, set rate, and add channels
% % %
% % %----------------------------------------
% % devices = daq.getDevices;
% % s = daq.createSession(devices.Vendor.ID);
% % %set rate
% % s.Rate = 31250;
% % 
% % %add channels
% % channelnum = 0;
% % for i = 0:numAzElements - 1
% %     for j = 0:numElElements - 1
% %         ch = addAnalogInputChannel(s,'Dev1', channelnum, 'Voltage');
% %         ch.TerminalConfig = 'SingleEnded';
% %         channelnum = channelnum + 1;
% %     end
% % end
% % %------------------------------------------
% % %make a scan for a set amount of time here
% % %
% % %------------------------------------------
% % 
% % s.setDurationInSeconds(10);
% % [time,Data] = s.startForeground;
% % 
% % %------------------------------------------
% % %begin electronic sweep
% % %
% % %------------------------------------------
[X,Y]=meshgrid(1:180, 1:180);
%max_beam = MaxX*MaxY;

beam_num = 0;
dense_scan_right = zeros(((180*((dx)^-1))+1),((180*((dy)^-1))+1));
dense_scan_left = zeros(((180*((dx)^-1))+1),((180*((dy)^-1))+1));
dense_scan_bottomcenter = zeros(((180*((dx)^-1))+1),((180*((dy)^-1))+1));
dense_scan_topcenter = zeros(((180*((dx)^-1))+1),((180*((dy)^-1))+1));
dx = 2;
dy = 2;
max_beam = ((180*((dx)^-1))+1)*((180*((dy)^-1))+1);

index_y = 1;
index_x = 1;


% for i = MinY:dy:MaxY
%     index_x = 1;
%     for j = MinX:dx:MaxX
%         %tic;
%         beam_num = beam_num + 1;
%         fprintf('Comping Az: %d, and El: %d, Beam: %d/%d\n', j,i,beam_num,max_beam);
%         fprintf('Buffer Index: X: %d, Y: %d\n', index_x, index_y);
%         shift = Make_Delay(dataright,steering(8,4,j,i),31250);
%         summedBuffer = rms(sum(cell2mat(shift),2));
%         dense_scan_right(index_y,index_x) = summedBuffer;
%         
%         
%         %time_elapsed = toc;
%         %if((index_x == 1) && (index_y == 1));
%         %    total_time = (time_elapsed * max_beam);
%         %    %fprintf('Estimated Time of Completion: %d\n\n', total_time);
%         %end
%         %time_remaining = (total_time - (time_elapsed*beam_num))/1200;
%         %fprintf('Time Remaining: %0.2d hours\n', time_remaining);
%         fprintf('*****************************************************************\n');
%         index_x = index_x + 1;
%     end
%     index_y = index_y + 1;
% end
% 
% index_y = 1;
% index_x = 1;
% 
% for i = MinY:dy:MaxY
%     index_x = 1;
%     for j = MinX:dx:MaxX
%         %tic;
%         beam_num = beam_num + 1;
%         fprintf('Comping Az: %d, and El: %d, Beam: %d/%d\n', j,i,beam_num,max_beam);
%         fprintf('Buffer Index: X: %d, Y: %d\n', index_x, index_y);
%         shift = Make_Delay(dataleft,steering(8,4,j,i),31250);
%         summedBuffer = rms(sum(cell2mat(shift),2));
%         dense_scan_left(index_y,index_x) = summedBuffer;
%         
%         
%         %time_elapsed = toc;
%         %if((index_x == 1) && (index_y == 1));
%         %    total_time = (time_elapsed * max_beam);
%         %    %fprintf('Estimated Time of Completion: %d\n\n', total_time);
%         %end
%         %time_remaining = (total_time - (time_elapsed*beam_num))/1200;
%         %fprintf('Time Remaining: %0.2d hours\n', time_remaining);
%         fprintf('*****************************************************************\n');
%         index_x = index_x + 1;
%     end
%     index_y = index_y + 1;
% end

index_y = 1;
index_x = 1;

for i = MinY:dy:MaxY
    index_x = 1;
    for j = MinX:dx:MaxX
        %tic;
        beam_num = beam_num + 1;
        fprintf('Comping Az: %d, and El: %d, Beam: %d/%d\n', j,i,beam_num,max_beam);
        fprintf('Buffer Index: X: %d, Y: %d\n', index_x, index_y);
        shift = Make_Delay(databottomcenter,steering(8,4,j,i),31250);
        summedBuffer = rms(sum(cell2mat(shift),2));
        dense_scan_bottomcenter(index_y,index_x) = summedBuffer;
        
        
        %time_elapsed = toc;
        %if((index_x == 1) && (index_y == 1));
        %    total_time = (time_elapsed * max_beam);
        %    %fprintf('Estimated Time of Completion: %d\n\n', total_time);
        %end
        %time_remaining = (total_time - (time_elapsed*beam_num))/1200;
        %fprintf('Time Remaining: %0.2d hours\n', time_remaining);
        fprintf('*****************************************************************\n');
        index_x = index_x + 1;
    end
    index_y = index_y + 1;
end

index_y = 1;
index_x = 1;
beam_num = 0;

for i = MinY:dy:MaxY
    index_x = 1;
    for j = MinX:dx:MaxX
        %tic;
        beam_num = beam_num + 1;
        fprintf('Comping Az: %d, and El: %d, Beam: %d/%d\n', j,i,beam_num,max_beam);
        fprintf('Buffer Index: X: %d, Y: %d\n', index_x, index_y);
        shift = Make_Delay(datatopcenter,steering(8,4,j,i),31250);
        summedBuffer = rms(sum(cell2mat(shift),2));
        dense_scan_topcenter(index_y,index_x) = summedBuffer;
        
        
        %time_elapsed = toc;
        %if((index_x == 1) && (index_y == 1));
        %    total_time = (time_elapsed * max_beam);
        %    %fprintf('Estimated Time of Completion: %d\n\n', total_time);
        %end
        %time_remaining = (total_time - (time_elapsed*beam_num))/1200;
        %fprintf('Time Remaining: %0.2d hours\n', time_remaining);
        fprintf('*****************************************************************\n');
        index_x = index_x + 1;
    end
    index_y = index_y + 1;
end
fprintf('Finished Beams, saving...');
save('dense_scan_bottomcenter');
save('dense_scan_topcenter');
% save('dense_scan_left');
% save('dense_scan_right');
fprintf('Done\n');

clear X;
clear Y;
[X,Y] = meshgrid(-90:2:90,-90:2:90);

figure;
hold on;
surf(X,Y,dense_scan_bottomcenter,'EdgeColor','none');
view(2);
hold off;
figure;
hold on;
surf(X,Y,dense_scan_topcenter,'EdgeColor','none');
view(2);
hold off;
figure;
hold on;
surf(X,Y,dense_scan_left,'EdgeColor','none');
view(2);
hold off;
figure;
hold on;
surf(X,Y,dense_scan_right,'EdgeColor','none');
view(2);
hold off;

fprintf('done...\n');
%surf(X,Y,buff,'EdgeColor','none');
