function circle(xc,yc,r)
xc = 2; 
yc = 3;
r = 5;
t = 0:0.01:2*pi;
for k = 1:10
    color = rand(1,3);
end
    x = xc + r*cos(t);
    y = yc + r*sin(t);
    fill(x,y,color)
    axis equal
hold on
end