%   mex cec17_func.cpp -DWINDOWS
function [fitness] = testCPP()
func_num = 10;
D = 2;
addpath(genpath(pwd));
fhd=str2func('cec17_func');
x=randi([-100,100],1,D);
fitness = feval(fhd,x',func_num);
end