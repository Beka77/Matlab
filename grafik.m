A = [1.2, 1.8, 2.4, 3.0, 3.6];
assert(isvector(A) && numel(A) == 5, 'A must contain exactly 5 numbers.');
assert(all(A > 0), 'All values of A must be positive.');
t = linspace(0, 2*pi, 4000);
c2 = cos(2*t);
valid = c2 >= 0;
figure('Color', 'w', 'Name', 'The Lemniscate family');
hold on; grid on; axis equal;
colors = lines(numel(A));

for i = 1:numel(A)
    a = A(i);
    r = a * sqrt(max(c2, 0));

    x = nan(size(t));
    y = nan(size(t));
    x(valid) = r(valid) .* cos(t(valid));
    y(valid) = r(valid) .* sin(t(valid));

    plot(x, y, 'LineWidth', 2.2, 'Color', colors(i, :), ...
        'DisplayName', sprintf('a = %.2f', a));
end

xlabel('x'); ylabel('y');
title('The Bernoulli Lemniscate family');
legend('Location', 'bestoutside');


