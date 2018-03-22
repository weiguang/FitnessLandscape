function CEC2017ConstraintParameter(func_num)

%clear;
%clc;

% I_D		number of parameters of the objective function
global S_struct;
I_D =  S_struct.I_D;

% CheckFile(func_num,I_D);
if func_num < 12
    fileName = sprintf('Function%d',func_num);
else
    fileName = 'ShiftAndRotation';
end
load(fileName);


S_struct.bestval = 0 %func_num * 100;
F_VTR = S_struct.bestval + 0.000000001;   % F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
%I_bestmemit = 0;
S_struct.bestmemit = o(1:I_D) %repmat(I_bestmemit,1,I_D);

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound]
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***

if(any(func_num == [4,5,9]))
    minx =-10; maxx = 10;
elseif(any(func_num == [6]))
     minx =-20; maxx = 20;
 elseif(any(func_num == [7,19,28]))
    minx =-50; maxx = 50;
else
    minx =-100; maxx = 100;
end
FVr_minbound = minx * ones(1,I_D);
FVr_maxbound = maxx * ones(1,I_D);
I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints

S_struct.title = sprintf('%s %d','CEC2017 Function',func_num);

S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.F_VTR        = F_VTR;

end

