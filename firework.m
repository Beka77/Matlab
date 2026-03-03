function fireworks()

clc;
clear;
close all;

% Создаём окно
figure;
set(gcf,'Color','k');      % чёрный фон
axis equal;
axis([-20 20 0 25]);
axis off;
hold on;

% Параметры
numFireworks = 3;      % количество фейерверков
numParticles = 80;     % количество частиц
gravity = 6;           % гравитация
dt = 0.05;             % шаг времени
lifetime = 2;          % время жизни

for f = 1:numFireworks
    
    % случайный центр взрыва
    centerX = -15 + rand*30;
    centerY = 10 + rand*10;
    
    for t = 0:dt:lifetime
        
        cla;   % очищаем кадр
        
        for i = 1:numParticles
            
            % случайный угол
            angle = rand * 2 * pi;
            
            % случайная скорость
            speed = 4 + rand*4;
            
            % координаты частицы
            x = centerX + speed*cos(angle)*t;
            y = centerY + speed*sin(angle)*t - 0.5*gravity*t^2;
            
            % затухание
            fade = 1 - t/lifetime;
            
            % случайный цвет
            color = rand(1,3) * fade;
            
            plot(x, y, '.', ...
                'Color', color, ...
                'MarkerSize', 15*fade + 1);
        end
        
        drawnow;
    end
    
end

end


