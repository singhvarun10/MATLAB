clc;
close all;
clear all;
t=0:200;
fs=200;
s1=sin(2*pi*20*t/fs); %signal of 20 Hz
subplot(4,1,1);
plot(t,s1);
title('20 Hz signal');
xlabel('time');
ylabel('amplitude');
s2=sin(2*pi*40*t/fs); %signal of 40 Hz
subplot(4,1,2);
plot(t,s2);
title('40 Hz signal');
xlabel('time');
ylabel('amplitude');
s3=sin(2*pi*60*t/fs); %signal of 60 Hz
subplot(4,1,3);
plot(t,s3);
title('60 Hz signal');
xlabel('time');
ylabel('amplitude');
s=s1+s2+s3;
subplot(4,1,4);
plot(t,s);
title('addition of 3 signals');
xlabel('time');
ylabel('amplitude');
%Frequency Domain
n=256; %256 point FFT
f=fft(s,n);
d=abs(f); %Magnitude of FFT coefficients
figure(2);
h=0:fs/n:fs-(fs/n); %defining X-axis of spectrum
plot(h,d);
title('spectrum of signals');
ylabel('amplitude');
xlabel('frequency');