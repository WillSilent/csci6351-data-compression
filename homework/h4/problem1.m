%% river
[I,map] = imread('river.gif');
G = ind2gray(I, map);
% imagesc(G); colormap(gray); 
% filename = sprintf('river_grey.gif');
% imwrite (G, filename);

%% lake
% [I,map] = imread('lake.gif');
% G = ind2gray(I, map);

% remove the minimum rows and minimum colums
% row = 576, col = 832
% G = G(1:576, 1:832);
% imagesc(G); colormap(gray); 

size_set = [4 8 16 32 64];
snr_set = zeros(5,1);
cr_set = zeros(5,1);

for i = 1:5
    [Ghat, snr, cr] = image_compress(G, size_set(i));
    imagesc(Ghat);colormap(gray);
    snr_set(i) = snr;
    cr_set(i) = cr;

    %filename = sprintf('%s_%d.gif', "river", block_size);
    %filename = sprintf('%s_%d.gif', "lake", block_size);
    %imwrite (Ghat, filename);
end

% %river
% %snr_set = [9.2600 5.8522 4.5679 2.9817 5.3376];
% 
% %lake
% snr_set = [10.0936 3.6839 2.6608 3.8698 4.3307];

figure(1);
plot(size_set,snr_set);
title('SNR’s of Different Block Size');
legend('SNR');
xlabel('blockSize');









