function [ds, rs] = uniform(x, lv)
    x = double(x);
    ds = zeros(lv+1,1);
    rs = zeros(lv,1);
    
    deta = (max(x(:))+0.001-min(x(:)))/lv;
    
    ds(1) = min(x(:));
    for i = 2: lv+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: lv
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end