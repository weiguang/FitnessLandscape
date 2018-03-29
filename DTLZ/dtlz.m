function f = dtlz(x,func_num)
%DTLZ 此处显示有关此函数的摘要
%   此处显示详细说明
M =2;
f = feval(['dtlz',num2str(func_num)],x)

end

