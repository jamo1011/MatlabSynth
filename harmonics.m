function wave = harmonics(f, amplitudes, dur)

wave = zeros(1,dur*48000+1);
if ischar(f)
    f = findFreq(f);
end

for i = 1:length(amplitudes)
    wave = wave + sinWave(f*i, dur, amplitudes(i));
end


end