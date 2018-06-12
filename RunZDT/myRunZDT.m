clc;clear;

d = [30]
[m n] = size(d);
funcList = [1,2,3,4,6];
alltime = 1;
result = [];
FDC = '';

global H;
H = zeros(size(funcList,2), 9);

for func_num = funcList
    for time = 1:alltime
        for i = 1:n
            [FVr_x,S_y,I_nf,OUTPUT] = runTestZDT(func_num,d(i));
%             FDC = [FDC OUTPUT.FDC];
%             result(func_num, time) = S_y.FVr_oa; 
            con = 0;
        end
    end
end
% plotFDC(FDC);

function plotFDC(FDC)
    figure;
    func_size = size(FDC,2);
    x=1:func_size;
    bar(x, [FDC.r]);
    xlabel("²âÊÔº¯Êý");
    ylabel("FDCÏµÊý");
    title('ZDT');
    hold on;
    y  = repelem(0.75,1,func_size+2);
    plot([0:1:func_size+1],y,'--');
    y  = repelem(0.15,1,func_size+2);
    plot([0:1:func_size+1],y,'--');
    hold off;
end
