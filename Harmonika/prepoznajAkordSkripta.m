
clear, close all

load("obdelano.mat");

sf = 44100;
okno = hann(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);

akord = okno .* audioread("G3D4G4.wav");

spekter = abs(fft(akord))/sf;
spekter = spekter(1:round(maxFrekvenca/(2^(-50/1200))));
[pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-65));

spekter(:) = 0;
spekter(locs) = pks;
plot(spekter)
yline(db2mag(-65))
akordIme = "";

akordTonskiSpekter = zeros(1, length(tonskiSpektri));

for i = 1:length(locs)
    frekvenca = locs(i) - 1;
    [~,iZaokrozenaFrekvenca] = (min(abs(1200*log2(frekvenceOsnovnihTonov/frekvenca))));
    akordTonskiSpekter(iZaokrozenaFrekvenca) = akordTonskiSpekter(iZaokrozenaFrekvenca) + pks(i);
end

figure;
% locs = find(akordTonskiSpekter>0);
% pks = akordTonskiSpekter(locs);
s = stem(akordTonskiSpekter);
row = dataTipTextRow('Ton',pitchNames);
s.DataTipTemplate.DataTipRows(end+1) = row;
% yline(db2mag(-65))

while mag2db(max(akordTonskiSpekter)) > -45
    
    figure;
    tiledlayout(3,1)
    nexttile;
    s = stem(18:61, akordTonskiSpekter(18:61));
    row = dataTipTextRow('Ton',pitchNames(18:61));
    s.DataTipTemplate.DataTipRows(end+1) = row;

    locs = find(akordTonskiSpekter>0);  % LOKACIJE PEAKOV AKORDA
    pks = akordTonskiSpekter(locs);     % AMPLITUDE PEAKOV AKORDA
    iOsnovniTon = locs(1);              % TRENUTNI TON
    akordIme = append(akordIme, pitchNames(iOsnovniTon));
    faktor = pks(1) / tonskiSpektri(iOsnovniTon, iOsnovniTon);
    
    % Spekter trenutnega osnovnega tona
    locsTon = find(tonskiSpektri(iOsnovniTon, :) > 0);
    pksTon = faktor * tonskiSpektri(iOsnovniTon, locsTon);  % normaliziran
    % Primerjaj z spektrom osnovnega tona
    pksAkordTon = akordTonskiSpekter(locsTon);
    
    for i = 1:length(locsTon)
        if pksTon(i) >= pksAkordTon(i)
            if pksTon(i)/pksAkordTon(i)  <= 1.2
                akordTonskiSpekter(locsTon(i)) = 0;
            else
                fprintf("Ton  %s harmonik %d Več kot 1.1 mogoče lahko napaka\n", pitchNames(locsTon(1)), i)
                akordTonskiSpekter(locsTon(i)) = 0;
            end
            
        else
            if pksAkordTon(i)/pksTon(i)  <= 1.2
                akordTonskiSpekter(locsTon(i)) = 0;
            else
                akordTonskiSpekter(locsTon(i)) = akordTonskiSpekter(locsTon(i)) - 1.2*pksTon(i);
            end
        end
    end
    
   
    nexttile;
    s = stem(18:61, tonskiSpektri(iOsnovniTon, 18:61)*faktor);
    row = dataTipTextRow('Ton',pitchNames(18:61));
    s.DataTipTemplate.DataTipRows(end+1) = row;
    nexttile;
    
    s = stem(18:61, akordTonskiSpekter(18:61));
    row = dataTipTextRow('Ton',pitchNames(18:61));
    s.DataTipTemplate.DataTipRows(end+1) = row;
    
end