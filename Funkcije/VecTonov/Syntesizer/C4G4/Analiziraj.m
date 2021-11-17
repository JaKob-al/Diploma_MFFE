close all;
fileinfo = dir('*.wav');
fnames = {fileinfo.name};
sf = 44100;
spektri = zeros(length(fnames), 44100);
for i = 1:length(fnames)
    zvok = audioread(string(fnames(i)));
    okno = hann(length(zvok));
    spekter = abs(fft(zvok))/length(zvok);
    spekter = spekter(1:length(spekter)/2);
    oknjenZvok = okno .* zvok;
    oknjenZvok = audioNormalizationP(oknjenZvok, 0.9);
    oknjenSpekter = abs(fft(oknjenZvok))/length(oknjenZvok);
    oknjenSpekter = oknjenSpekter(1:length(oknjenSpekter)/2);
%     plot(spekter);
    fig = figure('Name', sprintf('%s', string(fnames(i))), 'DeleteFcn','doc datacursormode');
    binsToFrequencies = (0 : length(zvok)/2 -1) .* (sf/length(zvok));
    
    
    
    
    spektri(i, :) = oknjenSpekter;
end
% frequencyResolution = Fs/length(zvok)
    