function [k,t] = linefit(x,y)

% k = (length(x).*c-b*d)./(length(x).*a-b*b);
% t = (a.*d-c.*b)/(a*length(x)-b.*b);
line1 = polyfit(x,y,1);
x2 = min(x):(max(x)-min(x))/4:max(x);
y2 = polyval(line1,x2);

plot(x2,y2,'r*');
hold on
k=line1(1);
t=line1(2);

end


