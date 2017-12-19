%********************************************************************
% Script file for the initialization and run of the differential 
% evolution optimizer.
%********************************************************************
function Schwefel226Parameter()
%clear;
%clc;
% F_VTR		"Value To Reach" (stop when ofunc < F_VTR)
		F_VTR = -99999999999999; 

% I_D		number of parameters of the objective function 
        global S_struct;
 		I_D =  S_struct.I_D; 
        I_plotting =  S_struct.I_plotting; 
 %------jam add
   S_struct.title = 'Schwefel 2.26';
   S_struct.bestval = 0;
   I_bestmemit = 420.9687
   S_struct.bestmemit = repmat(I_bestmemit,1,I_D) 
   S_struct.bestval = (-1) * sum(S_struct.bestmemit.*sin(sqrt(abs(S_struct.bestmemit))))
%------jam add end -------

% FVr_minbound,FVr_maxbound   vector of lower and bounds of initial population
%    		the algorithm seems to work especially well if [FVr_minbound,FVr_maxbound] 
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
      FVr_minbound = -500*ones(1,I_D); 
      FVr_maxbound = 500*ones(1,I_D); 
      I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints
            
      
%-----Problem dependent constant values for plotting----------------
%-----provided D = 2------------------------------------------------
if (I_plotting >= 1)   
 
   FVc_xx = [-500:1:500]';
   FVc_yy = [-500:1:500]';

   [FVr_x,FM_y]=meshgrid(FVc_xx',FVc_yy') ;
   FM_meshd =  -( FVr_x.*sin(sqrt(abs(FVr_x))) + FM_y.*sin(sqrt(abs(FM_y))))
   %20+((FVr_x).^2-10*cos(2*pi*FVr_x)) +...
    %    ((FM_y).^2-10*cos(2*pi*FM_y));
      
   S_struct.FVc_xx       = FVc_xx;
   S_struct.FVc_yy       = FVc_yy;
   S_struct.FM_meshd     = FM_meshd;
end

S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.F_VTR        = F_VTR;
