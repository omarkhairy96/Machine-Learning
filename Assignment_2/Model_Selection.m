function  [J_trainh, J_cvh , J_testh ,theta_train  , min_cv_index , x_train , x_cv,x_test] = Model_Selection(X , Y , range)
Q = 0;

[m n] = size(X);

X_original = X;
for i = 1:1:range  
    temp = X_original;
    a = [];
    for d = 1:1:i
        
        U = temp.^d;
        a = [a U ];
    end
    Q = Q +1;
    X = [ones(m,1) a ];
      
    [X] = Normalization(X);
    
    r0 = round(m*0.1);
    r1 = round((r0*2)+m*0.6);
    r2 = round(r1 + m*0.1);
     x_cv = X(1:r0 , :);
     x_test = X(r0+1:(r0*2) , :);
     x_train = X((r0*2)+1:r1 , :);
     x_cv = [x_cv ;X(r1+1:r1+r0 , :) ];
     x_test =[x_test ; X(r1+r0+1:end , :)];


     y_cv = Y(1:r0 , :);
     y_test = Y(r0+1:(r0*2) , :);
     y_train = Y((r0*2)+1:r1 , :);
     y_cv = [y_cv ;Y(r1+1:r1+r0 , :) ];
     y_test =[y_test ; Y(r1+r0+1:end , :)];
    
    [X_rows X_column] = size(x_train);
    theta = zeros(X_column,1);

    theta_train  = GradientDescent(x_train , y_train , theta , 0.05);
    if(i == 1)
        J_trainh(1,i) = ComputeCost(x_train , y_train , theta_train);
        J_cvh(1,i) = ComputeCost(x_cv , y_cv , theta_train);
        J_testh(1,i) = ComputeCost(x_test , y_test , theta_train);
        min_cv =  J_cvh(1,i);
        min_cv_index = i;
    else
        
    J_trainh(1,i) = ComputeCost(x_train , y_train , theta_train);
    J_cvh(1,i) = ComputeCost(x_cv , y_cv , theta_train);
    J_testh(1,i) = ComputeCost(x_test , y_test , theta_train);
    end
    if( J_cvh(1,i) < min_cv)
        min_cv =  J_cvh(1,i);
        min_cv_index = i;
    end
        
end
end