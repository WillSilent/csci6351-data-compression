X = [0, 0.52, 0.55, 0.68, 0.91, 0.94, 0.97, 1.03, 1.04, 1.2, 1.3, 1.35, 1.4, 1.47, 1.6, 1.7, 1.85, 1.95, 1.99, 2.2 2.28, 2.45, 2.48, 2.56, 2.63, 2.67, 2.85, 3, 3.39, 3.57, 3.86, 3.99];
X = X';

n = 5;
[qx_5, r_5] = clusterQuantizer(X, n);

[dx_5] = clusterDequantizer(qx_5, r_5);

MSE5 = mean((dx_5 - X).^2);


n = 6;
[qx_6, r_6] = clusterQuantizer(X, n);

[dx_6] = clusterDequantizer(qx_6, r_6);

MSE6 = mean((dx_6 - X).^2);


n = 8;
[qx_8, r_8] = clusterQuantizer(X, n);

[dx_8] = clusterDequantizer(qx_8, r_8);

MSE8 = mean((dx_8 - X).^2);

res = [X dx_5 dx_6 dx_8];

n = [5 6 8];
MSEs = [MSE5 MSE6 MSE8];

figure(1);
plot(n,MSEs);
title('MSE’s of Cluster Quantizer');
legend('MSE');
xlabel('n');


