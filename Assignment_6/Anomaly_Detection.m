function p = Anomaly_Detection(x , mu , sigma)


[m n] = size(x);
for i = 1:1:m
    temp(i,:) = (x(i,:) - mu);

end


%  inv(sigma);
%  temp1 =  inv(sigma) *temp;
%  temp1 = temp' *temp1;
%  temp1 = temp' * inv(sigma);
%  temp1 = temp1 * temp;
% p = (2 * pi) ^ (- n_train / 2) * det(Sigma2) ^ (-0.5) * (exp((-0.5) * temp1));


p = (2 * pi) ^ (- n / 2) * det(sigma) ^ (-0.5) * ...
    exp(-0.5 * sum(bsxfun(@times, temp * inv(sigma), temp), 2));


end

