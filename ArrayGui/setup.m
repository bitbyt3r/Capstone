function [  ] = setup( az,el,sessionRate,voltage)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global root;
devices = daq.getDevices;
try
root.configuration.s = daq.createSession(devices.Vendor.ID);
device_found = 1;
catch
    %message = [cellstr('problem with session, possibly no device found, cancelling setup')];
    device_found = 0;
end
    
%if device found, proceed with setup
if(device_found == 1)
    
    try %try setting the rate to see if its good
        root.configuration.s.Rate = sessionRate;
        rate_good = 1;
    catch
       % message = [message; cellstr('session rate above 31250, setting this to 31250 as default')];
        root.configuration.s.Rate = 31250;
        rate_good = 0;
    end
    
    try % try setting one range to see if it works right
        ch.Range = [-voltage,voltage];
        voltage_good = 1;
    catch
       % message = [message; cellstr('incorrect voltage range, default to -10, 10')];
        voltage = 10;
        voltage_good = 0;
    end
    
    
    %add channels
    if (rate_good && voltage_good)
        channelnum = 0;
        for i = 0:az - 1
            for j = 0:el - 1
                ch = addAnalogInputChannel(root.configuration.s,'Dev1', channelnum, 'Voltage');
                ch.TerminalConfig = 'SingleEnded';
                ch.Coupling = 'DC';
                ch.Range = [-voltage,voltage];

                channelnum = channelnum + 1;
            end
        end
        
    else
        %message = [message; cellstr('failure')];
    end
    


 


    %message = [message; 'Setup Complete'];
    %disp(message);

    end
end

