% clear all;
% clc
% format long e;
% x =ones(1,1);
% global initial_flag;
% for i=1:1
%    i 
%    
%    initial_flag = 0;
%    [f,g,h]=CEC2017Constraint(x',i)
% end


re = []
for func = 1:25
global initial_flag;
initial_flag = 0;
if(func < 12)
load(['L:\workspaces\matlab\cec\2017\CEC17 Pure Matlab\Function',num2str(func),'.mat'])
else
    load(['L:\workspaces\matlab\cec\2017\CEC17 Pure Matlab\ShiftAndRotation'])

end
x = o(1:30);
% x = importdata('M_6_D10.txt');
[f,g,h] = CEC2017Constraint(x,func);
f
re(func, :) = f;
end