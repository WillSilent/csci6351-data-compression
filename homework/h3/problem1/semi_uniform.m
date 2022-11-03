function [ds, rs] = semi_uniform(x, n, dn)
    x = sort(x);
    % lv = 4;
    ds = zeros(n+1,1);
    ds(1) = 0;
    ds(n+1) = n;
    rs = zeros(n,1);
    % deta = range(x)/lv;
    deta = dn/n;

    % set the interval values, d's.
    for i = 1:(n+1)
        ds(i) = x(1)+(i-1)*deta;
    end
    
    % set the reconstruction values, r's.
    sum = 0;
    num = 0;
    ir = 1;
    for i = 1:length(x)
        if (x(i) < ds(ir+1))||(x(i) == ds(n+1)),
            sum = sum+x(i);
            num = num+1;
        end

        if i == length(x) || x(i+1) > ds(ir+1),
            if sum == 0
                rs(ir) = (ds(ir) +ds(ir+1))/2;
            else
                rs(ir) = sum/num;
            end
            ir= ir + 1;
            sum = 0;
            num = 0;
        end
    end
end