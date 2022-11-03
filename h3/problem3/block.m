function dctX = block(X)
sizeX = size(X);
X= double(X);
dctX = X;

% compute the num of row blocks and column blocks
numRowBlock = sizeX(1)/8;
numColumnBlock = sizeX(2)/8;
for bi = 1:numRowBlock
    for bj = 1:numColumnBlock
        dctX( ((bi-1)*8+1):(bi*8),((bj-1)*8+1):(bj*8)) = dct2(X( ((bi-1)*8+1):(bi*8),((bj-1)*8+1):(bj*8)));
    end
end
end