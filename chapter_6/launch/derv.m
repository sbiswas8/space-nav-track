function dx = derv(x,dt)
[r,c] = size(x);
dx = zeros(r,c);
for i = 1:length(x)-2
   dx(i,:) = (x(i+2,:)-x(i,:))/(2*dt);
end