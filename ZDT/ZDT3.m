function fit = ZDT3(var)

n = size(var,2);

fit(:,1) = var(:,1);

g = 1 + 9 * sum(var(:,2:n),2) / (n - 1);

fit(:,2) = g .* (1-sqrt(var(:,1)./g)-var(:,1)./g.*sin(10*pi*var(:,1)));

end