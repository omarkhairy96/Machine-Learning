clc
clear 
close all

data = xlsread('house_data_complete.csv');

price = data(:,3)/mean(data(:,3));
alpha = 0.005;      % As alpha increases the number of iteration increases
lamda = 10;
m = length(price);

% Input Features for Hypothesis 1
X1 = data(:,4:9);

[m1 n1] = size(X1);
X1 = [ones(m,1) X1 ];
[X1] = Normalization(X1);
theta_ini1 = zeros((n1+1) , 1);


%Theta Vector using Gradient Descent method without reguralization
[theta1 , J_history1 ] = GradientDescent(X1,price,theta_ini1 ,alpha );


% Input Features for Hypothesis 2  Increasing the number of features
X2 = data(:,4:21);
[m2 n2] = size(X2);
X2 = [ones(m,1) X2 ];
[X2] = Normalization(X2);
theta_ini2 = zeros((n2+1) , 1);


%Theta Vector using Gradient Descent method without reguralization
[theta2 , J_history2 ] = GradientDescent(X2,price,theta_ini2 ,alpha ); 

%Theta Vector using Gradient Descent method with reguralization
 [theta_reg , J_reguralization ] = Regularization(X2,price,theta_ini2 ,alpha,lamda);



%Theta Vector using Normal Equation method
theta_norm = Normal_Equation(X2, price);

% Input Features for Hypothesis 3 Using polynomial regression with degree 20
 
X3 = data(:,4:21);

b =X3;
 for d = 2:1:20
        
        U = X3.^d;
        b = [b U ];
 end
 
X3 = b;
[m3 n3] = size(X3);
X3 = [ones(m,1) X3 ];
[X3] = Normalization(X3);
theta_ini3 = zeros((n3+1) , 1);

[theta3 , J_history3 ] = GradientDescent(X3,price,theta_ini3 ,alpha ); 


% Input Features for Hypothesis 4 Selecting the Best polynomial hypothesis using model Selction Method

X4 = data(:,4:21);

[J_train, J_cv , J_test , theta_train ,min_cv_degree] = Model_Selection(X4 , price , 10);

a =X4;
 for d = 2:1:min_cv_degree
        
        U = X4.^d;
        a = [a U ];
 end
 
X4 = a;
[m4 n4] = size(X4);
 X4 = [ones(m4,1) a ];
 X4 = Normalization(X4);
theta_ini4 = zeros((n4+1) , 1);
    
[theta4 J_history4 ] = GradientDescent(X4, price ,theta_ini4,alpha);

plot(J_history1,'g')
hold on
plot(J_history2,'r')
hold on
plot(J_history3,'Y')
hold on
plot(J_history4,'b')

xlabel('Number of iteration')
ylabel('Mean Square Error')
