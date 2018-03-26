function GetEntropy(H)
figure;
hold on;
grid on;
leg = '';
x =  {'0', 'eps/128', 'eps/64', 'eps/32', 'eps/16', 'eps/8', 'eps/4', 'eps/2', 'eps'};

funcLabel = {'1','2'};

start = 20
funcList = start : (start  + 5);
for fun = 1 : size(funcList,2);
    func = funcList(fun);
    plot(H(func,:))
     funcLabel{fun} = ['func' num2str(func)];
;end
legend(funcLabel);
set(gca,'xticklabel', x);
title('CEC2017 Function Entropy');
xlabel('Epsilion');
ylabel('H(epsilon)');
hold off;
grid off;
end