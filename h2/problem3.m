% XDct be the DCT of x, and YDct the DCT of y. 
% XHatDct be derived from XDct by replacing the last 11 elements of XDct by zeros while keeping the rest of the elements the same
% YHatDct similarly from YDct. 
% xHatDct be the inverse DCT of XHatDct, and yHatDct the inverse DCT of YHatDct.

% base equations
k = 0:15;
x = (k-8).^2 / 4;
y = cos(k * (pi/16) + 1) + sin((2*k+1) * (pi/16));

% dct transformation
XDct= dct(x);
YDct = dct(y);

XHatDct = XDct;
XHatDct(6:16) = 0;
YHatDct = YDct;
YHatDct(6:16) = 0;

% inverse dct of XHatDct
xHatDct = idct(XHatDct);
yHatDct = idct(YHatDct);

table1 = [XDct' XHatDct'];
display(table1)
table2 = [YDct' YHatDct'];
display(table2)
table3 = [x' xHatDct'];
display(table3)
table4 = [y' yHatDct'];
display(table4)

% plot 
figure(1);
plot(k,x);
hold on;
plot(k, xHatDct);
legend('x', 'xHatDct');
title('DCT: x vs. xHatDct');
xlabel('k');
hold off;

figure(2);
plot(k, y);
hold on;
plot(k, yHatDct);
legend('y', 'yHatDct');
title('DCT: y vs. yHatDct');
xlabel('k');
hold off;

% 3.c MSE
xMSE3 = mean((xHatDct - x).^2);
yMSE3 = mean((yHatDct - x).^2);

% 3.d SNR

xSNR3 = 20 * log10(abs(x) / abs(x-xHatDct));
ySNR3 = 20 * log10(abs(y) / abs(y-yHatDct));


