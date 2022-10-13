% X_Hadam and Y_Hadam are the Hadamard transforms of x and y.
% X_Hadam_abs is the magnitudes of the elements of X_Hadam, Y_Hadam_abs is the
% same.
% X_Hadam_Hat is derived from X_Had by replacing the 11 smallest-magnitude elements of X_Hadam by zeros 
% while keeping the rest of the elements the same. Y_Hadam_Hat is defined similarly.
% smallx_Hadam_hat is the inverse Hadamard transforms of X_Hadam_Hat,
% smally_Hadam_hat is the same.

k = 0:15;
x = (k-8).^2 / 4;
y = cos(k * (pi/16) + 1) + sin((2*k+1) * (pi/16));

n = length(x);

X_Hadam= 1/sqrt(n) * hadamard(n) * x';
Y_Hadam= 1/sqrt(n) * hadamard(n) * y';

X_Hadam_abs = abs(X_Hadam);
Y_Hadam_abs = abs(Y_Hadam);

[sortXhadm, indexXhdam]=sort(X_Hadam_abs, 'ascend');
X_Hadam_Hat = X_Hadam;
X_Hadam_Hat(indexXhdam(1:11)) = 0;

[sortYhadm, indexYhdam]=sort(Y_Hadam_abs, 'ascend');
Y_Hadam_Hat = Y_Hadam;
Y_Hadam_Hat(indexYhdam(1:11)) = 0;

table1 = [X_Hadam X_Hadam_abs X_Hadam_Hat];
display(table1)

table2 = [Y_Hadam Y_Hadam_abs Y_Hadam_Hat];
display(table2)

%do inverse Hadamard transformation
smallx_Hadam_hat = 1/sqrt(n) * hadamard(n) * X_Hadam_Hat;
% xhathadm = hadamard(length(x))*Xhathadm;
smally_Hadam_hat = 1/sqrt(n) * hadamard(n) * Y_Hadam_Hat;

table3 = [x' smallx_Hadam_hat];
display(table3)
table4 = [y' smally_Hadam_hat];
display(table4)

% 4.b
xMSE4 = mean((smallx_Hadam_hat' - x).^2);
yMSE4 = mean((smally_Hadam_hat' - x).^2);

%4.c
figure(1)
plot(k,x)
hold on;
plot(k, xHat);
hold on;
plot(k, xHatDct);
hold on;
plot(k, smallx_Hadam_hat);
title('x and the three xhat');
legend('x', 'xHat', 'xDctHat', 'xHadamhat');
xlabel('k');
hold off;

figure(2)
plot(k,y)
hold on;
plot(k, yHat);
hold on;
plot(k, yHatDct);
hold on;
plot(k, smally_Hadam_hat);
title('y and the three yhat');
legend('y', 'yHat', 'yDctHat', 'yHadamhat');
xlabel('k');
hold off;








