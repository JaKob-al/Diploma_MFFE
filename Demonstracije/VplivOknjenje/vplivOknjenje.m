% clear; 
% close all;
% okno = hann(44100);
% 
% plot(abs(fft(okno)));
% 
% sr = 44100;
% n = 0:sr-1;
% 
% k1 = sin(2*pi/sr*220.5*n -2.34);
% k2 = 0.2*sin(2*pi/sr*440.3*n);
% k3 = 0.1*sin(2*pi/sr*660.*n);
% k4 = 0.15*sin(2*pi/sr*880*n);
% 
% signal = k1+k2+k3+k4;
% signal = signal';
% 
% spekter = abs(fft(signal))/sr;
% spekter = spekter(1:sr/2);
% plot(spekter)
% figure;
% plot(mag2db(spekter))
% oknjenSignal = okno .* signal;
% 
% figure;
% oknjenSpekter = abs(fft(oknjenSignal))/sr;
% oknjenSpekter = oknjenSpekter(1:sr/2);
% plot(oknjenSpekter)
% figure;
% plot(mag2db(oknjenSpekter))
% 
close all
clear; 

M = 44100;
okno = flattopwin(M);
figure();
plot (okno);
L = length (okno); 
NFFT = 44100;
X1 = abs(fft(okno, NFFT));
figure();
plot (mag2db((X1(1:1000))), 'r' );


% clear;
% close all;
% 
% 
% 
% N = 400;
% okno = hann(N)';
% n = 0:N-1;
% signal = cos(2*pi/N *4.5 .* n);
% 
% plot(signal)
% oknjenSignal = okno .* signal;
% figure;
% plot(oknjenSignal)
% figure;
%  spekter = abs(fft(signal))/N;
% spekter = spekter(1:N/2);
% plot(spekter)
% figure;
% plot(mag2db(spekter))
% oknjenSignal = okno .* signal;
% 
% figure;
% oknjenSpekter = abs(fft(oknjenSignal))/N;
% oknjenSpekter = oknjenSpekter(1:N/2);
% plot(oknjenSpekter)
% figure;
% plot(mag2db(oknjenSpekter))
