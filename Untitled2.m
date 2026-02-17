f = [1,2,3,4,5,6,7,8,9,10]
kol_chet = 0;
kol_2x_nechet=0;
kol_kdr_nechet=0;
for i = 1:length(f)
    num=f(i);
     if mod(num,2)==0
         kol_chet=kol_chet+1;
     end
     
     if mod(num,2) == 0 && mod(num,4) ~=0
         kol_2x_nechet=kol_2x_nechet+1;
     end
     
     if num>0
         sqrt_num = sqrt(num);
         if sqrt_num == floor(sqrt_num)
             if mod(sqrt_num,2)==1
                 kol_kdr_nechet=kol_kdr_nechet+1;
             end
         end
     end
end    
     disp(['Count even numbers:' num2str(kol_chet)]);
     disp(['The number of odd numbers doubled:' num2str(kol_2x_nechet)]);
     disp(['The number of squares of odd numbers:' num2str(kol_kdr_nechet)]);