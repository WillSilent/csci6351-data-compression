function [ds,rs] = MaxLloyd(x, lv)

x = sort(double(x(:)));
% lv = 4;
ds = zeros(lv+1,1);
rs = zeros(lv,1);
% deta = range(x)/lv;
deta = (max(x)+0.001-min(x))/lv;

% the initialization of d's
ds(1) = min(x);
for i = 2:(lv+1)
    ds(i) = ds(i-1)+deta;
end

% the iterations
n = 30;
while n>0
    % compute the new r's based on old d's
    sum = 0;
    num = 0;
    ir = 1;
    for i = 1:length(x)
        if (x(i) < ds(ir+1))||(x(i) == ds(lv+1))
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
    for i = 2:lv
        ds(i) = (rs(i-1)+rs(i))/2;
    end
    
    n = n -1;
end
end