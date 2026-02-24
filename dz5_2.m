n = input('Enter n: ');
count = 0;
i = 1;

while (count < n)
    x = i;

   while (mod(x,2)==0)
    x = x/2;
   end
    while (mod(x,3)==0)
    x = x/3;
    end
    while (mod(x,5)==0)
    x = x/5;
    end
    
    if x == 1
        disp(i)
        count = count + 1;
    end

    i = i + 1;
end