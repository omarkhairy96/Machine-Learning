function [theta , J_history ,h ,misclassification_error] = GradientDescent(X , y, theta , alpha)



k = 1;
[m n] = size(X);

flag = true;
q = 0;
misclassification_error = 0;

J_history(k) = ComputeCost(X, y, theta);

while( flag == true )
    
    h = sigmoid(X*theta);
    theta = theta - (alpha / m )* X' * (h-y);
    
    k = k + 1;
    J_history(k) = ComputeCost(X, y, theta);
    
    if (J_history(k-1)-J_history(k))<0
        break
    end
    q=(J_history(k-1)-J_history(k))./J_history(k-1);
    if q <.001;                
        flag = false;
    end
%     if (k == 100)
%         flag = false;
%     end
end

for i = 1:1:m
    if(y(i,1) == 0)&& (h(i,1) > 0.5)
        misclassification_error = misclassification_error +1;
    end
    if(y(i,1) == 1)&& (h(i,1) < 0.5)
        misclassification_error = misclassification_error +1;
    end
    
end
    
end