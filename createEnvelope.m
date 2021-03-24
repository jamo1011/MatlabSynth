%Creates the harmonic signiture based on an input string(either an array of
%values or a function of in form 'func(somefunctionofTime, n)' where n is the
%number of data points
function enve = createEnvelope(str, duration)
    
if strcmp(str(1), 'f')
    [f, remain] = strtok(str, ',');
    str = ['@(t)' f(6:end)];
    fh = str2func(str);
    
    remain = strtok(remain, ')');
    n = str2num(remain);
    t = linspace(0, duration, n);
    enve = fh(t);
else
    enve = str2num(str);
end
