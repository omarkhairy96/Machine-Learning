function theta = Normal_Equation(X, Y )

X_transpose = transpose(X);

X_inverse = inv(X_transpose * X);

X_inverse = X_inverse * X_transpose;

theta = X_inverse * Y;

