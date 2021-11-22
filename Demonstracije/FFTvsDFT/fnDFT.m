function [X]=fnDFT(x)  %vrne spekter
%def. osnovnih parametrov 
x=x(:);
N = length(x);
n=0:N-1;
W = zeros(N,N); 
% generacija matrike
for k=0:N-1
    W(k+1,:) = cos(2*pi/N*k .* n) - 1i*sin(2*pi/N*k .*n); %plus vmes za IDFT
end
% množenhe -> X
X = W*x;

