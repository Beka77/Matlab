a = [1 2 3; 4 5 6; 7 8 9];
s_diag = sum(diag(a));
s_upper = sum(sum(triu(a, 1)));
s_lower = sum(sum(triu(a, -1)));
a(mod(a, 2)==0)=s_diag