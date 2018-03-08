function S_MSE = getFitnessValue(fname,x, S_struct)
if(strcmp(S_struct.TestFunctionType, 'CEC2017'))
    fhd=str2func(fname);
    F_cost = feval(fhd,x',S_struct.func_num);
    %----strategy to put everything into a cost function------------
    for i = 1:size(x,1)
        S_MSE(i).I_nc      = 0;%no constraints
        S_MSE(i).FVr_ca    = 0;%no constraint array
        S_MSE(i).I_no      = 1;%number of objectives (costs)
        S_MSE(i).FVr_oa(1) = F_cost(i);
    end
elseif(strcmp(S_struct.TestFunctionType, 'CEC2005'))
    fhd=str2func(fname);
   F_cost = feval(fhd,x,S_struct.func_num);
   %----strategy to put everything into a cost function------------
    for i = 1:size(x,1)
        S_MSE(i).I_nc      = 0;%no constraints
        S_MSE(i).FVr_ca    = 0;%no constraint array
        S_MSE(i).I_no      = 1;%number of objectives (costs)
        S_MSE(i).FVr_oa(1) = F_cost(i);
    end
else
    for i  = 1 : size(x,1)
        S_MSE(i) = feval(fname,x(i,:),S_struct);
        i = i + 1;
    end
end

end