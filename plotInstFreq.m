%takes same freq input as createSound2
function plotInstFreq(freq, dur)

hold off
t = 0:1/48000:dur;
[freq, remain] = strtok(freq, ',');
hold on
if freq(1) >= 'A' && freq(1) <= 'G'
    note = ones(1,length(t)).*findFreq(freq);
    plot(t, note)
elseif freq(1) >= '1' && freq(1) <= '9'
    note = ones(1,length(t)).*str2num(freq);
    plot(t, note)
elseif freq(1) == 'f'
    fh = str2func(['@(t)' freq(6:end-1)]);
    plot(t, fh(t));
end

while ~isempty(remain)
    [freq, remain] = strtok(remain, ',');
    freq = strtrim(freq);
    if freq(1) >= 'A' && freq(1) <= 'G'
        note = ones(1,length(t)).*findFreq(freq);
        plot(t, note)
    elseif freq(1) >= '1' && freq(1) <= '9'
        note = ones(1,length(t)).*str2num(freq);
        plot(t, note)
    elseif freq(1) == 'f'
        fh = str2func(['@(t)' freq(6:end-1)]);
        plot(t, fh(t));
    end
end


end