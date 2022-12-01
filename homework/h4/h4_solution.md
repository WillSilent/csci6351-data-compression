# Homework4

### A. River

##### 1. Display images with SNRs and Compression Ratio

- origin gray image

    ​	<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201152527500.png" alt="image-20221201152527500" style="zoom: 25%;" />

- Block_size = 4, SNR = 9.2600, CR = 21.3333

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154134008.png" alt="image-20221201154134008" style="zoom:25%;" />

- Block_size = 8, SNR = 5.8522, CR = 24.3810

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154222293.png" alt="image-20221201154222293" style="zoom:25%;" />

- Block_size = 16, SNR = 4.5679, CR = 26.2524

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154318291.png" alt="image-20221201154318291" style="zoom:25%;" />

- Block_size = 32, SNR = 2.9817, CR = 26.5113

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154408891.png" alt="image-20221201154408891" style="zoom:25%;" />

- Block_size = 64, SNR = 5.3376, CR = 26.6407

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154512767.png" alt="image-20221201154512767" style="zoom:25%;" />

##### 2. SNR's graph

​	<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201160048733.png" alt="image-20221201160048733" style="zoom:25%;" />

When blockSize = 4 gives the best SNR.	

<hr>

### B. Lake

##### 1. Display images with SNRs and Compression Ratio

- origin gray image

    ​	<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201152710560.png" alt="image-20221201152710560" style="zoom:25%;" />

- Block_size = 4, SNR = 10.0936, CR = 21.3333

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154850793.png" alt="image-20221201154850793" style="zoom:25%;" />

- Block_size = 8, SNR = 3.6839, CR = 24.3810

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201154936644.png" alt="image-20221201154936644" style="zoom:25%;" />

- Block_size = 16, SNR = 2.6008, CR = 26.2564

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201155018777.png" alt="image-20221201155018777" style="zoom:25%;" />

- Block_size = 32, SNR = 3.8698, CR = 26.5113

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201155112518.png" alt="image-20221201155112518" style="zoom:25%;" />

- Block_size = 64, SNR = 4.3307, CR = 26.6407

​			<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201155156565.png" alt="image-20221201155156565" style="zoom:25%;" />



##### 2. SNR's graph

​	<img src="/Users/will/Library/Application Support/typora-user-images/image-20221201160140840.png" alt="image-20221201160140840" style="zoom:25%;" />

When blockSize = 4 gives the best SNR.

<hr>

### Appendix:

##### a. Apply dct2 on 𝑛 × 𝑛 blocks of G;

```matlab
%% river
[I,map] = imread('river.gif');
river_G = ind2gray(I, map);
imagesc(river_G); colormap(gray); 
% filename = sprintf('river_grey.gif');
% imwrite (G, filename);

%% lake
[I,map] = imread('lake.gif');
lake_G = ind2gray(I, map);

% remove the minimum rows and minimum colums
% because the lake's size is (638,850), we should make the dimension that can be mulipled by 64
% row = 576, col = 832
lake_G = lake_G(1:576, 1:832);

G = river_G;
imagesc(G); colormap(gray); 

% block size
block_size = 4;

% apply dct2
dG = blockproc(G,[block_size block_size],@(blkStruct) dct2(blkStruct.data));

imageSizeX = size(dG);
m = imageSizeX(1) / block_size;
n = imageSizeX(2) / block_size;
```

##### b.  Quantize all the DC terms of all the blocks as one data set, using a uniform 8-level quantizer in the range from ⌊min(DC Terms)⌋ to ⌈max(DC Terms)⌉;

```matlab
%% b.Quantize all the DC terms
rowDim = zeros(m, 1);
for i = 1:m
    rowDim(i) = block_size;
end

colDim = zeros(n, 1);
for i = 1:n
    colDim(i) = block_size;
end

% split the matrix into block matrix 
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
```

##### c. Order the AC terms within each block in a counter-diagonal zigzag form;

```matlab
% collect all the ac terms
begin = 1;
eachSize = block_size * block_size - 1;
acTerms = zeros(m*n*eachSize, 1);

for i = 1:m
    for j = 1:n
        B = flip(dG2{i,j}, 2);

        % ac term
        for diagIndex = block_size - 2: -1 : (-1*block_size + 1)
            ele = diag(B, diagIndex);
            sizeX = size(ele);

            %flip the element when the diag index is not even
            if mod(k, 2) ~= 0
                ele = flip(diag(B, diagIndex));
            end
            
            stop = begin + sizeX(1) - 1;
            % append the elements into ac terms.
            acTerms(begin:stop, :) = ele;
            
            begin = stop + 1;
        end

    end
end
```

##### d. Among all the AC terms across all the blocks, let L=⌊min(AC terms)⌋, and let H=⌈max(AC terms)⌉;

