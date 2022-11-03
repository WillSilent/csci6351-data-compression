function [qx, ds, rs] = uniformQuantizer(x, n, dn)

    [ds,rs] = uniform(n, dn);
    [qx] = quantize2D(x, ds);
    
end