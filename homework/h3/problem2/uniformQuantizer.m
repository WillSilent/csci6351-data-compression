function [qx, ds, rs] = uniformQuantizer(x, lv)

    [ds,rs] = uniform(x, lv);
    [qx] = quantize2D(x, ds);
    
end