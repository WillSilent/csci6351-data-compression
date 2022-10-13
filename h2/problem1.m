
str = "the dog in the fog";
%str = "ababbccab";
%str = "TCATC$";

%BWT transform
[y, L] = BWT(str);
display(y)
display(L)

% construct B from (y,L)
[n,row] = size(y);
%last_row = y(1:n, i);
for i = 1:n-1
    newY = sortrows(y);
    last_row = newY(1:n, i);
    y(1:n, i+1) = last_row;
end

display(sortrows(y))
