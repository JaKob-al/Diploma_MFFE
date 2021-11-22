% clear;
% 
% dolzine = logspace(3, 8, 20)*2.68;
% dolzine2 = [2^12, 2^17, 2^20, 2^24, 2^28];
% vseDolzine = round(sort([dolzine, dolzine2]));
% 
% signali = [];
% for i=1:length(vseDolzine)
%     signali{i} = [rand(1, vseDolzine(i))*2-1]; 
% end
% 
% N = 30; % število ponovitev
% casi = zeros(25, N);
% 
% for i=1:length(vseDolzine)
%     signal = cell2mat(signali(i));
%     for d=1:N
%     fprintf("%d %d\n", i, d);
%     tic
%     a = fft(signal);
%     casi(i, d) = toc;
%     end
% end

precisceniF = zeros(25,30);
for i = 1:25
    d = rmoutliers(casi(i, :));
    precisceniF(i, 1:length(d)) = d;
end

povprecniCasi = zeros(1,25);
for i = 1:25
    povprecniCasi(1, i) = mean(nonzeros(precisceniF(i, :)));
end


figure;
loglog(vseDolzine, povprecniCasi(1, :), 'x')
xlabel('Število vzorcev');
ylabel('Trajanje transformacije [s]')
ax = gca;
ax.XAxis.Exponent = 3;
xline(dolzine2, 'r')


