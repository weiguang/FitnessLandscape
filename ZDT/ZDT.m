function fit = ZDT(var,func_num)
    fit = feval(['ZDT',num2str(func_num)], var);
end