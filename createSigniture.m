%Creates the harmonic signiture based on an input string(either an array of
%values or a function of in form 'func(somefunction, n)' where n is the
%number of data points
function harmSig = createSigniture(str)
    
if strcmp(str(1), 'f')
    [f, remain] = strtok(str, ',');
    str = ['@(x)' f(6:end)];
    fh = str2func(str);
    
    remain = strtok(remain, ')');
    n = str2num(remain);
    t = 1:n;
    harmSig = fh(t);
else
    harmSig = str2num(str);
end

end