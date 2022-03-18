clear all;
D=load('cu21m.mat')

fs=250;
Ts = 1/fs; 
VF=D.val;
N=length(VF);
VFSignal=VF/400;
t=(0:length(VFSignal)-1)/fs;
plot(t,VFSignal);

%[fre,mag,pha]=fftFun(AFSignal,fs);
y=fft(VFSignal);
figure;
subplot(311);
plot(t,VFSignal);
title('Original VT signal');
subplot(312);
mag=abs(y);
K=length(y);
k=1:K;
fre=k*fs/K;
plot(fre,mag);



L=100;
sx=smooth(VFSignal,L)';
xx=VFSignal-sx;
yy=fft(xx);
magnitude2=abs(yy);
subplot(313);
plot(fre,magnitude2);

cutoff1Hz=10;
cutoff2Hz=25;
cutoff2=2*cutoff2Hz/fs;
cutoff1=2*cutoff1Hz/fs;
M=100;
f=[0 cutoff1 cutoff1 cutoff2 cutoff2 1];
m=[1 1 0 0 1 1];
h=fir2(M,f,m);
y1=conv(h,xx);
y2=fft(y1);
K=length(y2);
k=1:K;
frequency=k*fs/K;
magnitude2=abs(y2);
figure;
plot(frequency,magnitude2);


figure;
subplot(211);
plot(t,VTSignal); title('Original VF signal');
subplot(212);
plot(y1); title('VF filtered signal');
axis([1000 2500 -2 2]);
figure;
output=y1(1000:2500);
acf=autocorr(y1,'NumLags',2499,'NumSTD',3);
plot(t,acf); title('Autocorrelation function of VF signal');