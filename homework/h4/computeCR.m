function cr = computeCR(matrix, blockSize)
    % imageTotalPixels = width * height
    matrixSize = size(matrix);
    imageTotalPixels = matrixSize(1) * matrixSize(2);
    numberOfTotalBlocks = matrixSize(1) * matrixSize(2) / blockSize / blockSize;
    
    % dcTotalBits = numberOfTotalBlocks * bits/dc
    dcTotalBits =  numberOfTotalBlocks * log2(8);
    
    acTermNumber = floor((blockSize * blockSize - 1)/10);
    acTotalBits = numberOfTotalBlocks * acTermNumber * log2(4) + numberOfTotalBlocks * acTermNumber * log2(2);
    quantizedTotalBits = dcTotalBits + acTotalBits;
    
    % bitrate = quantizedTotalBits / imageTotalPixels; 
    % bits/px
    cr = imageTotalPixels * 8 / quantizedTotalBits;
end