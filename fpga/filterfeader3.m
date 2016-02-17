Fs = 31250; %sampling frequency
T = 1/Fs; %period
L = 312500; %length of signal
t = (0:L-1)*T;

%sum up data for array
S = sum(datacenter,2);



%plot the combined signal
figure(1);
plot(31250*t(1:312500),S(1:312500));
title('Signal with Noise');
xlabel('t milliseconds');
ylabel('X(t)');

%compute fft of combined signal
%fftr1= abs(fft(S)/L);


fftr1= abs(fft(S)/L);
fftr2 = fftr1(1:L/2+1);

fftr2(2:end-1) = 2*fftr2(2:end-1);

f = Fs*(0:(L/2))/L;%
fftr2(1)=0;
%plot the fft of the combined signal
figure(2);
plot(f,fftr2)
title('Single-sided amplitude spectrum X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');


%now filter it
%filtered_pre = convolveSine(S,window_1);
%filtered = ifft(filtered_pre);

%filtered = sinefilter10(S);
%filtered = IIReliptical14(S);
%filtered = tyler(S);

filtered = scratchfilt(S);
%filtered = filter(Num,1,S);

%first just the signal
figure(3);
plot(31250*t(1:312500),filtered(1:312500));
title('filtered Signal');
xlabel('t milliseconds');
ylabel('X(t)');
%then fft
y = fft(filtered);
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
P1(1) = 0;
figure(4);
plot(f,P1)
title('Single-Sided Amplitude Spectrum of filtered data')
xlabel('f (Hz)')
ylabel('|P1(f)|')


disp(rms(filtered));