function CEC2005Parameter(func_num)

%clear;
%clc;

% I_D		number of parameters of the objective function
global S_struct;
I_D =  S_struct.I_D;

% % CheckFile(func_num,I_D);

%% load value
 load fbias_data;
 func_name = getFunctionData(func_num);
 func_data =  [func_name '_data'];
 load(func_data);
 
 %% bound
Xmin=[-100,-100,-100,-100,-100,-100,0,-32,-5,-5,-0.5,-pi,-3,-100,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,2];
Xmax=[100,100,100,100,100,100,600,32,5,5,0.5,pi,1,100,5,5,5,5,5,5,5,5,5,5,5];
 
S_struct.bestval = f_bias(func_num);
F_VTR = S_struct.bestval + 0.0000000000001;   % F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
%I_bestmemit = 0;
S_struct.bestmemit = o(1:I_D) %repmat(I_bestmemit,1,I_D);

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound]
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
FVr_minbound = repelem(Xmin(func_num),1, I_D);
FVr_maxbound = repelem(Xmax(func_num),1, I_D);
I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints

S_struct.title = sprintf('%s %d','CEC2005 Function',func_num);

S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.F_VTR        = F_VTR;

end

function func_name = getFunctionData(func_num)
    if func_num==1 func_name = ('sphere_func'); %[-100,100]
    elseif func_num==2 func_name = ('schwefel_102'); %[-100,100]
    elseif func_num==3 func_name = ('high_cond_elliptic_rot'); %[-100,100]
    elseif func_num==4 func_name = ('schwefel_102'); %[-100,100]
    elseif func_num==5 func_name = ('schwefel_206'); %[no bound],initial[-100,100];
    elseif func_num==6 func_name = ('rosenbrock_func'); %[-100,100]
    elseif func_num==7 func_name = ('griewank_func'); %[-600,600]
    elseif func_num==8 func_name = ('ackley_func'); %[-32,32]
    elseif func_num==9 func_name = ('rastrigin_func'); %[-5,5]
    elseif func_num==10 func_name = ('rastrigin_func'); %[-5,5]
    elseif func_num==11 func_name = ('weierstrass'); %[-0.5,0.5]
    elseif func_num==12 func_name = ('schwefel_213'); %[-pi,pi]
    elseif func_num==13 func_name = ('EF8F2_func'); %[-3,1] 
    elseif func_num==14 func_name = ('E_ScafferF6_func'); %[-100,100]
    elseif func_num==15 func_name = ('hybrid_func1'); %[-5,5]
    elseif func_num==16 func_name = ('hybrid_func1'); %[-5,5]
    elseif func_num==17 func_name = ('hybrid_func1'); %[-5,5]        
    elseif func_num==18 func_name = ('hybrid_func2'); %[-5,5]    
    elseif func_num==19 func_name = ('hybrid_func2'); %[-5,5]    
    elseif func_num==20 func_name = ('hybrid_func2'); %[-5,5]  
    elseif func_num==21 func_name = ('hybrid_func3'); %[-5,5]    
    elseif func_num==22 func_name = ('hybrid_func3'); %[-5,5]  
    elseif func_num==23 func_name = ('hybrid_func3'); %[-5,5]   
    elseif func_num==24 func_name = ('hybrid_func4'); %[-5,5]  
    elseif func_num==25 func_name = ('hybrid_func4'); %[-5,5]  
    end
end

