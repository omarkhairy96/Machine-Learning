clc
clear
close all

ds = datastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);

y = T{:,14};
alpha = 0.5;
%Input Features for Hypothesis 1
X1 = T{:,1:7};
[m1 n1] = size(X1);
X1 = [ones(m1,1) X1 ];
X1 = Normalization(X1);
theta_ini1 = zeros((n1+1) , 1);

[theta1 J_history1,h1,misclassification_error1] = GradientDescent(X1, y ,theta_ini1,alpha);

%Input Features for Hypothesis 2

X2 = T{:,1:13};
X2 = [X2];
[m2 n2] = size(X2);
X2 = [ones(m2,1) X2 ];
X2 = Normalization(X2);
theta_ini2 = zeros((n2+1) , 1);

[theta2 J_history2,h2,misclassification_error2] = GradientDescent(X2, y ,theta_ini2,alpha);

% From Hypothesis one and two, increaseing the number of input features decreases the MisClassification error  
%Input Features for Hypothesis 3: Polynomial function
 X3 = T{:,1:13};
 
 a =X3;
 for d = 2:1:20
        U = X3.^d;
        a = [a U ];
 end
 
X3 = a;
[m3 n3] = size(X3);
 X3 = [ones(m3,1) a ];
 X3 = Normalization(X3);
theta_ini3 = zeros((n3+1) , 1);
    
[theta3 ,J_history3,h3,misclassification_error3] = GradientDescent(X3, y ,theta_ini3,alpha);
 


%Input Features for Hypothesis 4: Selecting the best degree for ploynomial function using Model Selection
 X4 = T{:,1:13};


[J_trainh, J_cvh , J_testh ,theta_train  , min_cv_degree ] = Model_Selection(X4 , y , 20);
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
    
[theta4 ,J_history4,h4,misclassification_error4] = GradientDescent(X4, y ,theta_ini4,alpha);



plot(J_history1,'g')
hold on
plot(J_history2,'r')
hold on
plot(J_history3,'Y')
hold on
plot(J_history4,'b')

% Although Hypothesis has the least Mean square error, However the best Hypothesis function is with degree 4 