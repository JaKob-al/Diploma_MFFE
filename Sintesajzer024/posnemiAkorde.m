
Fs = 44100 ; 
nBits = 16 ; 
nChannels = 1;
recObj = audiorecorder(Fs, nBits, nChannels);

akordIme = input('Vnesi ime akorda', 's');

disp('Press any key to start recording chord ' + string(akordIme))
    pause;
    recordblocking(recObj, 2.5);
    audioarray = getaudiodata(recObj);
    audioarray = audioNormalizationP(audioarray, 0.5);
    zacetekTona = find(abs(audioarray) > 0.1, 1);  % poiščemo začetek tona
    audiowrite(strcat(akordIme, '.wav'), audioarray(zacetekTona:zacetekTona+Fs-1) , Fs);