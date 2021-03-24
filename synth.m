%structArray fields:
%   -name
%   -type (sound or effect)
%   -parameters (see createSound)

function synth(structArray)

    defaultSound.name = 'New Sound';
    defaultSound.type = 'sound';
    defaultSound.parameters.duration = '4';
    defaultSound.parameters.frequencies = 'C4, E4, G4';
    defaultSound.parameters.harmonicSigniture = '1';
    defaultSound.parameters.envelope = '1,1';
    
if nargin == 0
    structArray = defaultSound;
end


fig = figure('NumberTitle', 'off', 'Name', 'Noise Maker', 'Position', [200, 200, 900, 500]);
controlPanel = uipanel('Position', [0, .5, .2, .5]);
plotPanel = uipanel('Position', [.2, .5, .8, .5]);
plotAxes = axes('Parent', plotPanel, 'Units', 'normalized', 'Position', [.1, .1, .8, .8]);
parameterPanel = uipanel('Position', [0, 0, 1, .5]);


select = uicontrol('Parent', controlPanel, 'Style', 'popupmenu', 'Units', 'normalized', 'Position', [.03, .85, .8, .1], 'String', {'*New Sound', '*New Effect'});
for i=1:length(structArray)
    select.String = [{structArray(i).name}; select.String];
end
select.Callback = @select_Callback;

soundName = uicontrol('Parent', controlPanel, 'Style', 'edit', 'Units', 'normalized', 'Position', [.03, .7, .8, .08]);
soundName.String = structArray(select.Value).name;
soundName.Callback = @soundName_Callback;

durationBox = uicontrol('Parent', controlPanel, 'Style', 'edit', 'Units', 'normalized', 'Position', [.03, .6, .15, .08]);
durationBox.String = structArray(select.Value).parameters.duration;
durationBox.Callback = @durationBox_Callback;

saveButton = uicontrol('Parent', controlPanel, 'Style', 'pushbutton', 'Units', 'normalized', 'Position', [.05, .05, .4, .08], 'String', 'Save');
saveButton.Callback = @saveButton_Callback;

exportButton = uicontrol('Parent', controlPanel, 'Style', 'pushbutton', 'Units', 'normalized', 'Position', [.55, .05, .4, .08], 'String', 'Export');
exportButton.Callback = @exportButton_Callback;

runButton = uicontrol('Parent', plotPanel, 'Style', 'pushbutton', 'String', 'Create Sound', 'Units', 'normalized', 'Position', [.40, .9, .2, .1]);
runButton.Callback = @runButton_Callback;

