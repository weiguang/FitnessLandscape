function [fitness] = testCPP()
func_num = 1;
addpath(genpath(pwd));
fhd=str2func('cec17_func');
x=ones(1,10);
fitness = feval(fhd,x',func_num);
end