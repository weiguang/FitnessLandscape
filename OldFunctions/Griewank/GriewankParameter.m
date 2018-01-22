%********************************************************************
% Script file for the initialization and run of the differential 
% evolution optimizer.
%********************************************************************
function GriewankParameter()
%clear;
%clc
% F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
		F_VTR = 0; 

% I_D		number of parameters of the objective function 
        global S_struct;
 		I_D =  S_struct.I_D; 
        I_plotting =  S_struct.I_plotting; 
%------jam add
   S_struct.title = 'Griewank';
   S_struct.bestval = 0;
   I_bestmemit = 0
   S_struct.bestmemit = repmat(I_bestmemit,1,I_D) 
%------jam add end -------

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound] 
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
      FVr_minbound = -600*ones(1,I_D); 
      FVr_maxbound = 600*ones(1,I_D); 
      I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints
            
%-----Problem dependent constant values for plotting----------------
%-----provided D = 2------------------------------------------------
if (I_D == 2)   
    
   FVc_xx = [-350:2:-250]';
   FVc_yy = [-100:2:0]';
   
  [FVr_x,FM_y]=meshgrid(FVc_xx',FVc_yy');
  FM_meshd= 1/4000 * (FVr_x.^2 + FM_y.^2) - (cos(FVr_x) * cos(FM_y./sqrt(2))) +1;
      
   S_struct.FVc_xx       = FVc_xx;
   S_struct.FVc_yy       = FVc_yy;
   S_struct.FM_meshd     = FM_meshd;
end
      


S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.F_VTR        = F_VTR;

