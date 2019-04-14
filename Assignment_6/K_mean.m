function [centroids_min indices_min  J_min itr_min ] = K_mean(X ,cluster,iter)


[m n] = size(X);


centroids = zeros(cluster,n);
    
    for itr = 1:1:iter
        % Random Initialization for the Centroids each Iteration
        randidx = randperm(size(X,1));
        centroids = X(randidx(1:cluster), :);

       %Clustering Assignment
        for i=1:m
            k = 1;
            min_dist = sum((X(i,:) - centroids(1,:)) .^ 2);
            for j=2:cluster
                dist = sum((X(i,:) - centroids(j,:)) .^ 2);
                if(dist < min_dist)
                    min_dist = dist;
                    k = j;
                end
            end
            indices(i) = k;
        end
        
        %Moving the Centroids
        for k=1:1:cluster
            result = 0;
            count = 0;
            for i=1:1:m
                if(indices(i) == k )
                result = result + X(i,:);
                count = count+1;
                end
            end
         centroids(k,:) = (1/count) *result;
        end
        
        % Compute The cost function
        for i=1:1:m
            J_cost(1,i) =  sum(X(i,:) - centroids(indices(1,i),:))^2;
        end
        J = (1/m)*sum(J_cost);
        if(itr == 1 )
            J_min = J;
            centroids_min = centroids;
            indices_min = indices;
            itr_min = itr;
        else
            if(J_min > J)
                J_min = J;
                centroids_min = centroids;
                indices_min = indices;
                itr_min = itr;
            end
        end


    end
    J_history(1,cluster) = J_min;
         
end