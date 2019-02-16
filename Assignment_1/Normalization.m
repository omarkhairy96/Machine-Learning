function  [X] = Normalization(X)

[X_rows X_column] = size(X);

% Scaling All the Features using Normalization Method
% for i = 1:1:X_column
%     for j = 1:1:X_rows
%         X(j,i) =  abs(X(j,i)) / max(abs(X(:,i)));
%     end
% end

% Scaling All the Features using Mean Normalization
for w=2:X_column
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
end
