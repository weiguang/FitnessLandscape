clc;clear;

% d = [30]
% [m n] = size(d);
funcList = [1,2,4,7];
alltime = 1;
result = [];
FDC = '';
M = 4;

global H;
H = zeros(size(funcList,2), 9);

for func_num = funcList
    for time = 1:alltime
            [d, k] = dtlzSetting(['dtlz', num2str(func_num)],M);
            [FVr_x,S_y,I_nf,OUTPUT] = runTestDTLZ(func_num,d);
%             FDC = [FDC OUTPUT.FDC];
%             result(func_num, time) = S_y.FVr_oa; 
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
    title('DTLZ');
    hold on;
    y  = repelem(0.75,1,func_size+2);
    plot([0:1:func_size+1],y,'--');
    y  = repelem(0.15,1,func_size+2);
    plot([0:1:func_size+1],y,'--');
    hold off;
end


function [d, k] = dtlzSetting(fname,M)
switch fname
   case 'dtlz1' %k = 5 and x(last) = 0.5
     k = 5;
    cluster  = 3;
      
   case 'dtlz2' %k = 10 and x(last) = 0.5
      k = 10;
      cluster  = 3;
      
   case 'dtlz3' %k = 10 and x(last) = 0.5
      k = 10;
      cluster  = 3;
  
   case 'dtlz4' %k = 10 and x(last) = 0.5
      k = 10;
          cluster  = 3;
     
   case 'dtlz5' %k = 10 and x(last) = 0.5
      k = 10;
      cluster  = 3;
     
   case 'dtlz6' %k = 10 and x(last) = 0
      k = 10;
      cluster  = 3;
     
   case 'dtlz7' %k = 20 and x(last) = 0
      k = 20;
      cluster  = 3;
    
end
d = (M - 1) + k; 
end
