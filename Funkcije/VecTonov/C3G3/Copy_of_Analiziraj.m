close all;
fileinfo = dir('*.wav');
fnames = {fileinfo.name};
sf = 44100;
spektri = zeros(length(fnames), 44100);
obdelaniSpektri = zeros(length(fnames), 44100);
for i = 1:length(fnames)
    zvok = audioread(string(fnames(i)));
    okno = hann(length(zvok));
    spekter = abs(fft(zvok))/length(zvok);
    spekter = spekter(1:length(spekter)/2);
    oknjenZvok = okno .* zvok;
    oknjenZvok = audioNormalizationP(oknjenZvok, 0.9);
    oknjenSpekter = abs(fft(oknjenZvok))/length(oknjenZvok);
    oknjenSpekter = oknjenSpekter(1:length(oknjenSpekter)/2);
    fig = figure('Name', sprintf('%s', string(fnames(i))));
    binsToFrequencies = (0 : length(zvok)/2 -1) .* (sf/length(zvok));
    plot(binsToFrequencies, pow2db(oknjenSpekter));

    
    
    
    
    spektri(i, :) = oknjenSpekter;
    obdelaniSpektri(i, :) = oknjenSpekter;
    nule = find(pow2db(spektri(i, :)) < -25);
    obdelaniSpektri(i, nule) = 0;
    [pks,locs] = findpeaks(obdelaniSpektri(i,:));
    obdelaniSpektri(i, :) = 0;
    obdelaniSpektri(i, locs) = pks;
    figure;
    plot(binsToFrequencies, ((obdelaniSpektri(i, :))));
    
    
end

for i = 1
    figure;
    tiledlayout(2,2)
    title('Plot 1')
    nexttile
    plot(binsToFrequencies, obdelaniSpektri(length(fnames), :))
    hold on
    plot(binsToFrequencies, obdelaniSpektri(i, :))
    
    nexttile
    plot(binsToFrequencies,obdelaniSpektri(3, :) - obdelaniSpektri(i, :))
    title('Plot 2')
    
    nexttile
    plot(binsToFrequencies, obdelaniSpektri(3, :) - obdelaniSpektri(i, :))
    title('Plot 3')
    hold on
    plot(binsToFrequencies, obdelaniSpektri(i+1, :))
    
    nexttile
    plot(binsToFrequencies, obdelaniSpektri(3, :) - obdelaniSpektri(i, :)-  obdelaniSpektri(i+1, :) )
    title('Plot 3')
    
end    
% frequencyResolution = Fs/length(zvok)
    