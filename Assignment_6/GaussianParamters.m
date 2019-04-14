function [mu sigma] = GaussianParamters(x )

[m n] = size(x);
mu = mean(x);
Sigma2 = var(x, 1);

for i = 1:1:m
    temp(i,:) = (x(i,:) - mu);

end
sigma = cov(temp);


end

