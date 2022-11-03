function [dGhat] = dequantize(qG2, rOfTerm, rOfEle, ith)
    m = 640 / 8;
    n = 832 / 8;
    dGhat = zeros(640, 832);
    
    for i = 1:m
        for j = 1:n
            B = flip(qG2{i,j}, 2);
    
            newdGMatrix = zeros(8, 8);
    
            %term
            [dx] = dequantize2D(diag(B, 7), rOfTerm);
            newdGMatrix = newdGMatrix + diag(dx, 7);
            
            if ith > 1
                for k = 2:1:ith
                    [dxOfEle14] = dequantize2D(diag(B, 8-k), rOfEle);
                    newdGMatrix = newdGMatrix + diag(dxOfEle14,  8-k);
                end
            end
    
            newDGHatBlock = flip(newdGMatrix, 2);
            dGhat(((i-1)*8+1):(i*8),((j-1)*8+1):(j*8)) = newDGHatBlock;
        end
    end
end