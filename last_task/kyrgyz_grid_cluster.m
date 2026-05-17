clc; clear; close all;

% Шаг сетки в км
h = 50;

% 5 городов Кыргызстана: [широта, долгота]
cities = {
    'Bishkek', 42.87, 74.59;
    'Osh',     40.53, 72.80;
    'Talas',   42.5225, 72.2425;
    'Naryn',   41.43, 75.99;
    'Karakol', 42.49, 78.39
};

names = cities(:,1);
lat = cell2mat(cities(:,2));
lon = cell2mat(cities(:,3));

% Прямоугольник вокруг городов
margin = 0.15;
latMin = min(lat) - margin;
latMax = max(lat) + margin;
lonMin = min(lon) - margin;
lonMax = max(lon) + margin;

% Перевод километров в градусы
meanLat = mean([latMin latMax]);

dLat = h / 111.32;
dLon = h / (111.32 * cosd(meanLat));

% Сетка
latGrid = latMin:dLat:latMax;
lonGrid = lonMin:dLon:lonMax;

[LonGrid, LatGrid] = meshgrid(lonGrid, latGrid);

gridPoints = [LatGrid(:), LonGrid(:)];

% Кластеризация: каждый узел сетки относится к ближайшему городу
numPoints = size(gridPoints, 1);
numCities = length(names);

dist = zeros(numPoints, numCities);

for i = 1:numCities
    dist(:,i) = haversine(gridPoints(:,1), gridPoints(:,2), lat(i), lon(i));
end

[~, clusterID] = min(dist, [], 2);

% Построение
figure('Color','w');
hold on; grid on;

scatter(gridPoints(:,2), gridPoints(:,1), 35, clusterID, 'filled');
plot(lon, lat, 'kp', 'MarkerSize', 14, 'MarkerFaceColor', 'y');

for i = 1:numCities
    text(lon(i) + 0.05, lat(i), names{i}, ...
        'FontSize', 10, 'FontWeight', 'bold');
end

% Границы прямоугольника
rectLon = [lonMin lonMax lonMax lonMin lonMin];
rectLat = [latMin latMin latMax latMax latMin];

plot(rectLon, rectLat, 'k-', 'LineWidth', 2);

xlabel('Долгота');
ylabel('Широта');
title('Кластеризация узлов сетки по ближайшим городам Кыргызстана');
legend('Узлы сетки', 'Города', 'Прямоугольник', 'Location', 'bestoutside');

axis equal;
hold off;

% ===== функция расстояния Хаверсина =====
function d = haversine(lat1, lon1, lat2, lon2)
    R = 6371; % радиус Земли в км

    lat1 = deg2rad(lat1);
    lon1 = deg2rad(lon1);
    lat2 = deg2rad(lat2);
    lon2 = deg2rad(lon2);

    dlat = lat2 - lat1;
    dlon = lon2 - lon1;

    a = sin(dlat/2).^2 + cos(lat1).*cos(lat2).*sin(dlon/2).^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));

    d = R * c;
end