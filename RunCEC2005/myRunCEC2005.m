clc;
clear;
% addpath(genpath(pwd));

d=[2,10];
[m n] = size(d);
FDC = '';
title = '';
for func_num = 1:2
    for i = 1:n
        con  = 1;
        while(con >0)
            clc;
%             if (CheckFile(func_num,d(i))==0)
                [FVr_x,S_y,I_nf,OUTPUT] = runTestCEC2005(func_num,d(i));
                 FDC = [FDC OUTPUT.FDC];
                 title = sprintf("func %d ", func_num);
%             end
            con = input('请输入‘回车’继续下一维，‘其他键’重跑，‘ctrl+c’ 结束:');
        end
    end
end

%% 检查文件
% func_num:测试函数编号
% D: 维度
function re = CheckFile(func_num,D)
re = 0;

end
