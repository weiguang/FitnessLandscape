function ZDTParameter(func_num)

%clear;
%clc;

% I_D		number of parameters of the objective function
global S_struct;
I_D =  S_struct.I_D;


S_struct.bestval =  0;
F_VTR = S_struct.bestval + 0.000000001;   % F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
I_bestmemit = 0;
S_struct.bestmemit = repmat(I_bestmemit,1,I_D);

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound]
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
FVr_minbound = 0 * ones(1,I_D);
FVr_maxbound = 1 * ones(1,I_D);
I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints

S_struct.title = sprintf('%s%d','ZDT',func_num);

switch func_num
    case 1
        %         F_VTR = 0;   % F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
        %         S_struct.bestval = 0;
        %         %I_bestmemit = 0;
        %         S_struct.bestmemit = o(1:I_D) %repmat(I_bestmemit,1,I_D);
        disp(['test function ' func_num]);
        
    case 4
        FVr_minbound = [ 0 ,-5 * ones(1,I_D -1)];
        FVr_maxbound = [ 1 ,5 * ones(1,I_D -1)];
    otherwise
        disp('other value');
end

S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.F_VTR        = F_VTR;

end

