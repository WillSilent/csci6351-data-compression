function [qx, ds, rs] = smquantizer2D(x, lv)

    [ds, rs] = semi_uniform2D(x, lv);
    
    [qx] = quantize2D(x, ds);
    
    
end