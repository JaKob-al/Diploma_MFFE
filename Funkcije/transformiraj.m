function spekter = transformiraj(signal,dolzina)
a = abs(fft(signal));
spekter = a(1:dolzina);
end

