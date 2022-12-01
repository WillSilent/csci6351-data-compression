function [Ghat, snr, cr] = image_compress(G, block_size)
    
%% a.Apply dct2
dG = blockproc(G,[block_size block_size],@(blkStruct) dct2(blkStruct.data));

imageSizeX = size(dG);
m = imageSizeX(1) / block_size;
n = imageSizeX(2) / block_size;
    
%% b.Quantize all the DC terms
rowDim = zeros(m, 1);
for i = 1:m
    rowDim(i) = block_size;
end

colDim = zeros(n, 1);
for i = 1:n
    colDim(i) = block_size;
end

% split the matrix into blockSize*blockSize block matrix 
dG2 = mat2cell(dG, rowDim, colDim);

% collect all the dc term
count = 1;
dcTerm = zeros(m*n, 1);

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);
        
        % dc term
        dcTerm(count) = diag(B, block_size-1);
        count = count + 1;
    end
end

% do uniform 8-level quantizer of DC term
[dOfTerm, rOfDcTerm] = uniform(dcTerm, 8);
[qxOfDcTerm] = quantize2D(dcTerm, dOfTerm);

    
    
    %% c.Order the AC terms within each block in a counter-diagonal zigzag form;
    
% collect all the ac terms
acCount = 1;
eachSize = block_size * block_size - 1;
acTerms = zeros(m*n*eachSize, 1);

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);

        % ac term
        for k = block_size - 2: -1 : (-1*block_size + 1)
            ele = diag(B, k);
            sizeX = size(ele);

            %flip the element
            if mod(k, 2) ~= 0
                ele = flip(diag(B, k));
            end
            
            stop = acCount + sizeX(1) - 1;
            acTerms(acCount:stop, :) = ele;
            
            acCount = acCount + sizeX(1);
        end

    end
end
    
    %% d. Among all the AC terms across all the blocks, let L=⌊min(AC terms)⌋, and let H=⌈min(AC terms)⌉;
    L = floor(min(acTerms(:)));
    H = ceil(max(acTerms(:)));
    
    %% e. quantize the ac terms
begin = 1;
term_size = floor((block_size*block_size - 1) / 10);
sizeX = size(acTerms);
qxOfAcTerm = zeros(sizeX(1), sizeX(2));

while begin < sizeX(1)
    
    % the first term_size ac terms
    stop = begin+term_size-1;
    ele = acTerms(begin:stop);
    [dOfFirstACTerm, rOfFirstACTerm] = uniformAcTerm(4, L, H);
    [qxOfFirstAcTerm] = quantize2D(ele, dOfFirstACTerm);
    qxOfAcTerm(begin:stop) = qxOfFirstAcTerm;

    % the next term_size ac terms
    begin = stop + 1;
    stop = begin+term_size-1;
    ele = acTerms(begin:stop);
    [dOfNextACTerm, rOfNextACTerm] = uniformAcTerm(2, L, H);
    [qxOfNextAcTerm] = quantize2D(ele, dOfNextACTerm);
    qxOfAcTerm(begin:stop) = qxOfNextAcTerm;

    % zero out remained ac terms
    begin = stop + 1;
    stop = begin + (eachSize - 2*term_size)-1;
    qxOfAcTerm(begin:stop) = 0;

    begin = stop + 1;
end

%% f. Reconstruct the image by dequantizing the quantized values, and then applying blockwise idct2

% dequantizing
[dGhat] = dequantize(imageSizeX, block_size, qxOfDcTerm, rOfDcTerm, qxOfAcTerm, rOfFirstACTerm, rOfNextACTerm);
Ghat = blockproc(dGhat,[block_size block_size],@(blkStruct) idct2(blkStruct.data));
Ghat = uint8(Ghat);
%imagesc(Ghat);colormap(gray);


%% g.Compute the compression ratio and the SNR.
snr = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat(:)) - double(G(:))).^2) );
cr = computeCR(Ghat, block_size);

end