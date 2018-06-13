clc;
clear;
% addpath(genpath(pwd));

d=[10];
totalTime = 1;
func_list = [1:3];%func_list = [1:25];
func_size = size(func_list,2);

[m n] = size(d);
FDC = '';
title = '';
R = '';
fname = 'CEC2015'

FDC1.Cfb = 0;
FDC1.Cd = 0;
FDC1.Cdb = 0;
FDC1.Cfd = 0;
FDC1.af = 0;
FDC1.ad = 0;
FDC1.r = 0;

result = zeros(func_size, totalTime);

global H;
H = zeros(size(func_list,2), 9);

for func_num = 1:func_size
    problem = func_num;
    for i = 1:n
        con  = 1;
        outcome = [];
        while(con >0)
            for c = 1:totalTime
                clc;
                 if (CheckFile(func_num,d(i))==0)
                    [FVr_x,S_y,I_nf,OUTPUT] = runTestCEC2005(func_num,d(i));
                     FDC = [FDC OUTPUT.FDC];
                     title = sprintf("func %d ", func_num);
                     outcome = [outcome S_y.FVr_oa];
                 else
                      FDC = [FDC FDC1];
                      outcome = [outcome NaN];
                 end                
                 con = 0;
    %             con = input('请输入‘回车’继续下一维，‘其他键’重跑，‘ctrl+c’ 结束:');
            odeResult(problem,:) = [OUTPUT.S_bestva.FVr_oa];
            end
            end
    end
     odeOut(problem,:) = outcome;
     odeRe(problem,1) = mean(outcome);
     odeRe(problem,2) = std(outcome);
     
end

PlotFDC(func_list, fname, FDC);
GetEntropy(H, fname,func_list);

%% 检查文件
% func_num:测试函数编号
% D: 维度
function re = CheckFile(func_num,D)
re = 0;
if func_num == 12 || func_num == 21
    re = 1;
    disp("跳过12函数");
end
    
end
