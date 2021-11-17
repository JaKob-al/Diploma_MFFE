clear; close all

fileinfo = dir('*.wav');
fnames = string({fileinfo.name});

tf = false(1, length(fnames))';
rezultati = strings(length(fnames), 3);

for i = 1:length(fnames)
    [a,b,c] = prepoznajAkord(fnames(i));
    tf(i) = a;
    rezultati(i, 1) = b;
    rezultati(i, 2) = c;
    rezultati(i, 3) = string(a);
end

pravilnih = nnz(tf)/length(fnames);