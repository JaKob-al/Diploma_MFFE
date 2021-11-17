% Koda za snemanje tonov
Fs = 44100 ; 
nBits = 16 ; 
nChannels = 1;
recObj = audiorecorder(Fs, nBits, nChannels);
steviloTonov = input('Vnesi število tonov');
toni = strings(steviloTonov+1);
for i = 1:steviloTonov
    ton = input('Vnesi ' + string(i)+ '. ton', 's');
    toni(i) = ton;
end
akord = strjoin(toni, '');
mkdir(akord)




for i = 1:steviloTonov
    disp('Press any key to start recording ' + toni(i))
    pause;
    recordblocking(recObj, 2.5);
    audioarray = getaudiodata(recObj);
    audiowrite(strcat(akord, '/', string(i), toni(i), ...
        '.wav'), audioarray(22050:end-1), Fs)
end
disp('Press any key to start recording chord ' + akord)
    pause;
    recordblocking(recObj, 2.5);
    audioarray = getaudiodata(recObj);
    audiowrite(strcat(akord, '/', akord, ...
        '.wav'), audioarray(22050:end-1), Fs)