% base equations
k = 0:15;
x = (k-8).^2 / 4;
y = cos(k * (pi/16) + 1) + sin((2*k+1) * (pi/16));

% fourier transformation
Xfft = fft(x);
display(Xfft')
Yfft = fft(y);
display(Yfft')

% absolute value of X and Y
Xabs= abs(Xfft);
display(Xabs')
Yabs= abs(Yfft);
display(Yabs')

% XHat is a column derived from Xfft by replacing each of the 11 smallest-magnitude
% elements of Xfft by 0, and leaving the other elements intact. YHat is defined similarly.
[sortXfft, indexXfft] = sort(Xabs, 'ascend');
indexXfft(1:11)
%sortXfft(1:11)

XHat = Xfft;
XHat(indexXfft(1:11)) = 0;
display(XHat')

[sortYfft, indexYfft] = sort(Yabs, 'ascend');
indexYfft(1:11)
%sortYfft(1:11)
YHat = Yfft;
YHat(indexYfft(1:11)) = 0;
display(YHat')

% xHat is the inverse Fourier transform of XHat, yHat is similar
xHat = ifft(XHat);
display(xHat')

yHat = ifft(YHat);
display(yHat')


table1 = [Xfft' Xabs' XHat'];
display(table1)
table2 = [Yfft' Yabs' YHat'];
display(table2)
table3 = [x' xHat'];
display(table3)
table4 = [y' yHat'];
display(table4)

% 2.b figure
figure(1)
plot(k,x)
hold on;
plot(k, xHat);
title('Fourier: x vs. xHat');
legend('x', 'xHat');
xlabel('k');
hold off;

figure(2);
plot(k, y);
hold on;
title('Fourier: y vs. yHat');
plot(k, yHat);
legend('y', 'yHat');
xlabel('k');
hold off;

% 2.c MSE
xMSE2 = mean((xHat - x).^2);
yMSE2 = mean((yHat - y).^2);

% 2.d SNR
xSNR2 = 20 * log10(abs(x)/abs(x-xHat));
ySNR2 = 20 * log10(abs(y)/abs(y-yHat));