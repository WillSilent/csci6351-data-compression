function[C, r] = clusterQuantizer(X, n)
    len = length(X);    
    r = zeros(n, 1);
    d = floor(len / n);

    %%intial vlaue
    for k = 1:1:n
        r(k) = X((k-1)*d + 1);
    end
    
    iter = 40;
    C = zeros(len, 1);
    while iter > 0
        %%Cluster assignment
        for i = 1:1:len
            val = abs(X(i) - r(1));
            k = 1;
            for j = 2:1:n
                tmp = abs(X(i) - r(j));
                if(val > tmp)
                    val = tmp;
                    k = j;
                end
            end
            C(i) = k;
        end
    
        %% recompute the value of r
        for i = 1:1:n
            sum = 0;
            count = 0;
            for j = 1:1:len
                if C(j) == i
                    sum = sum + X(j);
                    count = count + 1;
                end
            end
            r(i) = sum / count;
        end
        iter = iter - 1;
    end
end