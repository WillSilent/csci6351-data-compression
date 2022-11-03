function [qx, ds, rs] = MLQuantizer(x, n, dn)

    numx = length(x);
    % the quantized value of x
    qx = x;
    % calculate the optimal decision levels d's and reconstruction levels
    % r's
    [ds,rs] = MaxLloyd(x, n, dn);
    
    % quantizer every element in x

    for i = 1:numx
        % find:
        %   false: the interval has not been found
        %   true: the interval has been found
        find = false;
        j = 2;

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