function [k R X_approx error] = PCA(X)

 X = Normalization(X);
 
 
[m n] = size(X);
Corr_x = corr(X);
x_cov=cov(X);
[U S V] =  svd(x_cov);

[S_row S_Column] = size(S);
eign_values = zeros(1,S_Column);
for i = 1:1:S_row
    eign_values(i) = sum(S(i,:));
end
%alpha = 0;


sum_eigenvalues = sum(eign_values);
for i = 1:1:n
    alpha = 1 - (sum(eign_values(1,1:i)) / sum_eigenvalues);
    if (alpha <= 0.001)
        k = i;
        break;
    end
    

end

R = U(:,1:k)' * X';
X_approx =  U(:,1:k) * R;

error = (1/m) *( sum(X_approx) - sum (R)).^2;
error = error';



end
