% kyrgyz_grid_cluster.m
% Построение прямоугольника внутри Кыргызстана, сетки с шагом h (км),
% отображение 5 крупных городов и кластеризация точек сетки.

clear; clc; close all;

%% 1) Географические ориентиры по Кыргызстану (из открытых источников)
% Границы Кыргызстана (приблизительный диапазон):
%   широта: 39°11' N ... 43°16' N
%   долгота: 69°15' E ... 80°18' E
% Ниже выбран прямоугольник с углами ВНУТРИ территории Кыргызстана.

% Формат: [lon, lat]
rect = [ ...
    72.50, 40.80;  % SW
    76.80, 40.80;  % SE
    76.80, 42.90;  % NE
    72.50, 42.90]; % NW

%% 2) Пять крупных городов Кыргызстана (приближенные координаты)
cityNames = {"Bishkek","Osh","Jalal-Abad","Karakol","Tokmok"};
cityLL = [ ...
    74.60, 42.87;  % Bishkek
    72.80, 40.53;  % Osh
    72.98, 40.93;  % Jalal-Abad
    78.39, 42.49;  % Karakol
    75.28, 42.84]; % Tokmok

% Оставим только точки внутри выбранного прямоугольника
inRect = cityLL(:,1) >= min(rect(:,1)) & cityLL(:,1) <= max(rect(:,1)) & ...
         cityLL(:,2) >= min(rect(:,2)) & cityLL(:,2) <= max(rect(:,2));
cityLL_in = cityLL(inRect,:);
cityNames_in = cityNames(inRect);

%% 3) Равномерная сетка с шагом h (км)
h_km = 25; % шаг сетки в километрах

lonMin = min(rect(:,1)); lonMax = max(rect(:,1));
latMin = min(rect(:,2)); latMax = max(rect(:,2));
lat0 = mean([latMin, latMax]);

% Перевод км -> градусы
km_per_deg_lat = 111.32;
km_per_deg_lon = 111.32 * cosd(lat0);

dLat = h_km / km_per_deg_lat;
dLon = h_km / km_per_deg_lon;

latVec = latMin:dLat:latMax;
lonVec = lonMin:dLon:lonMax;
[LonGrid, LatGrid] = meshgrid(lonVec, latVec);
gridPts = [LonGrid(:), LatGrid(:)];

%% 4) Кластеризация всех точек сетки
K = 4;
[idx, C] = kmeans(gridPts, K, 'Replicates', 10);

%% 5) Визуализация
figure('Color','w'); hold on; box on; grid on;

% Прямоугольник
rectClosed = [rect; rect(1,:)];
plot(rectClosed(:,1), rectClosed(:,2), 'k-', 'LineWidth', 2, 'DisplayName', 'Прямоугольник');

% Кластеры сетки
colors = lines(K);
for k = 1:K
    pts = gridPts(idx==k,:);
    scatter(pts(:,1), pts(:,2), 14, colors(k,:), 'filled', ...
        'MarkerFaceAlpha', 0.55, 'DisplayName', sprintf('Сетка: кластер %d', k));
end

% Центры кластеров
scatter(C(:,1), C(:,2), 90, 'kd', 'filled', 'DisplayName', 'Центры кластеров');

% Города
scatter(cityLL_in(:,1), cityLL_in(:,2), 85, 'rp', 'filled', 'DisplayName', 'Крупные города');
for i = 1:size(cityLL_in,1)
    text(cityLL_in(i,1)+0.05, cityLL_in(i,2), cityNames_in{i}, ...
        'FontSize', 10, 'Color', [0.6 0 0]);
end

xlabel('Долгота, °E');
ylabel('Широта, °N');
title(sprintf('Кыргызстан: сетка h = %.1f км и кластеризация точек', h_km));
legend('Location','bestoutside');
axis equal;

% Для наглядности
xlim([lonMin-0.2 lonMax+0.2]);
ylim([latMin-0.2 latMax+0.2]);

fprintf('Количество точек сетки: %d\n', size(gridPts,1));
fprintf('Использовано городов внутри прямоугольника: %d из %d\n', size(cityLL_in,1), size(cityLL,1));
