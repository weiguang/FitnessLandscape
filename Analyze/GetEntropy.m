function GetEntropy(H,fname,varargin)
%  Ref.
%  Malan K M, Engelbrecht A P. Quantifying ruggedness of continuous landscapes using entropy[C]
% //Evolutionary Computation, 2009. CEC'09. IEEE Congress on. IEEE, 2009: 1440-1447.
%

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

if( isa(func_list, 'double'))
    funcLabel = num2cell(strrep(num2str(func_list),' ',''));
else
    funcLabel = func_list;
end

for fun = 1 : size(func_list,2);
    func = func_list(fun);
    if( isa(func_list, 'double'))
        plot(H(func,:))
    else
        plot(H(fun,:))
    end
%      funcLabel{fun} = [fname,' ', num2str(func)];
end
%  funcLabel{fun} = [fname '6'];
legend(funcLabel);
set(gca,'xticklabel', x);
title([fname ' Entropy']);
xlabel('Epsilion');
ylabel('H(epsilon)');
hold off;
grid off;
path = '.\img\Entropy\';
print(gcf,'-dpng', [path, fname, ' Entropy.png']);  
end