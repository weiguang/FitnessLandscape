clc;
clear;
% addpath(genpath(pwd));
% d=[5,15,30];
%d=[2,5,15,30];
%func_num = 1;
% d=[10,30,50,100]; % cec2017
d=[10];
[m n] = size(d);
for func_num = 25:30
    for i = 1:n
        con  = 1;
        while(con >0)
            clc;
            if (CheckFile(func_num,d(i))==0)
                [FVr_x,S_y,I_nf] = runTestCEC(func_num,d(i));
            end
            con = input('请输入‘回车’继续下一维，‘其他键’重跑，‘ctrl+c’ 结束:');
        end
    end
end

%% 检查文件
% func_num:测试函数编号
% D: 维度
function re = CheckFile(func_num,D)
re = 0;
dataFile = sprintf('shift_data_%d.txt',func_num);
if exist(dataFile,'file')==0
    %     error(['no data file:' dataFile]);
    disp("error:");
    disp(['no data file:' dataFile]);
    re = 1;
end
dataFile = sprintf('input_data/shuffle_data_%d_D%d.txt',func_num,D);
if exist(dataFile,'file')==0
    %    error(['no data file:' dataFile]);
    disp("error:");
    disp(['no data file:' dataFile]);
    re = 2;
end

end