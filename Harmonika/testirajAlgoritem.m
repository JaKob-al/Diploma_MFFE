clear; close all

fileinfo = dir('*.wav');
fnames = string({fileinfo.name});

tf = false(1, length(fnames))';
rezultati = strings(length(fnames), 3);

casi = zeros(1, length(fnames));
for i = 1:length(fnames)
    tic
    [a,b,c] = prepoznajAkord(fnames(i));
    casi(i) = toc;
    tf(i) = a;
    rezultati(i, 1) = b;
    rezultati(i, 2) = c;
    rezultati(i, 3) = string(a);
end

pravilnih = nnz(tf)/length(fnames);