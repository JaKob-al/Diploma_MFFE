function [tf, rezultat, pricakovani] = prepoznajAkord(imeDatoteke)

load("obdelano.mat");

sf = 44100;
okno = flattopwin(sf);
maxFrekvenca = frekvenceOsnovnihTonov(end);

akord = okno .* audioread(imeDatoteke);

spekter = abs(fft(akord))/sf;
spekter = spekter(1:round(maxFrekvenca/(2^(-50/1200))));
[pks, locs] = findpeaks(spekter, 'MinPeakHeight', db2mag(-65));
spekter(:) = 0;
spekter(locs) = pks;
plot(spekter)
akordIme = "";

akordTonskiSpekter = zeros(1, length(tonskiSpektri));

for i = 1:length(locs)
    frekvenca = locs(i) - 1;
    [~,iZaokrozenaFrekvenca] = (min(abs(1200*log2(frekvenceOsnovnihTonov/frekvenca))));
    akordTonskiSpekter(iZaokrozenaFrekvenca) = akordTonskiSpekter(iZaokrozenaFrekvenca) + pks(i);
end

% locs = find(akordTonskiSpekter>0);
% pks = akordTonskiSpekter(locs);
s = stem(akordTonskiSpekter);
row = dataTipTextRow('Ton',pitchNames);
s.DataTipTemplate.DataTipRows(end+1) = row;
yline(db2mag(-65))

while mag2db(max(akordTonskiSpekter)) > -55
    
%     figure;
%     tiledlayout(3,1)
%     nexttile;
%     s = stem(akordTonskiSpekter);
%     row = dataTipTextRow('Ton',pitchNames);
%     s.DataTipTemplate.DataTipRows(end+1) = row;

    locs = find(akordTonskiSpekter>0);  % LOKACIJE PEAKOV AKORDA
    pks = akordTonskiSpekter(locs);     % AMPLITUDE PEAKOV AKORDA
    iOsnovniTon = locs(1);              % TRENUTNI TON
    akordIme = append(akordIme, pitchNames(iOsnovniTon));
    faktor = pks(1) / tonskiSpektri(iOsnovniTon, iOsnovniTon);
    
    % Primerjaj z spektrom osnovnega tona
    locsTon = find(tonskiSpektri(iOsnovniTon, :) > 0);
    pksTon = faktor * tonskiSpektri(iOsnovniTon, locsTon);  % normaliziran
    pksAkordTon = akordTonskiSpekter(locsTon);
    
    for i = 1:length(locsTon)
        if pksTon(i) >= pksAkordTon(i)
            if pksTon(i)/pksAkordTon(i)  <= 1.2
                akordTonskiSpekter(locsTon(i)) = 0;
            else
%                 fprintf("Ton  %s harmonik %d Več kot 1.1 mogoče lahko napaka\n", pitchNames(locsTon(1)), i)
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
    
    
%     pks(1)= [];
%     locs(1) = [];

%     nexttile;
%     s = stem(tonskiSpektri(iOsnovniTon, :));
%     row = dataTipTextRow('Ton',pitchNames);
%     s.DataTipTemplate.DataTipRows(end+1) = row;
%     nexttile;
    
%     s = stem(akordTonskiSpekter);
%     row = dataTipTextRow('Ton',pitchNames);
%     s.DataTipTemplate.DataTipRows(end+1) = row;
    
end
rezultat = char(akordIme);
pricakovani =  char(imeDatoteke);
pricakovani = pricakovani(1:end-4);
tf = strcmp(rezultat, pricakovani);
end

