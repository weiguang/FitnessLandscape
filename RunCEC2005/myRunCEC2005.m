clc;
clear;
% addpath(genpath(pwd));

d=[50];
[m n] = size(d);
FDC = '';
title = '';
R = '';


FDC1.Cfb = 0;
FDC1.Cd = 0;
FDC1.Cdb = 0;
FDC1.Cfd = 0;
FDC1.af = 0;
FDC1.ad = 0;
FDC1.r = 0;


func_size = 25;

totalTime = 25;

result = zeros(func_size, totalTime);

for func_num = 23:func_size
    problem = func_num;
    for i = 1:n
        con  = 1;
        outcome = [];
        while(con >0)
            for c = 1:totalTime
                clc;
                 if (CheckFile(func_num,d(i))==0)
                    [FVr_x,S_y,I_nf,OUTPUT] = runTestCEC2005(func_num,d(i));
%                      FDC = [FDC OUTPUT.FDC];
                     title = sprintf("func %d ", func_num);
                     outcome = [outcome S_y.FVr_oa];
                 else
%                       FDC = [FDC FDC1];
                      outcome = [outcome NaN];
                 end                
                 con = 0;
    %             con = input('请输入‘回车’继续下一维，‘其他键’重跑，‘ctrl+c’ 结束:');
            fdcsodeResult(problem,:)  = [OUTPUT.S_bestva.FVr_oa];
            end
            end
    end
     fdcsodeOut(problem,:) = outcome;
     fdcsodeRe(problem,1) = mean(outcome);
     fdcsodeRe(problem,2) = std(outcome);
     
end

% figure;
% func_size = size(FDC,2);
% x=[21:25];
% bar(x, [FDC.r]);
% xlabel("测试函数");
% ylabel("FDC系数");
% hold on;
% y  = repelem(0.75,1,func_size+2);
% plot([20:1:26],y,'--');
% y  = repelem(0.15,1,func_size+2);
% plot([20:1:26],y,'--');
% hold off;

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
