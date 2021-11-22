function [tf, rezultat, pricakovani] = prepoznajAkord(imeDatoteke)

load("obdelano.mat");

sf = 44100;
okno = flattopwin(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);

akord = okno .* audioread(imeDatoteke);

spekter = abs(fft(akord))/sf;
spekter = spekter(1:round(maxFrekvenca/(2^(-50/1200))));
[pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-65));
akordIme = "";

akordTonskiSpekter = zeros(1, length(tonskiSpektri));

for i = 1:length(locs)
    frekvenca = locs(i) - 1;
    [~,iZaokrozenaFrekvenca] = (min(abs(1200*log2(frekvenceOsnovnihTonov/frekvenca))));
    akordTonskiSpekter(iZaokrozenaFrekvenca) = akordTonskiSpekter(iZaokrozenaFrekvenca) + pks(i);
end

while mag2db(max(akordTonskiSpekter)) > -55
    % LOKACIJE PEAKOV AKORDA
    locs = find(akordTonskiSpekter>0);
    % AMPLITUDE PEAKOV AKORDA
    pks = akordTonskiSpekter(locs);  
    % TRENUTNI TON - 1. ton v akordu
    iOsnovniTon = locs(1);              
    akordIme = append(akordIme, pitchNames(iOsnovniTon));
    faktor = pks(1) / tonskiSpektri(iOsnovniTon, iOsnovniTon);
    
    % Indeksi vrhov v spektru posameznega tona
    locsTon = find(tonskiSpektri(iOsnovniTon, :) > 0);
    % Normaliziraj spekter trenutnega osnovnega tona
    pksTon = faktor * tonskiSpektri(iOsnovniTon, locsTon);
    % Poisci vrhove v akordu za primerjavo
    pksAkordTon = akordTonskiSpekter(locsTon);
    
    % Primerjava 
    for i = 1:length(locsTon)
        if pksTon(i) >= pksAkordTon(i)
            if pksTon(i)/pksAkordTon(i)  <= 1.2
                akordTonskiSpekter(locsTon(i)) = 0;
            else
                akordTonskiSpekter(locsTon(i)) = 0;
            end
            
        else
            if pksAkordTon(i)/pksTon(i)  <= 1.2
                akordTonskiSpekter(locsTon(i)) = 0;
            else
                akordTonskiSpekter(locsTon(i)) = akordTonskiSpekter(locsTon(i)) - 1*pksTon(i);
            end
        end
    end
    
end
rezultat = char(akordIme);
pricakovani =  char(imeDatoteke);
pricakovani = pricakovani(1:end-4);
tf = strcmp(rezultat, pricakovani);
end

