clear all;
clc;

T = readtable('Mall_Customers.csv');

Income = T{:,4};
Score  = T{:,5};

X = [Income, Score];
X = zscore(X);

k = 3;
[idx, C] = kmeans(X, k);

figure;
hold on;
grid on;

clr = {'r','g','b'};

for i = 1:k
    xi = Income(idx==i);
    yi = Score(idx==i);

    scatter(xi, yi, 40, clr{i}, 'filled');

    % центроид в исходном масштабе
    cx = mean(xi);
    cy = mean(yi);
    plot(cx, cy, 'kx', 'MarkerSize', 14, 'LineWidth', 3);

    % круг поменьше: средний радиус + запас
    d = sqrt((xi-cx).^2 + (yi-cy).^2);
    r = mean(d) + 0.8*std(d);

    t = linspace(0, 2*pi, 200);
    plot(cx + r*cos(t), cy + r*sin(t), clr{i}, 'LineWidth', 2);
end

xlabel('Годовой доход');
ylabel('Оценка расходов');
title('K-означает кластеризацию с центроидами');
legend('Точка','Центроид','Основная группа(окружность)');
hold off;