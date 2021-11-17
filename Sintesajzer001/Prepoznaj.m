
clear, close all

load("frekvenceOsnovnihTonov.mat"); load("spektri.mat");

sf = 44100;
okno = hann(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);

akord = okno .* audioread("C4D4E4F4G4.wav");

spekter = abs(fft(akord))/sf;
spekter = spekter(1:sf/2);
[pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-65));
spekter(:) = 0;
spekter(locs) = pks;
plot(spekter(1:3000))
akordIme = "";
while max(mag2db(spekter)> -50)
% for i = 1:3
    frekvencaOsnovnegaTona = locs(1) - 1;
    akordIme = append(akordIme,  string(frekvencaVTon(frekvencaOsnovnegaTona, 442)));
    indeksFrekvence = find(frekvenceOsnovnihTonov == frekvencaOsnovnegaTona + 1);
    faktor = pks(1) / spektri(indeksFrekvence, frekvencaOsnovnegaTona + 1);
    pks(1)= [];
    locs(1) = [];
    spekter = spekter - (1 * spektri(indeksFrekvence, :)*faktor)';
    figure;
    plot(spekter(1:3000));
% end
end