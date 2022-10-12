% base equations
k = 0:15;
x = (k-8).^2 / 4;
y = cos(k * (pi/16) + 1) + sin((2*k+1) * (pi/16));


% fourier(x) %fourier未定义

% fourier transformation
Xfft = fft(x);
Yfft = fft(y);

% absolute value of X and Y
Xabs= abs(Xfft);
Yabs= abs(Yfft);

% Xhat is a column derived from Xfft by replacing each of the 11 smallest-magnitude
% elements of Xfft by 0, and leaving the other elements intact. YHat is defined similarly.
[sortXfft, indexXfft] = sort(Xabs, 'ascend');
indexXfft(1:11)
%sortXfft(1:11)
XHat = Xfft;

XHat(indexXfft(1:11)) = 0


[sortYfft, indexYfft] = sort(Yabs, 'ascend');
indexYfft(1:11)
%sortYfft(1:11)
YHat = Yfft;

YHat(indexYfft(1:11)) = 0

% xHat is the inverse Fourier transform of XHat, yHat is similar
xHat = ifft(XHat);
yHat = ifft(YHat);

table1 = [Xfft' Xabs' XHat']
table2 = [Yfft' Yabs' YHat']
table3 = [x' xHat']
table4 = [y' yHat']

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
xMSE = mean((xHat - x).^2)
yMSE = mean((yHat - x).^2)

% 2.d SNR
xSNR = 20 * log10(x/(x-xHat))
ySNR = 20 * log10(y/(y-yHat))