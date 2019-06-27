clc;
clear all;
close all;
%Design of analog Butterworth filter
alphap=0.4;
alphas=30;
fp=400;
fs=800;
f=2000;
omegap=2*fp/f; %convert to radians
omegas=2*fs/f; %convert to radians
%Step 1: design of butterworth and order of LPF
[n wn]=buttord(omegap,omegas,alphap, alphas);
%Step2: computing H(s)[b a polynomials] of filter
[b a]=butter(n,wn);
w=0:0.01:pi;
[h w]=freqz(b,a,w,'whole');%to compute frequency
m=abs(h); %to compute magnitude
an=angle(h); %to compute phase
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
title('Phase response');