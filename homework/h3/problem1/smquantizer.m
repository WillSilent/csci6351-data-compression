function [qx, ds, rs] = smquantizer(x, n, dn)

    numx = length(x);
    
    qx = x;
    
    [ds, rs] = semi_uniform(x, n, dn);
    
    % quantizer every element in x
    for i = 1:numx
        % find:
        %   false: the interval has not been found
        %   true: the interval has been found
        find = false;
        % j: the index for d's
        j = 2;
        
        % while: loop until the interval is found
        while ~find
            if ds(j) > x(i)
                find = true;
            end
            
            % d(j) is the upper bound of the last interval
            % x(i) is equal to the upper bound of the last interval
            if (j == n) && (ds(j) == x(i))
                find = true;
            end
            
            if ~find
                j = j + 1;
            end
        end
        qx(i) = j-1;
    end
    
    
    
end