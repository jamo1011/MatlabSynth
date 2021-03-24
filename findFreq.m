%Takes a cell array of note names.  Names are a letter and the octave
%number (ex.  [{'A4'}, {'C3'}, {'D#5'}])

function freq = findFreq(noteList)

freq = [];
notes = [{'C'}, {'C#'}, {'D'}, {'D#'}, {'E'}, {'F'}, {'F#'}, {'G'}, {'G#'}, {'A'}, {'A#'}, {'B'}];
frequencies = [16.3510, 17.3240, 18.3540, 19.4450, 20.6010, 21.8270, 23.1240, 24.4990, 25.9560, 27.5000, 29.1350, 30.8680];

if iscell(noteList)
    for i = 1:length(noteList)
        note = noteList{i};
        freq = [freq, frequencies(strcmp(note(1:end-1), notes))*2^str2num(note(end))];
    end
else
    freq = frequencies(strcmp(noteList(1:end-1), notes))*2^str2num(noteList(end));
end
    
end