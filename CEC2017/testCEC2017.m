mex cec17_func.cpp -DWINDOWS
function [fitness] = testCEC2017()
func_num = 3;
D = 2;
addpath(genpath(pwd));
fhd=str2func('cec17_func');
x=randi([-100,100],1,D);
fitness = feval(fhd,x',func_num);
end