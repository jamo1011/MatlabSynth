%f - frequency(number or letter with octave),  A - complex amplitude
%dur - duration,  type - type of wave('sin', 'tri', 'saw')
function wave = sinWave(f, dur, A, type)

fs = 48000;
tt = 0:1/fs:dur;

if nargin == 2
    A = 1;
    type = 'sin';
end

if nargin == 3
    type = 'sin';
end

if ischar(f)
    f = findFreq(f);
end

switch type
    case 'sin'
        wave = abs(A)*sin(2*pi*f*tt+angle(A));
    case 'tri'
        wave = abs(A)*sawtooth(2*pi*f*tt+angle(A), .5);
    case 'saw'
        wave = abs(A)*sawtooth(2*pi*f*tt+angle(A));
        
end

end

