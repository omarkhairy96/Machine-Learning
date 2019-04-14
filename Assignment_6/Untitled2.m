clc
clear 
close all
%%%%%%% K-mean Algorithm modified

data = xlsread('house_prices_data_training_data.csv');

X = data(:,4:21);
[m n] = size(X);
X = Normalization(X);
cluster = 15; 
 iter = 10;
for clusters = 1:1:cluster
    centroids = zeros(clusters,n);
    
    for itr = 1:1:iter
        % Random Initialization for the Centroids each Iteration
        randidx = randperm(size(X,1));
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
    J_hist(1,clusters) = J_min;
end


for a = 1:1:cluster
    if (a == 1)
            best_cluster = a;
        else
            if(J_hist(1,a-1)- J_hist(1,a)  < 1)
               best_cluster =  a;
               break;
            end
    end
end

