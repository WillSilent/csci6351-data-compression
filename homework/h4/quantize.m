function [qG] = quantize(dG2, dOfTerm, dOfEle, ith)
    m = 640 / 8;
    n = 832 / 8;
    % do quantize of data
    qG = zeros(640, 832);
    for i = 1:m
        for j = 1:n
            B = flip(dG2{i,j}, 2);
            
            newMatrix = zeros(8, 8);
            
            %dc term
            [qx] = quantize2D(diag(B, 7), dOfTerm);
            newMatrix = newMatrix + diag(qx, 7);
            
            if ith > 1
                for k = 2:1:ith
                    [qxOfEle] = quantize2D(diag(B, 8-k), dOfEle);
                    newMatrix = newMatrix + diag(qxOfEle, 8-k);
                end
            end
           
            newBlock = flip(newMatrix,2);
            qG(((i-1)*8+1):(i*8),((j-1)*8+1):(j*8)) = newBlock;
        end
    end
end