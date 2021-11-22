clear; close all;
% Koda za snemanje tonov
load('imenaVsehTonov.mat');
zacetniTon = input('Vnesi začetni ton\n', 's');
steviloTonov = input('Vnesi število tonskih višin\n');

indeksZacetka = find(imenaVsehTonov == zacetniTon);

Fs = 44100 ; 
nBits = 16 ; 
nChannels = 1;
recObj = audiorecorder(Fs, nBits, nChannels);

mkdir("Toni")

for i = 0:steviloTonov-1
    disp('Press any key to start recording ' + imenaVsehTonov(indeksZacetka+i))
    pause;
    recordblocking(recObj, 2.5);
    audioarray = getaudiodata(recObj);
    audioarray = audioNormalizationP(audioarray, 0.5);
    zacetekTona = find(abs(audioarray) > 0.1, 1);  % poiščemo začetek tona
    audiowrite(strcat("Toni/", string(imenaVsehTonov(indeksZacetka+i)), '.wav'), audioarray(zacetekTona:zacetekTona+Fs-1), Fs)
end
    
    
    