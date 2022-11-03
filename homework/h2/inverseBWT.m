function B = inverseBWT(y)
    %get the length of y
    [n,] = size(y);
    B = y;

    for i = 1:n-1
        % sort the y
        tmp = sortrows(B);
    
        % get the last column of sorted newY
        last_column = tmp(1:n, i);
    
        % append the last column to the exist y
        B(1:n, i+1) = last_column;
    end

    %finally sort the y, we can get the B
    B = sortrows(B); 
end