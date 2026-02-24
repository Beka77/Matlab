for i = 1000:9999
s = num2str(i)

if s(1)~=s(2) && s(1)~=s(3) &&  s(1)~=s(4) &&  s(2) ~=s(3) &&  s(2)~=s(4)  && s(3)~=s(4)
disp(i)
end 
end