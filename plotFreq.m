function plotFreq(data,fs, range)

subplot(2,1,1)
f = fft(data,fs);
plot(abs(f(1:range)))
subplot(2,1,2)
plot(angle(f(1:range)))


end