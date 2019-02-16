function [theta , J_history,h ] = GradientDescent(X , y, theta , alpha )

k = 1;
[m n] = size(X);

flag = true;
q = 0;

J_history(k) = ComputeCost(X, y, theta);

while( flag == true )
    h = X * theta;
    for z = 1:1:n    
        theta(z) = theta(z) - alpha * (1/m) * sum((h - y).* X(:,z));
    end
    k = k + 1;
    J_history(k) = ComputeCost(X, y, theta);
    if (J_history(k-1)-J_history(k))<0
        break
    end
    q=(J_history(k-1)-J_history(k))./J_history(k-1);
    
    if q <.001;                % As q decreases, the number of iteration increase
        flag = false;
    end

end

end
