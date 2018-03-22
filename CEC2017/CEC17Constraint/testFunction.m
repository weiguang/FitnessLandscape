% clear all;
% clc
format long e;
x =ones(1,1);
global initial_flag;
for i=1:1
   i 
   
   initial_flag = 0;
   [f,g,h]=CEC2017Constraint(x',i)
end
