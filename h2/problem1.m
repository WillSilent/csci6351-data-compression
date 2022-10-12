% https://blog.csdn.net/fjsd155/article/details/97892480

str = "ababbccab";
%str = "the dog in the fog"
str = strrep(str,' ','#')
A = [char(str)];
n = length(str)

for i = 1:(n-1)
    str = strcat(str(2:n), str(1))
    A(i+1, :) = char(str)
end

[B,index] = sortrows(A)
y = B(:,9)
L = index