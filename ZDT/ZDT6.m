function fit = ZDT6(var)

n = size(var,2);

fit(:, 1) = 1 - exp( -4 * var(:,1) ) .* ((sin(6 * pi * var(:,1))).^6);

g = 1 + 9 * ((sum(var(:,2:n),2) / (n - 1)).^25);

fit(:,2) = g .* (1-(fit(:,1)./g).^2);

end