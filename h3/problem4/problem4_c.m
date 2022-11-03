[I,map] = imread('river.gif');
G = ind2gray(I, map);

dG = blockproc(G,[8 8],@(blkStruct) dct2(blkStruct.data));
size(dG)

m = 640 / 8;
n = 832 / 8;

rowDim = zeros(m, 1);
for i = 1:m
    rowDim(i) = 8;
end
colDim = zeros(n, 1);
for i = 1:n
    colDim(i) = 8;
end

% split the matrix into 8*8 block matrix 
dG2 = mat2cell(dG, rowDim, colDim);

%% get all the elements of term and counter-diagonals
count = 1;
dcTerm = zeros(m*n, 1);

elementIn9 = zeros(m*n*9, 1);
cn = 1;

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        %dc term
        dcTerm(count) = diag(B, 7);

        for k = 2:1:4
            tmp = diag(B, 8-k);
            for z = 1: length(tmp)
                elementIn9(cn) = tmp(z);
                cn = cn+1;
            end
        end
        count = count + 1;
    end
end

%% do uniform 8-level quantizer of DC term
[d, r] = uniform(dcTerm, 8);

%% do e 4-level uniform quantizer of elementIn9
[dOfEle9, rOfEle9] = uniform(elementIn9, 4);


%% do quantize of data
qG = zeros(640, 832);
for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        newMatrix = zeros(8, 8);
        
        %dc term
        [qx] = quantize2D(diag(B, 7), d);
        newMatrix = newMatrix + diag(qx, 7);

        for k = 2:1:4
            [qxOfEle9] = quantize2D(diag(B, 8-k), dOfEle9);
            newMatrix = newMatrix + diag(qxOfEle9, 8-k);
        end
        
        newBlock = flip(newMatrix,2);
        qG(((i-1)*8+1):(i*8),((j-1)*8+1):(j*8)) = newBlock;
    end
end

%% do dequantize of qG
dGhat = zeros(640, 832);
qG2 = mat2cell(qG, rowDim, colDim);
for i = 1:m
    for j = 1:n
        B = flip(qG2{i,j}, 2);

        newdGMatrix = zeros(8, 8);

        %term
        [dx] = dequantize2D(diag(B, 7), r);
        newdGMatrix = newdGMatrix + diag(dx, 7);

        for k = 2:1:5
            [dxOfEle9] = dequantize2D(diag(B, 8-k), rOfEle9);
            newdGMatrix = newdGMatrix + diag(dxOfEle9,  8-k);
        end

        newDGHatBlock = flip(newdGMatrix, 2);
        dGhat(((i-1)*8+1):(i*8),((j-1)*8+1):(j*8)) = newDGHatBlock;
    end
end

Ghat10= blockproc(dGhat,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat10);colormap(gray);
