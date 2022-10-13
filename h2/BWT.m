% https://blog.csdn.net/fjsd155/article/details/97892480

function [y,L] = BWT(str)
    n = strlength(str);
    
    str = strrep(str,' ','#');
    %str
    
    A = [char(str)];
    for i = 1:n-1
        % move the first character to the last one character
        str = strcat(extractBetween(str,2,n), extractBetween(str, 1, 1));
        A(i+1, :) = char(str);
    end
    
    [B,index] = sortrows(A);
    
    %display(index)
    %display(B(:, n))
    y = B(:,n);

    for i = 1:n
        if index(i) == 1
            L = i;
        end
    end
end

