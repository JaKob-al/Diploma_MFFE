% Koda za snemanje tonov
load('imenaTonov.mat');
zacetniTon = input('Vnesi začetni ton\n', 's');
steviloTonov = input('Vnesi število tonskih višin\n');

indeksZacetka = find(toni == zacetniTon);

Fs = 44100 ; 
nBits = 16 ; 
nChannels = 1;
recObj = audiorecorder(Fs, nBits, nChannels);

for i = 0:steviloTonov-1
    disp('Press any key to start recording ' + toni(indeksZacetka+i))
    pause;
    recordblocking(recObj, 2.5);
    audioarray = getaudiodata(recObj);
    audioarray = audioNormalizationP(audioarray, 0.5);
    zacetekTona = find(abs(audioarray) > 0.1, 1);  % poiščemo začetek tona
    audiowrite(strcat(string(toni(indeksZacetka+i)), '.wav'), audioarray(zacetekTona:zacetekTona+Fs-1), Fs)
end
    
    
    