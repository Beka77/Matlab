clc
clear

for n = 2:4
    
    disp('Числа Армстронга:')
    
    for num = 10^(n-1) : 10^n - 1
        
        t = num;
        sum_pow = 0;
        
        while t > 0
            d = mod(t,10);      % последняя цифра
            sum_pow = sum_pow + d^n;
            t = floor(t/10);     % убираем цифру
        end
        
        if sum_pow == num
            disp(num)
        end
        
    end
        
end