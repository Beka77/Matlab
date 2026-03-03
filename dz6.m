n = 7;
A = zeros(n);

top = 1; 
bottom = n;
left = 1; 
right = n;

num = 1;

while left <= right && top <= bottom
    
    % слева направо
    for j = left:right
        A(top,j) = num;
        num = num + 1;
    end
    top = top + 1;
    
    % сверху вниз
    for i = top:bottom
        A(i,right) = num;
        num = num + 1;
    end
    right = right - 1;
    
    % справа налево
    if top <= bottom
        for j = right:-1:left
            A(bottom,j) = num;
            num = num + 1;
        end
        bottom = bottom - 1;
    end
    
    % снизу вверх
    if left <= right
        for i = bottom:-1:top
            A(i,left) = num;
            num = num + 1;
        end
        left = left + 1;
    end
end

A