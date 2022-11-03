
%str = "the dog in the fog";
str = "ababbccab";
%str = "TCATC$";

%BWT transform
[y, L] = BWT(str);
display(y)
display(L)


B = y
tmp = sortrows(B)
B(1:9, 9) = tmp(1:9, 8)



% construct B from (y,L)
y = inverseBWT(y);
display(y)

x = getOriginalX(y,L);


