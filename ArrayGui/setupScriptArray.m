%numAzElements = 8;
%numElElements = 4;
%MinY = -90;
%MinX = -90;
%MaxY = 90;
%MaxX = 90;
% ----------------------------------------
% aqcuire device, set rate, and add channels
% 
% ----------------------------------------

global azNum;
global elNum;
disp('begin setup')
disp('azNum')
disp('elNum')
devices = daq.getDevices;
s = daq.createSession(devices.Vendor.ID);

%set rate
s.Rate = 31250;

%add channels
channelnum = 0;
for i = 0:azNum - 1
    for j = 0:elNum - 1
        ch = addAnalogInputChannel(s,'Dev1', channelnum, 'Voltage');
        ch.TerminalConfig = 'SingleEnded';
        ch.Coupling = 'DC';
        %ch.Range = [-1,1];
        
        channelnum = channelnum + 1;
    end
end

disp('done setup')

%------------------------------------------
%make a scan for a set amount of time here
%
%------------------------------------------

%s.Channels(1,1:32).Range.Min = -1;
%s.Channels(1,1:32).Range.Max = 1;
%s.DurationInSeconds = 10;