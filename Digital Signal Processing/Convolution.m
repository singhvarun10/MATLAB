clc;
clear all;
x=input('samples of x[n]');
h=input('samples of h[n]');
xlen=length(x);
hlen=length(h);
k=0;y=0;
for i=1:xlen;
for j=1:hlen;
y(i,j+k)=x(i)*h(j);
end
k=k+1;
end;
disp('convolution of signals');
z=sum(y);
stem(z);