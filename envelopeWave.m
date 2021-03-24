function wave = envelopeWave(w, e)
    tt = 1:length(w);
    t = linspace(1, tt(end), length(e));
    wave = w;
    if size(e,1) == 2
        u = e(1,:);
        upperEnve = spline(t, e(1,:), tt);
        lowerEnve = spline(t, e(2,:), tt);
        mask = wave>0;
        wave(mask) = upperEnve(mask).*w(mask);
        wave(~mask) = -lowerEnve(~mask).*w(~mask);
    else
        enve = spline(t, e, tt);
        wave = enve.*w;
    end
end