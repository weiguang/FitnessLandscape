clc;
clear;
addpath(genpath(pwd));
% d=[5,15,30];
%d=[2,5,15,30];
d=[2,10,30,50,100]; % cec2017
[m n] = size(d);
func_num = 1;
for i = 1:n
    con  = 1;
    while(con >0)
        clc;
        runTestCEC(func_num,d(i));
        con = input('请输入重跑,回车继续下一维:');
    end
end