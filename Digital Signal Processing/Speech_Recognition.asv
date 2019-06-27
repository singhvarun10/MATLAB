/*
* main.c
*/
#include<stdio.h>
#include<math.h>
int N;
float real;
float imag;
int k,i,n;
float out_real[8]={0.0};
float out_imag[8]={0.0};
int x[32];
void main(void){
printf("\enter the length of the sequence");
scanf("%d", &N);
printf("\n Enter the sequence");
for(i=0;i<N;i++)
{
scanf("%d", &x[i]);
}
for(k=0;k<N;k++)
{
real=0;
imag=0;
for(n=0;n<N;n++)
{
real = real + (x[n]*cos(2*3.14*k*n/N));
imag = imag - (x[n]*sin(2*3.14*k*n/N));
}
out_real[k] = real;
out_imag[k] = imag;
if(imag<0)
printf("x[%d]=\t%f\t%fi\n", k,out_real[k],out_imag[k]);
else
printf("x[%d]=\t%f\t+%fi\n", k,out_real[k],out_imag[k]);
}
return 0;
}