runButton_Callback();
select_Callback();

    function wave = run()
        set(fig, 'CurrentAxes', plotAxes)
        
        wave = [];
        for j = 1:length(structArray)
            sound = createSound(structArray(j).parameters);
            sound = sound/max(sound);
            if length(sound) > length(wave)
                wave = [wave, zeros(1, length(sound)-length(wave))];
            elseif length(wave) > length(sound)
                sound = [sound, zeros(1, length(wave) - length(sound))];
            end
            wave = wave + sound;
        end
        plot(wave);
        axis off
        
        soundsc(wave,48000)
    end
    function runButton_Callback(hObject, event)
        run();
    end
    function select_Callback(hObject, event)
        
        if strcmp(select.String{select.Value}, '*New Sound')
            newSound = defaultSound;
            newSound.name = [newSound.name, num2str(length(structArray)+1)];
            structArray = [structArray, newSound];
            select.String = [select.String(1:end-2); newSound.name; select.String(end-1:end)];
            select.Value = length(structArray);
            select_Callback();
        elseif strcmp(select.String{select.Value}, '*New Effect')
            
        else
            children = allchild(parameterPanel);
            delete(children);
        
            struct = [];
            for j = 1:length(structArray)
                if strcmp(structArray(j).name, select.String{select.Value})
                    struct = structArray(j);
                end
            end
        
            if strcmp(struct.type, 'sound')
                setupSoundGUI(struct);
            end
            soundName.String = struct.name;
        end
            
    end
    function setupSoundGUI(struct)
        freqPanel = uipanel('Parent', parameterPanel, 'Title', 'Frequencies', 'Position', [0, 0, .333, 1]);
        freqAxes = axes('Parent', freqPanel, 'Position', [.1, .1, .8, .7], 'Color', 'none');
        harmPanel = uipanel('Parent', parameterPanel,'Title', 'Harmonics', 'Position', [.334, 0, .333, 1]);
        harmAxes = axes('Parent', harmPanel, 'Units', 'normalized', 'Position', [.1, .1, .8, .7]);
        envePanel = uipanel('Parent', parameterPanel, 'Title', 'Envelope', 'Position', [.667, 0, .333, 1]);
        enveAxes = axes('Parent', envePanel, 'Units', 'normalized', 'Position', [.1, .1, .8, .7]);
        
        freqInput = uicontrol('Parent', freqPanel, 'Style', 'edit', 'Units', 'normalized', 'Position', [.03, .85, .4, .1]);
        freqInput.Callback = @freqInput_Callback;
        freqInput.String = struct.parameters.frequencies;
        freqInput_Callback();
        
        harmonicInput = uicontrol('Parent', harmPanel, 'Style', 'edit', 'Units', 'normalized', 'Position', [.03, .85, .4, .1]);
        harmonicInput.Callback = @harmonicInput_Callback;
        harmonicInput.String = struct.parameters.harmonicSigniture;
        harmonicInput_Callback();
        
        envelopeInput = uicontrol('Parent', envePanel, 'Style', 'edit', 'Units', 'normalized', 'Position', [.03, .85, .4, .1]);
        envelopeInput.Callback = @envelopeInput_Callback;
        envelopeInput.String = struct.parameters.envelope;
        envelopeInput_Callback();
        
        function freqInput_Callback(hObject, eventdata, handles)
            set(fig, 'CurrentAxes', freqAxes);
            cla
            plotInstFreq(freqInput.String, str2num(struct.parameters.duration));
            structArray(select.Value).parameters.frequencies = freqInput.String;
        end       
        function harmonicInput_Callback(hObject, eventdata, handles)
                   
            h = createSigniture(harmonicInput.String);
            set(fig, 'CurrentAxes', harmAxes);
            h = abs(h);
            stem(h)
            axis off       
            axis tight manual       
 
            for k=1:length(h)
                points(k) = impoint(harmAxes, [k, h(k)]);
                fcn = makeConstrainToRectFcn('impoint', [k,k], get(harmAxes, 'Ylim'));
                setPositionConstraintFcn(points(k), fcn);
                setColor(points(k), 'red')
                addNewPositionCallback(points(k),@movePointCallback);
            end        
            
            structArray(select.Value).parameters.harmonicSigniture = harmonicInput.String;
        end
        function movePointCallback(hObject, eventdata, handles)
            children = allchild(harmAxes);
            str = [];
            for k = length(children)-1:-1:1
                str = [str num2str(children(k).Children(1).YData) ', '];
            end
            str = str(1:end-2);
            harmonicInput.String = str;
            structArray(select.Value).parameters.harmonicSigniture = harmonicInput.String;            
        end
        function envelopeInput_Callback(hObject, eventdata, handles)
            envelope = createEnvelope(envelopeInput.String, str2num(durationBox.String));
            set(fig, 'CurrentAxes', enveAxes);
            stem(envelope)
            axis off       
            axis tight manual       
 
            for k=1:length(envelope)
                points(k) = impoint(enveAxes, [k, envelope(k)]);
                fcn = makeConstrainToRectFcn('impoint', [k,k], get(enveAxes, 'Ylim'));
                setPositionConstraintFcn(points(k), fcn);
                setColor(points(k), 'green')
                addNewPositionCallback(points(k),@movePointCallback_enve);
            end   
                       
            structArray(select.Value).parameters.envelope = envelopeInput.String;
        end
        function movePointCallback_enve(hObject, eventdata, handles)
            children = allchild(enveAxes);
            str = [];
            for k = length(children)-1:-1:1
                str = [str num2str(children(k).Children(1).YData) ', '];
            end
            str = str(1:end-2);
            envelopeInput.String = str;
            structArray(select.Value).parameters.envelope = envelopeInput.String; 
        end
    end
    function soundName_Callback(hObject, event)
        structArray(select.Value).name = soundName.String;
        select.String{select.Value} = soundName.String;
    end
    function durationBox_Callback(hObject, event)
        structArray(select.Value).parameters.duration = durationBox.String;
    end
    function saveButton_Callback(hObject, event)
        save('sound.mat', 'structArray');
    end
    function exportButton_Callback(hOject, event)
        wave = run();
        audiowrite('sound.wav', wave, 48000);
    end
        
end