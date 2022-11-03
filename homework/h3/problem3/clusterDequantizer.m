function [dx] = clusterDequantizer(qx, r)
    dx = zeros(length(qx), 1);
    for i = 1:1:length(qx)
        dx(i) = r(qx(i));
    end
end