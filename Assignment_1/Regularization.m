function [theta , J_reguralization , h ] = Regularization(X , y, theta , alpha , lamda )

k = 1;
flag = true;
q = 0;
[m n] = size(X);

h =  X * theta ;
J_reguralization(k) = (1 / (2*m)) * sum((h - y).^2) + (lamda / (2*m)) * sum((theta(2:n,1)).^2);

while( flag == true )
    for z = 1:1:n  
        if(z == 1)
           theta(z,1) = theta(z,1)  - alpha * (1/m) * sum(h - y);
        end
        if(z>1)
            theta(z,1) = theta(z,1) * (1 - (alpha *lamda)/ m) - (alpha * (1/m)) * sum((h - y).* X(:,z));
        end
    end
    h = X * theta;
    k = k + 1;
    J_reguralization(k) = (1 / (2*m)) * sum((h - y).^2) + (lamda / (2*m)) * sum((theta(2:n,1)).^2);
%     if (k == 1000)
%         break
%     end
    q=(J_reguralization(k-1)-J_reguralization(k))./J_reguralization(k-1);
    
    if q <.001;                % As q decreases, the number of iteration increase
        flag = false;
    end


end

end
