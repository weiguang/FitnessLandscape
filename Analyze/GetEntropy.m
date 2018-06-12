function GetEntropy(H,fname,varargin)
% fname = S_struct.TestFunctionType;

figure;
hold on;
grid on;
leg = '';
x =  {'0', 'eps/128', 'eps/64', 'eps/32', 'eps/16', 'eps/8', 'eps/4', 'eps/2', 'eps'};

if(nargin > 2)
   func_list = varargin{1};
else
   func_list = [1:size(H,2)]
end 
funcLabel = num2cell(strrep(num2str(func_list),' ',''));

for fun = 1 : size(func_list,2);
    func = func_list(fun);
    plot(H(func,:))
     funcLabel{fun} = [fname num2str(func)];
end
%  funcLabel{fun} = [fname '6'];
legend(funcLabel);
set(gca,'xticklabel', x);
title([fname ' Entropy']);
xlabel('Epsilion');
ylabel('H(epsilon)');
hold off;
grid off;
end