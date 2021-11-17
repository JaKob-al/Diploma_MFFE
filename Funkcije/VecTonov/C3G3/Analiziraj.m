close all;
fileinfo = dir('*.wav');
fnames = {fileinfo.name};
sf = 44100;
spektri = zeros(length(fnames), 44100);
for i = 1:length(fnames)
    zvok = audioread(string(fnames(i)));
    okno = hann(length(zvok));
    spekter = abs(fft(zvok))/length(zvok);
    spekter = spekter(1:length(spekter)/2);
    oknjenZvok = okno .* zvok;
    oknjenZvok = audioNormalizationP(oknjenZvok, 0.9);
    oknjenSpekter = abs(fft(oknjenZvok))/length(oknjenZvok);
    oknjenSpekter = oknjenSpekter(1:length(oknjenSpekter)/2);
%     plot(spekter);
    fig = figure('Name', sprintf('%s', string(fnames(i))), 'DeleteFcn','doc datacursormode');
    binsToFrequencies = (0 : length(zvok)/2 -1) .* (sf/length(zvok));
    toni = strings(1, length(binsToFrequencies));
%     for j = 1:length(binsToFrequencies)
%         toni(j) = frekvencaVTon(binsToFrequencies(j), 442);
%     end
    p = plot(binsToFrequencies, pow2db(oknjenSpekter));
    dcm_obj = datacursormode(fig);
    set(dcm_obj,'UpdateFcn',{@myupdatefcn,t})
    dtt = p.DataTipTemplate;
    dtt.DataTipRows(1).Label = 'Frekvenca';
    dtt.DataTipRows(2).Label = 'Moč';
%     row = dataTipTextRow('Ton', repmat({'yeehaw'},numel(p.XData),1));
    
    
    
    
    spektri(i, :) = oknjenSpekter;
end
% frequencyResolution = Fs/length(zvok)
    