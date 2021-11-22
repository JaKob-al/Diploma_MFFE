% Koda za snemanje tonov
Fs = 44100 ; 
nBits = 16 ; 
nChannels = 1;
recObj = audiorecorder(Fs, nBits, nChannels);
steviloInstrumentov = input('Vnesi število inštrumentov');
instrumenti = strings(steviloInstrumentov);
ton = input('Vnesi ton', 's');
mkdir(ton)
for i = 1:steviloInstrumentov
    instrument = input('Vnesi ' + string(i)+ '. inštrument', 's');
    instrumenti(i) = instrument;
end

for i = 1:steviloInstrumentov
    disp('Press any key to start recording ' + instrumenti(i))
    pause;
    recordblocking(recObj, 1.5);
    audioarray = getaudiodata(recObj);
    audiowrite(strcat(ton, "/", instrumenti(i), ...
        '.wav'), audioarray(22050:end-1), Fs)
end
