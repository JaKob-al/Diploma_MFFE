clear;
close all;

load("PovprecniCasiSkupno.mat");
load("vseDolzine.mat");

figure;
plot(vseDolzine, povprecniCasi(1, :), 'x')
hold on
plot(vseDolzine, povprecniCasi(2, :), 'x')
xlabel('Število vzorcev');
ylabel('Trajanje transformacije [s]')
ax = gca;
ax.XAxis.Exponent = 3;
legend({'DFT','FFT'},'Location','northwest')


