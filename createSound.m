%soundStruct parameters
%    -duration
%    -frequencies
%    -harmonicSigniture
%    -envelope

function wave = createSound(soundStruct)

duration = str2num(soundStruct.duration);
freq = soundStruct.frequencies;
harmonicSigniture = createSigniture(soundStruct.harmonicSigniture);
[str1, str2] = strtok(soundStruct.envelope, ';');
envelope = createEnvelope(str1, duration);
if ~isempty(str2)
    envelope = [envelope; createEnvelope(str2(2:end),duration)];
end

fs = 48000;
tt = 0:1/fs:duration;
wave = zeros(1,length(tt));
[freq, remain] = strtok(freq, ',');
if freq(1) >= 'A' && freq(1) <= 'G'
    note = freq;
    wave = wave + harmonics(note, harmonicSigniture, duration);
elseif freq(1) >= '1' && freq(1) <= '9'
    note = str2num(freq);
    wave = wave + harmonics(note, harmonicSigniture, duration);
elseif freq(1) == 'f'
    note = freq(6:end-1);
    wave = wave + chirpWave(note, duration, harmonicSigniture);
end

while ~isempty(remain)
    [freq, remain] = strtok(remain, ',');
    freq = strtrim(freq);
    if freq(1) >= 'A' && freq(1) <= 'G'
        note = freq;
        wave = wave + harmonics(note, harmonicSigniture, duration);
    elseif freq(1) >= '1' && freq(1) <= '9'
        note = str2num(freq);
        wave = wave + harmonics(note, harmonicSigniture, duration);
    elseif freq(1) == 'f'
        note = freq(6:end-1);
        wave = wave + chirpWave(note, duration, harmonicSigniture);
    end
end

wave = envelopeWave(wave,envelope);
wave = wave/max(wave);
end