function [dx] = dequantize2D(qx, rs)
    dx = qx;
    sizeX = size(qx);
    
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            dx(i,j) = rs(qx(i,j));
        end
    end
end