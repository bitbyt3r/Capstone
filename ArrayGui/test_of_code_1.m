%delayed_signal = mat2cell(datacenter);
delayed_signal = Make_Delay(new_data,steering(8,4,90,90),31250);
S = sum(cell2mat(delayed_signal),2);

sampling_rate = 31250;
Compute_Predominant_Frequency(delayed_signal,31250);
% length_data = length(S);
%     disp(length_data);
%     f = sampling_rate*(0:(length_data/2))/length_data;
%     
%     freq_response_pre1 = fft(S);
%     
%     freq_response_pre2 = abs(freq_response_pre1/length_data);
%     freq_response = freq_response_pre2(1:length_data/2+1);
%     freq_response(2:end-1) = 2*freq_response(2:end-1);
%     freq_response(1)=0;
%     
%     %f = Fs*(0:(L/2))/L;%
%     figure(5);
%     plot(f,freq_response);%%remove!!! for testing only
%     
    
%[ highest_freq ] = Compute_Predominant_Frequency( delayed_signal, 31250 );
