clc;
close all;
clear all;
fs=200;
f1=20;
f2=40;
f3=50;
f4=35;
t=[10:1:100];
subplot(5,1,1);
s1=sin(2*pi*(f1/fs)*t);
plot(t,s1)
subplot(5,1,2);
s2=sin(2*pi*(f2/fs)*t);
plot(t,s2)
subplot(5,1,3);
s3=sin(2*pi*(f3/fs)*t);
plot(t,s3)
subplot(5,1,4);
s4=sin(2*pi*(f4/fs)*t);
plot(t,s4)
subplot(5,1,5);
s5=s1+s2+s3+s4;
plot(t,s5)
wp=[25 70]*2/fs;
[b1,a1]=butter(4,wp);
[b2,a2]=ellip(16,0.1,40,wp);
[b3,a3]=cheby1(4,0.1,wp);
[b4,a4]=cheby2(4,40,wp);
sb=filter(b1,a1,s5);
se=filter(b2,a2,s5);
sc1=filter(b3,a3,s5);
sc2=filter(b4,a4,s5);
%Frequency domain representation
n=512;
f=fft(s5,n);
fb=fft(sb,n);
fe=fft(se,n);
fc1=fft(sc1,n);
fc2=fft(sc2,n);
h=[0:fs/n:fs-fs/n];
figure(2);
subplot(5,1,1);
plot(h,abs(f));
title('Input');
subplot(5,1,2);
plot(h,abs(fb))
title('Butterworth filter response');
subplot(5,1,3);
plot(h,abs(fe))
title('Elliptical filter response');
subplot(5,1,4);
plot(h,abs(fc1))
title('Chebysev 1 filter response');
subplot(5,1,5);
plot(h,abs(fc2))
title('Chebysev 2 filter response');
[h1,w1]=freqz(b1,a1,n);
[h2,w2]=freqz(b2,a2,n);
[h3,w3]=freqz(b3,a3,n);
[h4,w4]=freqz(b4,a4,n);
figure(3)
subplot(4,1,1);
plot(w1*fs/(2*pi),abs(h1))
title('Butterworth filter response');
subplot(4,1,2);
plot(w2*fs/(2*pi),abs(h2))
title('Elliptical filter response');
subplot(4,1,3);
plot(w3*fs/(2*pi),abs(h3))
title('Chebysev 1 filter response');
subplot(4,1,4);
plot(w4*fs/(2*pi),abs(h4))
title('Chebysev 2 filter response');