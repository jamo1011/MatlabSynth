%Creates a chord with given cell array of notes or array of frequencies
function [wave, lowestFreq] = chord(notes, dur, h)

fs = 48000;
f = notes;

if iscell(f)
    f = findFreq(f);  
end

lowestFreq = min(f);

wave = zeros(1, dur*fs+1);
for i = 1:length(f)
   wave = wave + harmonics(f(i), h, dur);
end

end