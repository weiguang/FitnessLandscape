function [walk, S_MSE] = GetRandomWalkFitness(S_struct, fname,varargin)
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
    path = 'L:\workspaces\matlab\FitnessLandscape\img\';
    print(gcf,'-dpng', [path,S_struct.title, ' RandomWalk.png']);  
    
end

% maxH = max(H')'