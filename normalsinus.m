clear all;
%Load signal from MIT-BIH normal sinus rhythm database
D=load('16420m.mat');
fs=250;                    
Ts = 1/fs; 
EKG=D.val;

EKGSignal=EKG/200;
N=length(EKG);
t=(0:length(EKGSignal)-1)/fs;

figure;
subplot(211);
plot(t,EKGSignal);
title('Normal sinus rhythm');
%Plot the frequency spectrum of signal
y=fft(EKGSignal);
K=length(y);
k=1:K;
frequency=k*fs/K;
subplot(212);
plot(abs(y));
title('Frequency spectrum of normal sinus rhythm');
xlabel('Frequency(Hz)');
ylabel('Magnitude');



iy=ifft(y);
output=real(iy);

figure;
wave=EKGSignal(232:300);
subplot(611);
plot(wave);
title('Single waveform of normal sinus rhythm');
%Four layer discrete wavelet transform and plots
[c,l] = wavedec(wave,4,'sym4');
approx = appcoef(c,l,'sym4');
cd1 = detcoef(c,l,1);
cd2 = detcoef(c,l,2);
cd3 = detcoef(c,l,3);
cd4 = detcoef(c,l,4);
subplot(6,1,2);
plot(approx);
title('Approximation Coefficients');
subplot(6,1,3);
plot(cd4);
title('Level 4 Detail Coefficients');
subplot(6,1,4);
plot(cd3);
title('Level 3 Detail Coefficients');
subplot(6,1,5);
plot(cd2);
title('Level 2 Detail Coefficients');
subplot(6,1,6);
plot(cd1);
title('Level 1 Detail Coefficients');


A4 = zeros(1,length(approx));
A4 = wrcoef('a',c,l,'sym4');
%a4 = idwt(A4,D4,'sym4');
xdft = fft(A4);
figure;subplot(211);plot(A4);
title('Reconstructed signal of sinus rhythm');
%xdft = fft(A4);
figure;
subplot(211);
plot(abs(xdft));
title('FFT of the reconstructed sinus rhythm signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

