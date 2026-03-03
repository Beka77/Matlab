function circle(xc,yc,r)

t = 0:0.01:2*pi;
color = rand(1,3);

x = xc + r*cos(t);
y = yc + r*sin(t);

fill(x,y,color)
axis equal
hold on

end