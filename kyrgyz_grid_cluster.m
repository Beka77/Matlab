<<<<<<< HEAD
clc;
clear;
close all;

h = 50; % øàã ñåòêè â êì

% Ãîðîäà [øèðîòà äîëãîòà]
cities = [
    42.87 74.59;   % Bishkek
    40.53 72.80;   % Osh
    42.52 72.24;   % Talas
    41.43 75.99;   % Naryn
    42.49 78.39    % Karakol
];

cityNames = {'Bishkek','Osh','Talas','Naryn','Karakol'};

lat = cities(:,1);
lon = cities(:,2);

% Ãðàíèöû êàðòû Êûðãûçñòàíà
mapLonMin = 69.2;
mapLonMax = 80.3;
mapLatMin = 39.2;
mapLatMax = 43.3;

% Ïðÿìîóãîëüíèê ÁÎËÜØÅ êàðòû Êûðãûçñòàíà
lonMin = 68.3;
lonMax = 81.0;
latMin = 39.0;
latMax = 43.6;

% Ïåðåâîä êì â ãðàäóñû
meanLat = (latMin + latMax) / 2;

dLat = h / 111.32;
dLon = h / (111.32 * cosd(meanLat));

% Ñåòêà
latGrid = latMin:dLat:latMax;
lonGrid = lonMin:dLon:lonMax;

[LonGrid, LatGrid] = meshgrid(lonGrid, latGrid);
gridPoints = [LatGrid(:), LonGrid(:)];

numPoints = size(gridPoints,1);
numCities = size(cities,1);

dist = zeros(numPoints, numCities);

R = 6371;

% Ðàññòîÿíèå Õàâåðñèíà
for i = 1:numCities
    lat1 = deg2rad(gridPoints(:,1));
    lon1 = deg2rad(gridPoints(:,2));

    lat2 = deg2rad(lat(i));
    lon2 = deg2rad(lon(i));

    dlat = lat2 - lat1;
    dlon = lon2 - lon1;

    a = sin(dlat/2).^2 + cos(lat1).*cos(lat2).*sin(dlon/2).^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));

    dist(:,i) = R * c;
end

[~, clusterID] = min(dist, [], 2);

figure('Color','w');
hold on;

% êàðòà
img = imread('kyrgyzstan_map.png');
imagesc([mapLonMin mapLonMax],[mapLatMin mapLatMax],flipud(img));
set(gca,'YDir','normal');

colors = [
    1.0 0.5 0.0;   % Osh
    0.6 0.2 0.8;   % Talas
    0.2 0.7 0.2;   % Bishkek
    0.2 0.6 1.0;   % Naryn
    1.0 1.0 0.0    % Karakol
];

cellW = dLon/2;
cellH = dLat/2;

% çàêðàñêà âñåé òåððèòîðèè áåç äûð
for k = 1:size(gridPoints,1)

    x = gridPoints(k,2);
    y = gridPoints(k,1);
    cid = clusterID(k);

    patch( ...
        [x-cellW x+cellW x+cellW x-cellW], ...
        [y-cellH y-cellH y+cellH y+cellH], ...
        colors(cid,:), ...
        'EdgeColor','none', ...
        'FaceAlpha', 0.22);
end

% ñåòêà ìàëåíüêèìè òî÷êàìè
plot(gridPoints(:,2), gridPoints(:,1), ...
    '.', ...
    'Color', [0.15 0.15 0.15], ...
    'MarkerSize', 5);

% ãîðîäà
plot(lon, lat, 'kp', ...
    'MarkerSize',16, ...
    'MarkerFaceColor','y', ...
    'LineWidth',1.5);

for i=1:numCities
    text(lon(i)+0.08, lat(i)+0.04, cityNames{i}, ...
        'FontSize',10, ...
        'FontWeight','bold');
end

% ïðÿìîóãîëüíèê
rectLon = [lonMin lonMax lonMax lonMin lonMin];
rectLat = [latMin latMin latMax latMax latMin];

plot(rectLon, rectLat, 'k-', 'LineWidth', 2.5);

xlabel('Longitude');
ylabel('Latitude');
title('Êëàñòåðèçàöèÿ òåððèòîðèè Êûðãûçñòàíà');

xlim([68 82]);
ylim([38.8 43.8]);

grid on;
axis equal;
box on;

hold off;

    
