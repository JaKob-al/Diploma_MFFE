function [Xspremenjen] = fnSpremeniFazo(X, faza)
N = length(X);
X = reshape(X, [1,N]); % Vektor vedno vrstični
Xspremenjen = [X(1), X(2:N/2)*exp(1i*faza), X(N/2+1), X(N/2+2:N)*exp(1i*(-faza))];
end

