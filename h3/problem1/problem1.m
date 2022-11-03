X = [0, 0.52, 0.55, 0.68, 0.91, 0.94, 0.97, 1.03, 1.04, 1.2, 1.3, 1.35, 1.4, 1.47, 1.6, 1.7, 1.85, 1.95, 1.99, 2.2 2.28, 2.45, 2.48, 2.56, 2.63, 2.67, 2.85, 3, 3.39, 3.57, 3.86, 3.99];
dn = 4;

% n = 5
n5 = 5;
[qx_n5, d_n5, r_n5] = MLQuantizer(X, n5, dn);
[dx_n5] = MLDequantizer(qx_n5, r_n5);

%n = 6
n6 = 6;
[qx_n6, d_n6, r_n6] = MLQuantizer(X, n6, dn);
[dx_n6] = MLDequantizer(qx_n6, r_n6);

% n = 8
n8 = 8;
[qx_n8, d_n8, r_n8] = MLQuantizer(X, n8, dn);
[dx_n8] = MLDequantizer(qx_n8, r_n8);

mse5 = mean((dx_n5-X).^2);
mse6 = mean((dx_n6-X).^2);
mse8 = mean((dx_n8-X).^2);

n = [5 6 8];
MSEs = [mse5 mse6 mse8];

figure(1);
plot(n,MSEs);
title('MSE’s of MLn');
legend('MSE');
xlabel('n');


res1 = [X' qx_n5' dx_n5'];
res2 = [X' qx_n6' dx_n6'];
res3 = [X' qx_n8' dx_n8'];

% c
[qx_n5_uni, d_n5_uni, r_n5_uni] = uniformQuantizer(X, n5, dn);
[dx_n5_uni] = uniformDequantizer(qx_n5_uni, r_n5_uni);
mse5_uni = mean((dx_n5_uni-X).^2);

[qx_n6_uni, d_n6_uni, r_n6_uni] = uniformQuantizer(X, n6, dn);
[dx_n6_uni] = uniformDequantizer(qx_n6_uni, r_n6_uni);
mse6_uni = mean((dx_n6_uni-X).^2);

[qx_n8_uni, d_n8_uni, r_n8_uni] = uniformQuantizer(X, n8, dn);
[dx_n8_uni] = uniformDequantizer(qx_n8_uni, r_n8_uni);
mse8_uni = mean((dx_n8_uni-X).^2);

res4 = [X' qx_n5_uni' dx_n5_uni'];
res5 = [X' qx_n6_uni' dx_n6_uni'];
res6 = [X' qx_n8_uni' dx_n8_uni'];

% d
[qx_n5_smi, d_n5_smi, r_n5_smi] = smquantizer(X, n5, dn);
[dx_n5_smi] = smdequantizer(qx_n5_smi, r_n5_smi);
mse5_smi = mean((dx_n5_smi - X).^2);

[qx_n6_smi, d_n6_smi, r_n6_smi] = smquantizer(X, n6, dn);
[dx_n6_smi] = smdequantizer(qx_n6_smi, r_n6_smi);
mse6_smi = mean((dx_n6_smi - X).^2);

[qx_n8_smi, d_n8_smi, r_n8_smi] = smquantizer(X, n8, dn);
[dx_n8_smi] = smdequantizer(qx_n8_smi, r_n8_smi);
mse8_smi = mean((dx_n8_smi - X).^2);

res7 = [X' qx_n5_smi' dx_n5_smi'];
res8 = [X' qx_n6_smi' dx_n6_smi'];
res9 = [X' qx_n8_smi' dx_n8_smi'];
