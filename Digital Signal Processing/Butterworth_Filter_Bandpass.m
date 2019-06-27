%To design an analog IIR butter worth high pass filter with
parameters :
%alphap=0.4;alphas=30;fp=400Hz;fs=800Hz and
%f=2000(sampling frequency)
%Plot the magnitude and phase response
clc;
clear all;
close all;
%Design of analog Butterworth filter
alphap=2;
alphas=20;
fp1=0.2;
fp2=0.4;
fs1=0.1;
fs2=0.5;
f=2000;
omegap=[0.2*pi,0.4*pi]; %convert to radians
omegas=[0.1*pi,0.5*pi]; %convert to radians
% Step1 :Design of Butterworth and order of LPF
[n wn]=buttord(omegap/pi,omegas/pi,alphap,alphas);
% Step2 :Computing H(s) [b a polynomials] of filter
[b a]=butter(n,wn, 'bandpass');
w=0:0.01:pi;
[h w]=freqz(b,a,w); %To compute frequency of filter
m=abs(h); %To compute magnitude
an=angle(h); %To compute phase
subplot(2,1,1);
%Plotting magnitude response
plot(w/pi,20*log(m));
grid;
xlabel('Normalised Frequency');
ylabel('Gain in dB');
title('Magnitude Response');
subplot(2,1,2);
%Plotting phase response
plot(w/pi,an);
grid;
xlabel('Normalised Frequency');
ylabel('Gain in radians');
title('Phase Response');