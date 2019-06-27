clc;
clear all;
close all;
%generation of unit impulse signal
n=-20:20;
x=[zeros(1,20) 1 zeros(1,20)];
subplot(3,1,1);
stem(n,x);
xlabel('Time index n');
ylabel('Amplitude');
title('Unit Impulse Signal');
%generation of unit step signal
y=[zeros(1,20) 1 ones(1,20)];
subplot(3,1,2);
stem(n,y);
xlabel('Time index n');
ylabel('Amplitude');
title('Unit Step Signal');
%generation of unit ramp signal
z=[zeros(1,21),1:20];
subplot(3,1,3);
stem(n,z);
xlabel('Time index n');
ylabel('Amplitude');
title('Unit ramp Signal');
clc;
clear all;
close all;
%generation of exponential increasing signal
n=0:10;
a=2;
x=a.^n;
subplot(3,1,1);
stem(n,x);
xlabel('Time index n');
ylabel('Amplitude');
title('Exponential Increasing Signal');
%generation of exponential decreasing function
n=0:10;
a=0.5;
x=a.^n;
subplot(3,1,2);
stem(n,x);
xlabel('Time index n');
ylabel('Amplitude');
title('Exponential Decreasing Signal');
%generation of sine wave
t=0:0.1:20;
x=3*sin(t);
subplot(3,1,3);
plot(t,x);
xlabel('Time index n');
ylabel('Amplitude');
title('Sine Wave');
clc;
clear all;
close all;
%generation of triangular wave
t=-10:10;
a=2;
x1=1-abs(t)/a;
x2=0;
x=x1.*(abs(t)<=a)+x2.*(abs(t)>a);
stem(t,x);
subplot(3,1,1);
plot(t,x);
xlabel('Time index n');
ylabel('Amplitude');
title('Triangular Wave');
%generation of gaussian waveforms
t=-10:0.05:10;
a=2;
y=exp(-a.*(t.^2));
subplot(3,1,2);
plot(t,y);
xlabel('Time index n');
ylabel('Amplitude');
title('Gaussian Waveform');
%generation of parabolic waveforms
t=-10:0.05:10;
a=0.4;
z1=(a*(t.^2))/2;
z2=0;
z=z1.*(t>=0)+x2.*(t<0);
subplot(3,1,3);
plot(t,z);
xlabel('Time index n');
ylabel('Amplitude');
title('Parabolic Signal');