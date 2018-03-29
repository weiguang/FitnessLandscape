function GetEntropy(H)
fname = 'ZDT';
figure;
hold on;
grid on;
leg = '';
x =  {'0', 'eps/128', 'eps/64', 'eps/32', 'eps/16', 'eps/8', 'eps/4', 'eps/2', 'eps'};

funcLabel = {'1','2'};

start = 1
funcList = start : (start  + 4);
for fun = 1 : size(funcList,2);
    func = funcList(fun);
    plot(H(func,:))
     funcLabel{fun} = [fname num2str(func)];
end
 funcLabel{fun} = [fname '6'];
legend(funcLabel);
set(gca,'xticklabel', x);
title([fname ' Entropy']);
xlabel('Epsilion');
ylabel('H(epsilon)');
hold off;
grid off;
end