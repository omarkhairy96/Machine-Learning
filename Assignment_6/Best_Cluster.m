function [best_cluster J_hist ] = Best_Cluster(X ,upperboundcluster)

[m n] = size(X);
randidx = randperm(size(X,1));

for clusters = 1:1:upperboundcluster
    centroids = zeros(clusters,n);
    centroids = X(randidx(1:clusters), :);

       %Clustering Assignment
        for i=1:m
            k = 1;
            min_dist = sum((X(i,:) - centroids(1,:)) .^ 2);
            for j=2:clusters
                dist = sum((X(i,:) - centroids(j,:)) .^ 2);
                if(dist < min_dist)
                    min_dist = dist;
                    k = j;
                end
            end
            indices(i) = k;
        end
        
        %Moving the Centroids
        for k=1:1:clusters
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
         J_hist(1,clusters) = J; 
        
        
            
        
       
end
for a = 1:1:upperboundcluster
    if (a == 1)
            best_cluster = a;
        else
            if(J_hist(1,a-1)- J_hist(1,a)  < 1)
               best_cluster =  a;
               break;
            end
    end
end
%best_cluster = 5;
end