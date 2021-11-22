close all; clear;
selpath = uigetdir;
cd(selpath);
fileinfo = dir('*.wav');
[~,index] = sortrows({fileinfo.date}.'); fileinfo = fileinfo(index); 

fnames = string({fileinfo.name});
clear index fileinfo selpath;
n = length(fnames);  % Število posameznih tonov

pitchNames = strings(1, n);
for i = 1:n
    fname = convertStringsToChars(fnames(i));
    pitchNames(i) = fname(1:length(fname)-4);
end
clear fname;

load("frekvenceOsnovnihTonov.mat")

sf = 44100;
okno = flattopwin(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);
tonskiSpektri = zeros(n, n);

for i = 1:n
    % preberi in okni posamezen ton
    ton = okno .* audioread(fnames(i));
    % izracunaj njegov amplitudni spekter in ga skrajsaj
    spekter = abs(fft(ton))/sf;
    spekter = spekter(1:round(maxFrekvenca/(2^(-50/1200))));
    % poisci vrhove
    [pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-65));
    %  poenostavljenemu diskretnemu tonskemu spektru pripisi amplitude
    for j =1:length(locs)
        % ker je dolzina posnetka enaka frekvenci vzorcenja
        % je frekvencna resolucija enaka 1 zato je tocna frekvenca
        % vrha enaka indeksu - 1:
        frekvenca = locs(j) - 1;
        % pristej vrh "najblizji tipki"
        [~,iZaokrozenaFrekvenca] = (min(abs(1200*log2(frekvenceOsnovnihTonov/frekvenca))));
        tonskiSpektri(i, iZaokrozenaFrekvenca) = tonskiSpektri(i, iZaokrozenaFrekvenca) + pks(j);
    end
end


save("..\obdelano.mat", 'tonskiSpektri', 'frekvenceOsnovnihTonov', 'pitchNames');

    