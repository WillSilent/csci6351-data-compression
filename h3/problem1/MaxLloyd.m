function [ds,rs] = MaxLloyd(x, n, dn)

    % sort x
    x = sort(x);
    
    ds = zeros(n+1, 1);
    ds(1) = 0;
    ds(n+1) = dn;
    
    rs = zeros(n,1);
    
    delta = dn/n;
    % the initialization of d's
    for i = 2:(n)
        ds(i) = ds(1)+(i-1)*delta;
    end
    
    % the iterations
    iter = 40;
    while iter > 0
        % compute the new r's based on old d's
        sum = 0;
        num = 0;
        ir = 1;
        for i = 1:length(x)
            if (x(i) < ds(ir+1))||(x(i) == ds(n+1))
                sum = sum+x(i);
                num = num+1;
            end
    
            if i == length(x) || x(i+1) > ds(ir+1)
                if sum == 0
                    rs(ir) = (ds(ir) +ds(ir+1))/2;
                else
                    rs(ir) = sum/num;
                end
                ir= ir + 1;
                sum = 0;
                num = 0;
            end
        end
        
        % compute the new d's based on old r's
        for i = 2:n
            ds(i) = (rs(i-1)+rs(i))/2;
        end
        
        
%         fprintf('After %d iteration:\n',41 - iter)
%         fprintf('ds Value\n');
%         disp(ds);
%         fprintf('rs Value\n');
%         disp(rs);
        
        iter = iter - 1;
    end
end