function [a, b, error_a, error_b] = linfit(X,Y,error,color)
% [a, b, error_a, error_b] = linfit(X,Y,error,color)
%
% This function accepts vectors X, Y and an error for Y, and returns the
% coefficients a and b for the equation Y = a + bX
%
% Uncomment the last section if you need to see the plot and determine
% other parameters such as sigma_a and sigma_b, among others.

if nargin < 4
    flag = 0;
end


if isempty(error)
    error = ones(length(X),1)*0.01;
end

N = length(X);
S = 0; Sx = 0; Sy = 0; Stt = 0; b = 0;

for i = 1:N
    S = S + (1/error(i))^2;
    Sx = Sx + (X(i)/error(i)^2);
    Sy = Sy + (Y(i)/error(i)^2);
end

for i = 1:N
    t(i) = (X(i) - (Sx/S))/error(i);
    Stt = Stt + t(i)^2;
    b = b + (t(i)*Y(i)/error(i));
end

b = b/Stt;
a = (Sy - Sx*b)/S;

sigma_a = sqrt((1 + (Sx^2/S/Stt))/S);
sigma_b = sqrt(1/Stt);
Covab = -Sx/S/Stt;
rab = Covab/sigma_a/sigma_b;

x(1) = min(X); x(2) = max(X);
y(1) = a + (b*x(1)); y(2) = a + (b*x(2));  

if nargout > 2
    error_a = sigma_a;
    error_b = sigma_b;
end

if nargin > 3
    plot(x,y,[color '--'])
else
    errorbar(X,Y,error,'r.');
    hold on
    plot(x,y,'b--');
end