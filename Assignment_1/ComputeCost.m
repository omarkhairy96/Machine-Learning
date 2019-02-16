function [J ] = ComputeCost(X, Y ,theta)

m = length(Y);

h =  X * theta ;

J = (1 / (2*m)) * sum((h - Y).^2);


end

