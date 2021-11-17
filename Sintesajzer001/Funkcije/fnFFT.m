function [X,A,phi] = fnFFT(signal)
X = fft(signal)/length(signal);
A = abs(X);
phi = atan2(imag(X), real(X));
phi(A <1e-9)=0;
phi(abs(phi) < 1e-9) = 0;
end

