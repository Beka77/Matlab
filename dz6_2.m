n = 5;              % лучше нечётное
A = zeros(n);

x = ceil(n/2);
y = ceil(n/2);

A(x,y) = 1;
num = 2;
step = 1;

while num <= n^2
    
    % вправо
    for k = 1:step
        if num > n^2, break; end
        y = y + 1;
        if x>=1 && x<=n && y>=1 && y<=n
            A(x,y) = num;
        end
        num = num + 1;
    end
    
    % вниз
    for k = 1:step
        if num > n^2, break; end
        x = x + 1;
        if x>=1 && x<=n && y>=1 && y<=n
            A(x,y) = num;
        end
        num = num + 1;
    end
    
    step = step + 1;
    
    % влево
    for k = 1:step
        if num > n^2, break; end
        y = y - 1;
        if x>=1 && x<=n && y>=1 && y<=n
            A(x,y) = num;
        end
        num = num + 1;
    end
    
    % вверх
    for k = 1:step
        if num > n^2, break; end
        x = x - 1;
        if x>=1 && x<=n && y>=1 && y<=n
            A(x,y) = num;
        end
        num = num + 1;
    end
    
    step = step + 1;
end

A