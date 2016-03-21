function [ highest_freq ] = Compute_Predominant_Frequency( shifted_data, sampling_rate )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
S = sum(cell2mat(shifted_data),2);

%S = scratchfilt(S);
    length_data = length(S);
    f = sampling_rate*(0:(length_data/2))/length_data;
    
    
    
    freq_response_pre1 = fft(S);
    freq_response_pre2 = abs(freq_response_pre1/length_data);
    freq_response = freq_response_pre2(1:length_data/2+1);
    freq_response(2:end-1) = 2*freq_response(2:end-1);
    freq_response(1)=0;
    %f = Fs*(0:(L/2))/L;%
    %figure(5);
   % plot(f,freq_response);%%remove!!! for testing only
    
    highest_freq = f(find(freq_response == max(freq_response)));
    

end

