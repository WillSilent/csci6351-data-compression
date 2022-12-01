function [dGhat] = dequantize(imageSizeX, block_size, qxOfDcTerm, rOfDcTerm, qxOfAcTerm, rOfFirstACTerm, rOfNextACTerm)
    m = imageSizeX(1) / block_size;
    n = imageSizeX(2) / block_size;
    dGhat = zeros(imageSizeX(1), imageSizeX(2));
    
    dcCount = 1;

    begin = 1;
    eachSize = block_size * block_size - 1;
    term_size = floor(eachSize / 10);

    for i = 1:m
        for j = 1:n
            
            newdGMatrix = zeros(block_size, block_size);
    
            % dc term
            [dx] = dequantize2D(qxOfDcTerm(dcCount), rOfDcTerm);
            newdGMatrix = newdGMatrix + diag(dx, block_size - 1);
            dcCount = dcCount + 1;

            % first ac term
            stop = begin + term_size - 1;
            [dxOfFirstAcTerm] = dequantize2D(qxOfAcTerm(begin:stop), rOfFirstACTerm);

            % next ac term
            begin = stop + 1;
            stop = begin + term_size - 1;
            [dxOfNextAcTerm] = dequantize2D(qxOfAcTerm(begin:stop), rOfNextACTerm);

            % remian ac term
            stop = stop + (eachSize - 2*term_size);
            begin = stop + 1;

            % reconstruct each blocks's ac term 
            allDxOfActerm = zeros(eachSize,1);
            index = 1;
            stop = index + term_size - 1;
            allDxOfActerm(index : stop) = dxOfFirstAcTerm;
            index = stop + 1;
            stop = index + term_size - 1;
            allDxOfActerm(index:stop) = dxOfNextAcTerm;
            
            index = 1;
            for diagIndex = block_size - 2: -1 : (-1*block_size + 1)
                sizeX = size(diag(newdGMatrix, diagIndex));
                stop = index + sizeX(1) - 1;
                
                ele = diag(allDxOfActerm(index:stop), diagIndex);

                if mod(diagIndex, 2) ~=  0
                    ele = diag(flip(allDxOfActerm(index:stop)), diagIndex);
                end
                
                newdGMatrix = newdGMatrix + ele;
                index = stop + 1;
            end
            
            newDGHatBlock = flip(newdGMatrix, 2);
            dGhat(((i-1)*block_size+1):(i*block_size),((j-1)*block_size+1):(j*block_size)) = newDGHatBlock;
        end
    end
end