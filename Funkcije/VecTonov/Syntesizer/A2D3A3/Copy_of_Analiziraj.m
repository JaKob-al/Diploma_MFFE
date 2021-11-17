close all; clear;
fileinfo = dir('*.wav');
fnames = {fileinfo.name};
n = length(fnames)-1;  % Število posameznih tonov
sf = 44100;
spektri = zeros(length(n), 44100);
obdelaniSpektri = zeros(n, 44100);


% Analiza akorda
akord = audioread(string(fnames(n+1)));
okno = hann(length(akord));
oknjenAkord = okno .* akord;
oknjenAkord = audioNormalizationP(oknjenAkord, 0.9);
akordSpekter = abs(fft(oknjenAkord))/length(oknjenAkord);
akordSpekter = akordSpekter(1:length(akordSpekter)/2);
binsToFrequencies = (0 : length(akord)/2 -1) .* (sf/length(akord));

figure;
plot(binsToFrequencies, pow2db(akordSpekter));
obdelanAkord = akordSpekter;
nule = find(pow2db(obdelanAkord) < -25);
obdelanAkord(nule) = 0;
[aPeaks, aLocations] = findpeaks(obdelanAkord);
aPeaksFrequencies = binsToFrequencies(aLocations)';
obdelanAkord(:) = 0;
obdelanAkord(aLocations) = aPeaks;
figure;
plot(binsToFrequencies, obdelanAkord);


for i = 1:n
    ton = audioread(string(fnames(i)));
    okno = hann(length(ton));
    oknjenTon = okno .* ton;
    oknjenTon = audioNormalizationP(oknjenTon, 0.9);
    oknjenSpekter = abs(fft(oknjenTon))/length(oknjenTon);
    oknjenSpekter = oknjenSpekter(1:length(oknjenSpekter)/2);
    binsToFrequencies = (0 : length(ton)/2 -1) .* (sf/length(ton));

    spektri(i, :) = oknjenSpekter;
    obdelaniSpektri(i, :) = oknjenSpekter;
    nule = find(pow2db(spektri(i, :)) < -25);
    obdelaniSpektri(i, nule) = 0;
    [pks,locs] = findpeaks(obdelaniSpektri(i,:));
    pksFrequencies = binsToFrequencies(locs);
    
    % Poravnaj frekvence
    for t = 1:length(locs)
        for a = 1:length(aPeaksFrequencies)
            if(abs(1200*log2(pksFrequencies(t)/aPeaksFrequencies(a))) <= 50)
             locs(t) = aLocations(a);
             pksFrequencies(t) = aPeaksFrequencies(t);
            end
        end
    end
    obdelaniSpektri(i, :) = 0;
    obdelaniSpektri(i, locs) = pks;
    figure('Name', sprintf("%s", string(fnames(i))));
    plot(binsToFrequencies, ((obdelaniSpektri(i, :))));
    
    
end

odstevajociSpekter = obdelanAkord';

peaks = zeros(n, 10);
locations = zeros(n, 10);
for i  = 1:length(fnames)-1
    [pks, locs] = findpeaks(obdelaniSpektri(i, :));
    peaks(i, 1:length(pks)) = pks;
    locations(i, 1:length(locs)) = locs;
end

for i = 1:n
    figure('Name', sprintf('Akord [%s] - Ton [%s]', string(fnames(n+1)), string(fnames(i))));
    tiledlayout(3,1)
    
    % Prilagodi / Normaliziraj amplitudo posameznih tonov amplitudi akorda
    [oPeaks, oLocations] = findpeaks(odstevajociSpekter);
    odstraniIndexe = oPeaks <= 0;
    oPeaks(odstraniIndexe) = [];
    oLocations(odstraniIndexe) = [];
    frekvenca = binsToFrequencies(oLocations(1));
    fprintf("%s\n", string(frekvenca));
    
    faktor = peaks(i, 1)/oPeaks(1);
    
    
    
    
    nexttile
    plot(binsToFrequencies, odstevajociSpekter);
    nexttile
    plot(binsToFrequencies, obdelaniSpektri(i, :))
    odstevajociSpekter = odstevajociSpekter - obdelaniSpektri(i, :)/faktor;
    nexttile
    plot(binsToFrequencies, odstevajociSpekter)
    
end