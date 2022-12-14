[I,map] = imread('river.gif');
G = ind2gray(I, map);

dG = blockproc(G,[8 8],@(blkStruct) dct2(blkStruct.data));

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

%% collect all the data of term and element that need to be a 4-level quantize
count = 1;
dcTerm = zeros(m*n, 1);

cn14 = 1;
element14 = zeros(m*n*14, 1);

cn9 = 1;
element9 = zeros(m*n*9, 1);

cn5 = 1;
element5 = zeros(m*n*5, 1);

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        %dc term
        dcTerm(count) = diag(B, 7);
        
        % element14
        for k = 2:1:5
            tmp = diag(B, 8-k);
            for z = 1: length(tmp)
                element14(cn14) = tmp(z);
                cn14 = cn14+1;
            end
        end

        % element9
        for k = 2:1:4
            tmp = diag(B, 8-k);
            for z = 1: length(tmp)
                element9(cn9) = tmp(z);
                cn9 = cn9+1;
            end
        end

        % element5
        for k = 2:1:3
            tmp = diag(B, 8-k);
            for z = 1: length(tmp)
                element5(cn5) = tmp(z);
                cn5 = cn5+1;
            end
        end

        count = count + 1;
    end
end

%% do uniform 8-level quantizer of DC term
[dOfTerm, rOfTerm] = uniform(dcTerm, 8);

%% do e 4-level uniform quantizer of element
[dOfEle14, rOfEle14]= uniform(element14, 4);
[dOfEle9, rOfEle9]= uniform(element9, 4);
[dOfEle5, rOfEle5]= uniform(element5, 4);

%% do quantize of data
[qG14] = quantize(dG2, dOfTerm, dOfEle14, 5);
[qG9] = quantize(dG2, dOfTerm, dOfEle9, 4);
[qG5] = quantize(dG2, dOfTerm, dOfEle5, 3);
[qG1] = quantize(dG2, dOfTerm, dOfTerm, 1);

%% do dequantize of qG
qG14_2 = mat2cell(qG14, rowDim, colDim);
[dGhat14] = dequantize(qG14_2, rOfTerm, rOfEle14, 5);

qG9_2 = mat2cell(qG9, rowDim, colDim);
[dGhat9] = dequantize(qG9_2, rOfTerm, rOfEle9, 4);

qG5_2 = mat2cell(qG5, rowDim, colDim);
[dGhat5] = dequantize(qG5_2, rOfTerm, rOfEle5, 3);

qG1_2 = mat2cell(qG1, rowDim, colDim);
[dGhat1] = dequantize(qG1_2, rOfTerm, rOfTerm, 1);

%% show image and compute snr
Ghat15= blockproc(dGhat14,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat15);colormap(gray);
snr15 = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat15(:)) - double(G(:))).^2) );

Ghat10= blockproc(dGhat9,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat10);colormap(gray);
snr10 = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat10(:)) - double(G(:))).^2) );

Ghat9= blockproc(dGhat5,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat9);colormap(gray);
snr9 = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat9(:)) - double(G(:))).^2) );

Ghat1= blockproc(dGhat1,[8 8],@(blkStruct) idct2(blkStruct.data));
imagesc(Ghat1);colormap(gray);
snr1 = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat1(:)) - double(G(:))).^2) );





