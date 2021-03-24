F = figure;
points = drawpoint('Position', [rand, rand]);
for i = 2:5
    points(i) = drawpoint('Position', [rand, rand]);
end
xx = 0:.01:1;
while(true)
    for i = 1:5
        x(i) = points(i).Position(1);
        y(i) = points(i).Position(2);
    end
    yy = interp1(x, y, xx, 'spline');
    hold on
    p1 = plot(xx, yy, 'r');
    yy = interp1(x, y, xx, 'pchip');
    p2 = plot(xx, yy, 'g');
    xlim([0,1])
    ylim([0,1])
    pause(.1)
    delete(p1)
    delete(p2)
end

