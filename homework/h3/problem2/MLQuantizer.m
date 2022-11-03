function [qx, ds, rs] = MLQuantizer(x, lv)

    % calculate the optimal decision levels d's and reconstruction levels
    [ds,rs] = MaxLloyd(x, lv);
    
    [qx] = quantize2D(x, ds);
    
    
end