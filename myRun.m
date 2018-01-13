clc;
clear;
addpath(genpath(pwd));
d=[5,15,30];
%  d=[2,5,15,30];
% d=[2];
 [m n] = size(d);
 func = 'Schwefel222'
for i = 1:n  
    con  = 1;
    while(con >0)
         clc;
         runTest(func,d(i));
         con = input('请输入重跑,回车继续下一维:');
    end
end