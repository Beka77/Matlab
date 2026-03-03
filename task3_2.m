x = input('Enter x: ');
y = input('Enter 25 numbers as [ ... ]: ');

min_d = inf;

for i = 1:24
    for j = i+1:25
        
        avg = (y(i) + y(j)) / 2;
        d = abs(avg - x);
        
        if d < min_d
            min_d = d;
            best_i = i;
            best_j = j;
        end
        
    end
end

disp('The numbers you are looking for:')
disp([y(best_i), y(best_j)])

disp('their average:')
disp((y(best_i) + y(best_j)) / 2)