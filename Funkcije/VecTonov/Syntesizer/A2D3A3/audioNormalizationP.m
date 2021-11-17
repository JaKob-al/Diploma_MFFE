function out = audioNormalizationP(in, maxAmp)
%AUDIONORMALIZATIONP Summary of this function goes here
%   Detailed explanation goes here
    out = zeros(1, length(in));
    if (maxAmp > 1 || maxAmp < 0)
        fprintf('maxAmp error')
    else
        [~, X] = max(abs(in));
%         fprintf("%d", in(X))
        out = -in*(maxAmp/in(X));
    end
end


