function [ds, rs] = uniformAcTerm(x, lv, L, H)
    x = double(x);
    ds = zeros(lv+1,1);
    rs = zeros(lv,1);
    
    deta = (H - L) / lv;
    
    ds(1) = floor(min(x(:)));
    for i = 2: lv+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: lv
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end