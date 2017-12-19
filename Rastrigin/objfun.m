%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         S_MSE= objfun(FVr_temp, S_struct)
% Author:           Rainer Storn
% Description:      Implements the cost function to be minimized.
%                   Spherical's function is based on a quadratic function
%                   with the addition of cosine modulation to produce
%                   many local minima. Thus the test function is highly
%                   multimodal. However, the locations of the minima are
%                   regularly distributed.
% Parameters:       FVr_temp     (I)    Paramter vector
%                   S_Struct     (I)    Contains a variety of parameters.
%                                       For details see Rundeopt.m
% Return value:     S_MSE.I_nc   (O)    Number of constraints
%                   S_MSE.FVr_ca (O)    Constraint values. 0 means the constraints
%                                       are met. Values > 0 measure the distance
%                                       to a particular constraint.
%                   S_MSE.I_no   (O)    Number of objectives.
%                   S_MSE.FVr_oa (O)    Objective function values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S_MSE= objfun(FVr_temp, S_struct)

%---Spherical's function----------------------------------------
%F_cost = 10*S_struct.I_D;
% F_cost1 = 0;
F_cost = 0;
% for i=1:S_struct.I_D
%    F_cost  = F_cost +100*(FVr_temp(i+1) - FVr_temp(i)^2)^2 + (FVr_temp(i)-1)^2
%    %F_cost + ((FVr_temp(i))^2-10*cos(2*pi*FVr_temp(i)));
% end
 F_cost = sum(FVr_temp.^2 - 10.*cos(2*pi.*FVr_temp)+10);


%----strategy to put everything into a cost function------------
S_MSE.I_nc      = 0;%no constraints
S_MSE.FVr_ca    = 0;%no constraint array
S_MSE.I_no      = 1;%number of objectives (costs)
S_MSE.FVr_oa(1) = F_cost;