[I,map] = imread('river.gif');
G = ind2gray(I, map);

dG = blockproc(G,[8 8],@(blkStruct) dct2(blkStruct.data));
% Ghat= blockproc(dG,[8 8],@(blkStruct) idct2(blkStruct.data));
% imagesc(Ghat);colormap(gray);

% get all the dc term elements
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

count = 1;
dcTerm = zeros(m*n, 1);

elementIn14 = zeros(m*n*14, 1);
cn = 1;

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        %dc term
        dcTerm(count) = diag(B, 7);

        for k = 2:1:5
            tmp = diag(B, 8-k);
            for z = 1: length(tmp)
                elementIn14(cn) = tmp(z);
                cn = cn+1;
            end
        end
            
%         %2nd
%         elementIn14(1:2) = diag(B, 6);
% 
%         %3rd
%         elementIn14(3:5) = diag(B, 5);
% 
%         %4th
%         elementIn14(6:9) = diag(B, 4);
% 
%         %5th
%         elementIn14(10:14) = diag(B, 3);

        count = count + 1;
    end
end

%% do uniform 8-level quantizer of DC term
[d, r] = uniform(dcTerm, 8);

%% do e 4-level uniform quantizer of elementIn14
[dOfEle14, rOfEle14] = uniform(elementIn14, 4);

%% do quantize of data
qG = zeros(640, 832);
for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        newMatrix = zeros(8, 8);
        
        %dc term
        [qx] = quantize2D(diag(B, 7), d);
        newMatrix = newMatrix + diag(qx, 7);

        for k = 2:1:5
            [qxOfEle14] = quantize2D(diag(B, 8-k), dOfEle14);
            newMatrix = newMatrix + diag(qxOfEle14, 8-k);
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
            [dxOfEle14] = dequantize2D(diag(B, 8-k), rOfEle14);
            newdGMatrix = newdGMatrix + diag(dxOfEle14,  8-k);
        end

        newDGHatBlock = flip(newdGMatrix, 2);
        dGhat(((i-1)*8+1):(i*8),((j-1)*8+1):(j*8)) = newDGHatBlock;
    end
end

Ghat= blockproc(dGhat,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat);colormap(gray);

br15 = (640*832*3) / (640*832*8);
cr15 = (640*832*8) / (640*832*3);
snr15 = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat(:)) - double(G(:))).^2) );

