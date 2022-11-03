[I,map]=imread('river.gif'); 
G=ind2gray(I,map);
imagesc(I); 
imagesc(G);

%% a. compute entropy
H = entropy(G);
%H_hat = computeEntropy(G);

%% b.uniform quantization
lv8 = 8;
%Quantize G
[uniqG, unids, unirs] = uniformQuantizer(G, lv8);

%compute the entropy of 𝐺u'
uniH = entropy(uniqG);

% dequantize 𝐺u' into ^Gu
[unidG] = uniformDequantizer(uniqG, unirs);

%display image
imagesc(unidG); colormap(gray); 

%Compute SNR
uniMSE = mean((unidG(:) - double(G(:))).^2);
uniSNR = 10*log10( sum(double(G(:)).^2) / sum((double(unidG(:)) - double(G(:))).^2) );

%% c.semi-uniform quantizer
[smqG, smds, smrs] = smquantizer2D(G, lv8);
smH = computeEntropy(smqG);
[smdG] = smdequantizer2D(smqG, smrs);

imagesc(smdG); colormap(gray);

smMSE = mean((double(smdG(:))-double(G(:))).^2);

smSNR = 10*log10(sum(double(G(:)).^2) / sum((double(smdG(:))-double(G(:))).^2));

%% d. Max-Lloyd quantizer
[MLqG, MLds, MLrs] = MLQuantizer(G, lv8);
MLH = computeEntropy(MLqG);
[MLdG] = MLDequantizer(MLqG, MLrs);

imagesc(MLdG); colormap(gray);

MLMSE = mean((double(MLdG(:))-double(G(:))).^2);
MLSNR = 10*log10(sum(double(G(:)).^2) / sum((double(MLdG(:))-double(G(:))).^2));


