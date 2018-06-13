function PlotFDC(func_list, fname,FDC) 
% Ref.
% Müller C L, Sbalzarini I F. Global characterization of the CEC 2005 fitness landscapes using fitness-distance analysis[C]
% //European Conference on the Applications of Evolutionary Computation. Springer, Berlin, Heidelberg, 2011: 294-303.
%

%PlotFDC 画出FDC的对比分析
%   func_list 分析的测试函数
%   FDC 计算得到的FDC，主要需要的是相关系数r


func_size = size(func_list,2);
figure;
x=[1:func_size];
bar(x,[FDC.r]);
xlabel("测试函数");
ylabel("FDC系数");
title("FDC");
hold on;
y  = repelem(0.75,1,func_size+2);
plot([0:1:(func_size+1)],y,'--');
y  = repelem(0.15,1,func_size+2);
plot([0:1:(func_size+1)],y,'--');
hold off;
print(gcf,'-dpng', ['.\img\FDC\',fname, ' FDC.png']);
end

