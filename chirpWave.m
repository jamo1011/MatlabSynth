function wave = chirpWave(func, dur, harmonics)

    if nargin == 2
        harmonics = 1;
    end
        
    fh = str2func(['@(t)' func]);
    t = 0:1/48000:dur;
        
    wave = zeros(1, length(t));
    for i = 1:length(harmonics)
        wave = wave + abs(harmonics(i))*sin(fh(t).*t.*2*pi*i+angle(harmonics(i)));
    end
    
end