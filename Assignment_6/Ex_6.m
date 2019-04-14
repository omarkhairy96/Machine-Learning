clc
clear
close all

data = xlsread('house_prices_data_training_data.csv');

X = data(:,4:21);
X_norm = Normalization(X);
Y = data(:,3);
Y_norm = Normalization(Y);

[m n] = size(X);
%% =============== Part 1:Principal Component Analysis ================
% [k R X_approx error] = PCA(X);
% alpha = 0.005;      
% lamda = 10;
% theta_ini = zeros((k+1) , 1);
% [theta , J_cost ] = Linear_Regression(R',Y_norm,theta_ini ,alpha,lamda);
% 
% 
% 
% 
% %% =============== Part 2: K means Clustering ================
% clusters = 15;
%  [best_cluster J_hist ] = Best_Cluster(X_norm ,clusters);
%  [best_cluster_R J_hist_R ] = Best_Cluster(R' ,clusters);
% 
% 
% iter = 100;
% [centroids cluster_classes J_min itr_min  ] = K_mean(X_norm,best_cluster,iter);
% [centroids_R cluster_classes_R J_min_R itr_min_R  ] = K_mean(R',best_cluster_R,iter);



%% =============== Part 3: Anomaly Detection ================

r0 = round(m*0.6);
r1 = round(r0+(m*0.2));
r2 = round(r1 + m*0.2);

x_train = X(1:r0 , :);
[m_train n_train] = size(x_train);
x_cv = X(r0+1:r1 , :);
x_test = X(r1+1:end , :);

[mu sigma] = GaussianParamters(x_train);

p = Anomaly_Detection(x_train , mu ,sigma);

pval = Anomaly_Detection(x_cv, mu, sigma);


mean = mean(X)
STD = std(X);

counter = 0 ;
for s =1:17999
    prod = 1;
    for i = 1:18
    CDF = normpdf(X(s,i),mean(i),STD(i));
    prod = prod * CDF;
    end
    if prod > 10^-30 || prod<10^-50
        counter = counter +1;
    end
end

counter

