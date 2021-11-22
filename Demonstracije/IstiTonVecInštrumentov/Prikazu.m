close all; clear;
selpath = uigetdir;
cd(selpath);
fileinfo = dir('*.wav');
fnames = {fileinfo.name};
n = length(fnames);
sf = 44100;

instruments = zeros(n, 44100);
spektri = zeros(n, 22050);
for i=1:n
    instruments(i, :) = audioread(string(fnames(i)));
    spekter = abs(fft(instruments(i, :)))/44100;
    spektri(i, :) = spekter(1:length(spekter)/2);
end


tiledlayout(n,1)
for i=1:n
    ime = char(fnames(i));
    ime = ime(1:end - 4)
%     nexttile
%     plot(instruments(i, 1:500));
%     set(gca,'XTick',[], 'YTick', [])
%     title(strcat("Waveform ", ime))
    
    nexttile
    plot(pow2db(spektri(i, 1:10000)));
    set(gca,'XTick',[], 'YTick', [])
    title(strcat("Spekter ", ime))
end