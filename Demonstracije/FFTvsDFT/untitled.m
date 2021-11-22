% casi = struct2array(load("casi.mat"));
% casiD = reshape(casi(1, :, :), [25,10]);
% casiF = reshape(casi(2, :, :), [25,10]);
% 
% casi1 = struct2array(load("casi1.mat"));
% casi1D = reshape(casi1(1, :, :), [25,20]);
% casi1F = reshape(casi1(2, :, :), [25,20]);
% 
% vsiCasiD  = [casiD, casi1D];
% vsiCasiF  = [casiF, casi1F];
% clear;
% close all
% 
% dolzine = linspace(1000, 20000, 20);
% dolzine2 = [2^10,2^11, 2^12, 2^13, 2^14];
% 
% vseDolzine = round(sort([dolzine, dolzine2]));
% 
% signali = [];
% 
% for i=1:length(vseDolzine)
%     signali{i} = [rand(1, vseDolzine(i))*2-1]; 
% end
% 
% povprecniCasi = zeros(2,25);
% N = 30; % število ponovitev
% casi = zeros(2,25,N);
% 
% for i=1:length(vseDolzine)
%     signal = cell2mat(signali(i));
%     skupniCas = 0;
%     for d=1:N
%     fprintf("%d %d\n", i, d);
%     tic
%     a = fnDFT(signal);
%     casi(1, i, d) = toc;
%     skupniCas = skupniCas + casi(1, i, d);
%     end
%     povprecniCasi(1, i) = skupniCas/N;
%     skupniCas = 0;
%     for d=1:N
%     fprintf("fft %d %d\n", i, d);
%     tic
%     a = fft(signal);
%     casi(2, i, d) = toc;
%     skupniCas = skupniCas + casi(2, i, d);
%     end
%     povprecniCasi(2, i) = skupniCas/N;
% end

% figure;
% plot(vseDolzine, povprecniCasi(1, :), 'x')
% hold on
% plot(vseDolzine, povprecniCasi(2, :), 'x')


% statistično ocisti in povpreci

precisceniD = zeros(25,30);
precisceniF = zeros(25,30);
for i = 1:25
    d = rmoutliers(casiD(i, :));
    precisceniD(i, 1:length(d)) = d;
    f = rmoutliers(casiF(i, :));
    precisceniF(i, 1:length(f)) = f;
end

povprecniCasi = zeros(2,25);
for i = 1:25
    povprecniCasi(1, i) = mean(nonzeros(precisceniD(i, :)));
    povprecniCasi(2, i) = mean(nonzeros(precisceniF(i, :)));
end


