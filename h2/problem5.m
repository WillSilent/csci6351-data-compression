k = 0:15;
x = (k-8).^2 / 4;
n = length(x);

% dct transformation
XDct= dct(x);

MSE(1:15) = 0;
for i = 1:15
    XHatDct = XDct;
    XHatDct(n - i + 1 : n) = 0;
    xHatDct = idct(XHatDct);
    MSE(i) = mean((xHatDct - x).^2);
end

display(MSE')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1:15;
figure(1);
plot(i,MSE);
title('MSE');
legend('MSE');
xlabel('n');

% 5.c
X_Hadam= 1/sqrt(n) * hadamard(n) * x';
X_Hadam_abs = abs(X_Hadam);
[sortXhadm, indexXhdam]=sort(X_Hadam_abs, 'ascend');

MSE_hadam(1:15) = 0;
for i = 1:15
    X_Hadam_Hat = X_Hadam;
    X_Hadam_Hat(indexXhdam(1:i)) = 0;
    smallx_Hadam_hat = 1/sqrt(n) * hadamard(n) * X_Hadam_Hat;
    MSE_hadam(i) = mean((smallx_Hadam_hat' - x).^2);
end
display(MSE_hadam')

i = 1:15;
figure(2);
plot(i,MSE_hadam);
title('HadamMSE');
legend('HadamMSE');
xlabel('n');

