armstrongNums = [];

for n = 2:4
    startNum = 10^(n - 1);
    endNum = 10^n - 1;

    for num = startNum:endNum
        digitsVec = num2str(num) - '0';
        if sum(digitsVec .^ n) == num
            armstrongNums(end + 1) = num; %#ok<SAGROW>
        end
    end
end

disp('Числа Армстронга из 2, 3 и 4 цифр:');
disp(armstrongNums);