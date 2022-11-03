function x = getOriginalX(y, L)
    % get the matrix of B
    B = inverseBWT(y);
    % get the orginal x from B
    x = B(L, :);
end