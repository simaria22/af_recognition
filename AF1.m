clear all;
%Load signal from MIT-BIH atrial fibrillation database
D=load('04015m.mat')
fs=250;                    
Ts = 1/fs; 
AF=D.val;

N=length(AF);
AFSignal=AF/200;
t=(0:length(AFSignal)-1)/(2*fs);

%Plot signal
figure;
subplot(211);
plot(t,AFSignal);
title('Atrial fibrillation signal');

%Frequency spectrum of signal
y=fft(AFSignal);
K=length(y);
k=1:K;
frequency=k*fs/K;
mag=abs(y);
subplot(2,1,2);
plot(frequency,mag);
title('Frequency Spectrum');
xlabel('Frequency(Hz)');
ylabel('Magnitude');


%Reduse the noise
L=150;
sx=smooth(AFSignal,L)';
filtered_AF=AFSignal-sx;

%Turn in the time domain to see the filtered signal
%iy=ifft(y);
figure;
subplot(211);
plot(t,AFSignal);
title('Original AF signal');
subplot(212);
plot(t,filtered_AF);
title('Filtered AF signal');

%Four layer discrete wavelet transform and plots
figure;
waveform=filtered_AF(355:450);
subplot(611);
plot(waveform);
title('Single waveform of AF signal');

[c,l] = wavedec(waveform,4,'sym4');
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

A4 = wrcoef('a',c,l,'sym4');
A4 = detrend(A4,0);
figure; subplot(211); plot(A4);
title('Reconstructed waveform of AF signal');
xdft = fft(A4);
figure; subplot(211); plot(abs(xdft));
title('FFT of the AF reconstructed signal');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
