function [dx] = smdequantizer(qx, r)
    dx = qx;
    numx = length(qx);
    
    for i = 1:numx
        dx(i) = r(qx(i));
    end
    
end