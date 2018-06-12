function fit = ZDT4(var)

n = size(var,2);

fit(:,1) = var(:,1);

g = 1 + 10*(n - 1) + sum(var(:,2:n).^2 - 10*cos(4*pi*var(:,2:n)), 2);

fit(:, 2) = g .* (1-sqrt(var(:,1)./g));

end