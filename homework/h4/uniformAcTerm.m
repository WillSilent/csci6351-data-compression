function [ds, rs] = uniformAcTerm(lv, L, H)
    ds = zeros(lv+1,1);
    rs = zeros(lv,1);
    
    deta = (double(H) - double(L)) / lv;
    
    %ds(1) = floor(min(x(:)));
    ds(1) = double(L);
    for i = 2: lv+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: lv
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end