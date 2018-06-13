function [walk, S_MSE] = GetRandomWalkFitness(S_struct, fname,varargin)
% Ref.
% M¨¹ller C L, Sbalzarini I F. Global characterization of the CEC 2005 fitness landscapes using fitness-distance analysis[C]
% //European Conference on the Applications of Evolutionary Computation. Springer, Berlin, Heidelberg, 2011: 294-303.
%
    steps = 250;
    if(nargin > 2)
        steps = varargin{1};
    end 
    step_size = 2;
    if(nargin > 3)
        step_size = varargin{2};
    end  
    domain = [S_struct.FVr_minbound(1) S_struct.FVr_maxbound(1)]; 
    walk = RandomWalk(S_struct.I_D, domain, steps, step_size);
    S_MSE = getFitnessValue(fname,walk,S_struct);
    
    figure;
    plot([S_MSE.FVr_oa]);
    xlabel('Step');
    ylabel('Fitness'); 
    title(S_struct.title);
    path = '.\img\RandomWalk\';
    print(gcf,'-dpng', [path,S_struct.title, ' RandomWalk.png']);  
end

% maxH = max(H')'