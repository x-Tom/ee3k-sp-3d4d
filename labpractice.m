clear all
close all
N=7;
k=0:N-1;
alfa = (N-1)/2;
himpres = 0.2*sinc(0.2*k-alfa);
M=128;

HIMP=abs(fftshift(fft(himpres,M)));
HIMPtheta = angle(fftshift(fft(himpres,M)));
nu=-0.5:1/M:0.5-1/M;

plot(nu,HIMP);

smagnitud

target=ones(1,128);
target(nu<-0.1)=0;
target(nu>0.1)=0;

plot(nu,target);

error = abs(HIMP-target);
plot(nu,error)