```matlab
L = floor(min(acTerms(:)));
H = ceil(max(acTerms(:)));
```

##### e. Within each block, quantize the first $floor(\frac{n^2-1}{10})$ AC terms with a 4-level uniform quantizer of the range [L, H), then quantize the next $floor(\frac{n^2-1}{10})$AC terms with a 2- level uniform quantizer of the range [L, H), and zero out all the remaining AC terms;

```matlab
begin = 1;
term_size = floor((block_size*block_size - 1) / 10);
sizeX = size(acTerms);
qxOfAcTerm = zeros(sizeX(1), sizeX(2));

while begin < sizeX(1)
    % the first term_size ac terms
    stop = begin+term_size-1;
    ele = acTerms(begin:stop);
    
    % a 4-level uniform quantizer of the range [L, H)
    [dOfFirstACTerm, rOfFirstACTerm] = uniformAcTerm(4, L, H);
    [qxOfFirstAcTerm] = quantize2D(ele, dOfFirstACTerm);
    qxOfAcTerm(begin:stop) = qxOfFirstAcTerm;

    % the next term_size ac terms
    begin = stop + 1;
    stop = begin+term_size-1;
    ele = acTerms(begin:stop);
    
    % a 2-level uniform quantizer of the range [L, H)
    [dOfNextACTerm, rOfNextACTerm] = uniformAcTerm(2, L, H);
    [qxOfNextAcTerm] = quantize2D(ele, dOfNextACTerm);
    qxOfAcTerm(begin:stop) = qxOfNextAcTerm;

    % zero out remained ac terms
    begin = stop + 1;
    stop = begin + (eachSize - 2*term_size)-1;
    qxOfAcTerm(begin:stop) = 0;

    begin = stop + 1;
end
```

##### f. Reconstruct the image by dequantizing the quantized values, and then applying blockwise idct2

```matlab
% dequantizing
 [dGhat] = dequantize(imageSizeX, block_size, qxOfDcTerm, rOfDcTerm, qxOfAcTerm, rOfFirstACTerm, rOfNextACTerm);
 Ghat = blockproc(dGhat,[block_size block_size],@(blkStruct) idct2(blkStruct.data));
 Ghat = uint8(Ghat);
 imagesc(Ghat);colormap(gray);
```

```matlab
function [dGhat] = dequantize(imageSizeX, 
															block_size, qxOfDcTerm, rOfDcTerm, qxOfAcTerm, rOfFirstACTerm, rOfNextACTerm)
    
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
            
            % reconstruct the block after dequantized
            index = 1;
            for diagIndex = block_size - 2: -1 : (-1*block_size + 1)
                sizeX = size(diag(newdGMatrix, diagIndex));
                stop = index + sizeX(1) - 1;
                
                ele = diag(allDxOfActerm(index:stop), diagIndex);
								
								% flip element when diagIndex is not even
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
```

##### g. Compute the compression ratio and the SNR. 

```matlab
snr = 10*log10( sum(double(G(:)).^2) / sum((double(Ghat(:)) - double(G(:))).^2) );
CR = computeCR(Ghat, block_size);
```

```matlab
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
```

##### h. other functions

```matlab
function [ds, rs] = uniform(x, lv)
    x = double(x);
    ds = zeros(lv+1,1);
    rs = zeros(lv,1);
    
    deta = (ceil(max(x(:))) - floor(min(x(:)))) / lv;
    
    ds(1) = floor(min(x(:)));
    for i = 2: lv+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: lv
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end
```

```matlab
function [ds, rs] = uniformAcTerm(lv, L, H)
    ds = zeros(lv+1,1);
    rs = zeros(lv,1);
    
    deta = (double(H) - double(L)) / lv;
  
    ds(1) = double(L);
    for i = 2: lv+1
        ds(i) = ds(i-1)+deta;
    end
    
    for i = 1: lv
        rs(i) = (ds(i)+ds(i+1))/2;
    end
end
```

```matlab
function [qx] = quantize2D(x, ds)
    lv = length(ds)-1;
    sizeX = size(x);
    qx = x;
    
    % quantizer every element in x
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            % find:
            %   false: the interval has not been found
            %   true: the interval has been found
            find = false;
            % k: the index for d's
            k = 2;

            % while: loop until the interval is found
            while ~find
                if ds(k) > x(i,j)
                    find = true;
                end

                % d(j) is the upper bound of the last interval
                % x(i) is equal to the upper bound of the last interval
                if (k == lv) && (ds(k) == x(i,j))
                    find = true;
                end

                if ~find
                    k = k + 1;
                end
            end
            qx(i,j) = k-1;
        end
    end
end
```

```matlab
function [dx] = dequantize2D(qx, rs)
    dx = qx;
    sizeX = size(qx);
    
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            dx(i,j) = rs(qx(i,j));
        end
    end
end
```

