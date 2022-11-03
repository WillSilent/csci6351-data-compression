function [qx] = quantize2D(x, ds)
    lv = length(ds)-1;
    sizeX = size(x);
    
    % quantizer every element in x
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            % find:
            %   false: the interval has not been found
            %   true: the interval has been found
            find = false;
            % k: the index for d's
            k = 2;

            % while: loop until the interval is found
            while ~find
                if ds(k) > x(i,j)
                    find = true;
                end

                % d(j) is the upper bound of the last interval
                % x(i) is equal to the upper bound of the last interval
                if (k == lv) && (ds(k) == x(i,j))
                    find = true;
                end

                if ~find
                    k = k + 1;
                end
            end
            qx(i,j) = k-1;
        end
    end
end