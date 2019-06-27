%design of FIR filter using hamming window
%Passband ripple, rp=0.01
%Stopband ripple, rs=0.02
%Passband frequency = 1000
%Stopband frequency = 2000
%Sampling frequency = 5000
clc;
clear all;
close all;
rp=input('Enter the passband ripple : ');
rs=input('Enter the stopband ripple : ');
fpb=input('Enter the passband frequency : ');
fsb=input('Enter the stopband frequency : ');
fs=input('Enter the sampling frequency : ');
Wp=2*fpb/fs;
Ws=2*fsb/fs;
num=(-20*log10(sqrt(rp*rs)))-13;
den=14.6*(fsb-fpb)/fs;
n=ceil(num/den);
n1=n+1;
if(rem(n,2)~=0)
n1=n;
n=n-1;
end
y=hamming(n1);
% Low Pass Filter
b=fir1(n,Wp,y);
[h w]=freqz(b,1,256);
m=20*log10(abs(h));
subplot(2,2,1);
plot(w/pi,m,'c');
ylabel('Gain(db)');
xlabel('Normalized Frequency ------>');
title('Magnitude Reesponse of a Low Pass FIR filter');
%High Pass Filter
b=fir1(n,Wp,'high',y);
[h w]=freqz(b,1,256);
g=20*log10(abs(h));
subplot(2,2,2);
plot(w/pi,g,'m');
ylabel('Gain(db)');
xlabel('Normalized Frequency ------>');
title('Magnitude Reesponse of a High Pass FIR filter');
%Band Pass Filter
Wn=[Wp,Ws];
b=fir1(n,Wn,'bandpass',y);
[h w]=freqz(b,1,256);
l=20*log10(abs(h));
subplot(2,2,3);
plot(w/pi,l,'g');
ylabel('Gain(db)');
xlabel('Normalized Frequency ------>');
title('Magnitude Reesponse of a Band Pass FIR filter');
%Band Stop filter
Wn=[Wp,Ws];
b=fir1(n,Wn,'stop',y);
[h w]=freqz(b,1,256);
o=20*log10(abs(h));
subplot(2,2,4);
plot(w/pi,o,'b');
ylabel('Gain(db)');
xlabel('Normalized Frequency ------>');
title('Magnitude Reesponse of a Band Stop FIR filter');