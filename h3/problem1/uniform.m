function [ds, rs] = uniform(n, dn)

    ds = zeros(n+1,1);
    ds(1) = 0;
    ds(n+1) = dn;

    rs = zeros(n,1);
    
    deta = dn/n;
    
    for i = 2: n+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: n
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end