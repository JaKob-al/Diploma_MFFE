close all; clear;
selpath = uigetdir;
cd(selpath);
fileinfo = dir('*.wav');
[~,index] = sortrows({fileinfo.name}.'); fileinfo = fileinfo(index); 

fnames = string({fileinfo.name});
clear index fileinfo selpath;
n = length(fnames);  % Število posameznih tonov

pitchNames = strings(1, n);
for i = 1:n
    fname = convertStringsToChars(fnames(i));
    pitchNames(i) = fname(3:length(fname)-4);
end
clear fname;

load("frekvenceOsnovnihTonov.mat")

sf = 44100;
okno = flattopwin(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);
tonskiSpektri = zeros(n, n);

for i = 1:n
    ton = okno .* audioread(fnames(i)); % preberi in okni ton
    spekter = abs(fft(ton))/sf;
    spekter = spekter(1:round(maxFrekvenca/(2^(-50/1200))));
    [pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-60));
    if isempty(pks)
        fprintf("%d ton nima dovolj peaka", i)
        break;
    end
    % diskretnemu tonskemu spektru pripiši amplitude
    for j =1:length(locs)
        frekvenca = locs(j) - 1;
        [~,iZaokrozenaFrekvenca] = (min(abs(1200*log2(frekvenceOsnovnihTonov/frekvenca))));
        fprintf("%d\n", iZaokrozenaFrekvenca);
        tonskiSpektri(i, iZaokrozenaFrekvenca) = tonskiSpektri(i, iZaokrozenaFrekvenca) + pks(j);
%         fprintf("%s", frekvencaVTon(frekvenceOsnovnihTonov(iZaokrozenaFrekvenca),442))
    end
end


save("..\obdelano.mat", 'tonskiSpektri', 'frekvenceOsnovnihTonov', 'pitchNames');

    