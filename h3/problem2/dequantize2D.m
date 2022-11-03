function [dx] = dequantize2D(qx, rs)
    
    sizeX = size(qx);
    dx = size(sizeX);
    
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            dx(i,j) = rs(qx(i,j));
        end
    end
end