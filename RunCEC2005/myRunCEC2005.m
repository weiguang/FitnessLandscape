clc;
clear;
% addpath(genpath(pwd));

d=[10];
[m n] = size(d);
FDC = '';
title = '';
R = '';
func_size = 10
for func_num = 21:25
    for i = 1:n
        con  = 1;
        while(con >0)
            clc;
             if (CheckFile(func_num,d(i))==0)
                [FVr_x,S_y,I_nf,OUTPUT] = runTestCEC2005(func_num,d(i));
                 FDC = [FDC OUTPUT.FDC];
                 title = sprintf("func %d ", func_num);
             else
                 FDC1.r = 0
                  FDC = [FDC FDC1];
             end
                con = 0;
%             con = input('请输入‘回车’继续下一维，‘其他键’重跑，‘ctrl+c’ 结束:');
        end
    end
end

figure;
func_size = size(FDC,2);
x=[21:25];
bar(x, [FDC.r]);
xlabel("测试函数");
ylabel("FDC系数");
hold on;
y  = repelem(0.75,1,func_size+2);
plot([0:1:(func_size+1)],y,'--');
y  = repelem(0.15,1,func_size+2);
plot([0:1:(func_size+1)],y,'--');
hold off;

%% 检查文件
% func_num:测试函数编号
% D: 维度
function re = CheckFile(func_num,D)
re = 0;
if func_num == 12
    re = 1;
    disp("跳过12函数");
end
    
end
