clc;clear;

d = [10]
[m n] = size(d);
funcList = [1:2];
alltime = 1;
result = [];

global H;
H = zeros(size(funcList,2), 9);

for func_num = funcList
    for time = 1:alltime
        for i = 1:n
            [FVr_x,S_y,I_nf] = runTestZDT(func_num,d(i));
            result(func_num, time) = S_y.FVr_oa; 
            con = 0;
        end
    end
end