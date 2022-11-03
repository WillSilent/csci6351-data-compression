function [H] = computeEntropy(X)

    X = double(X(:));
    r = range(X);
    f = zeros(r+1,1);
    minX = min(X);
    for i = 1:length(X)
        f(X(i)-minX+1) = f(X(i)-minX+1)+1;
    end
    f= f(f~=0);
    % probability distribution
    p = f./sum(f);
    % the self information for each color
    SelfX = -log2(p);
    % the entropy of this picture
    H = sum(p.*SelfX);

end