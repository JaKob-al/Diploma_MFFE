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

sf = 44100;
spektri = zeros(n, sf/2);
okno = hann(sf);

for i = 1:n
    ton = okno .* audioread(fnames(i)); % preberi in okni ton
    spekter = abs(fft(ton))/sf;
    spekter = spekter(1:sf/2);
    [pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-60));
    if isempty(pks)
        fprintf("%d", i)
    end
    spektri(i, locs) = pks;
end

frekvenceOsnovnihTonov = zeros(1, n);
for i = 1:n
    frekvenceOsnovnihTonov(i) = find(spektri(i, :), 1);
end
    