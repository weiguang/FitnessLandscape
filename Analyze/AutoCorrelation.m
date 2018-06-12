function AutoCorrelation(S_MSE,S_struct)
fitness = [S_MSE.FVr_oa];
fsize = (size(fitness,2) - 1);
fb = mean(fitness);
p =zeros(1, fsize);
varf =  var(fitness);


 figure;
 hold on ;

tf = [ fitness(2:size(fitness,2)) 0 ];
Lag = tf - fitness;
Lag = Lag(1:fsize);

for i = 1: fsize
    p(i) = (((fitness(i) * fitness(i+1) /fb) - fitness(i)/fb * fitness(i+1)/fb)) / varf;
%     plot([i i],[0 p(i)]);
end
% plot(Lag,p);

hist(p);

xlabel('Lag');
ylabel('Autocorrelation');
title(S_struct.title);

hold off;
print(gcf,'-dpng', ['L:\workspaces\matlab\FitnessLandscape\img\Autocorrelation\',S_struct.title, ' Autocorrelation.png']);

end