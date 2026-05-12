A = [1.2, 1.8, 2.4, 3.0, 3.6];
abase = max(A);
r0 = abase * sqrt(max(c2, 0));
x0 = nan(size(t));
y0 = nan(size(t));
x0(valid) = r0(valid) .* cos(t(valid));
y0(valid) = r0(valid) .* sin(t(valid));

figure('Color', 'k', 'Name', 'Kaleidoscope of lemniscata');
hold on; axis equal off;

segments = 24;                 
kaleidoColors = hsv(segments); 

for k = 1:segments
    phi = 2*pi*(k-1)/segments;
    R = [cos(phi), -sin(phi); sin(phi), cos(phi)];

    p = R * [x0; y0];
    plot(p(1, :), p(2, :), 'Color', kaleidoColors(k, :), 'LineWidth', 1.4);

    pm = R * [x0; -y0];
    plot(pm(1, :), pm(2, :), 'Color', kaleidoColors(k, :), 'LineWidth', 1.0);
end

title('Kaleidoscope based on lemniscate', 'Color', 'w');