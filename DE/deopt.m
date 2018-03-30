%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         [FVr_bestmem,S_bestval,I_nfeval] = deopt(fname,S_struct)
%
% Author:           Rainer Storn, Ken Price, Arnold Neumaier, Jim Van Zandt
% Description:      Minimization of a user-supplied function with respect to x(1:I_D),
%                   using the differential evolution (DE) algorithm.
%                   DE works best if [FVr_minbound,FVr_maxbound] covers the region where the
%                   global minimum is expected. DE is also somewhat sensitive to
%                   the choice of the stepsize F_weight. A good initial guess is to
%                   choose F_weight from interval [0.5, 1], e.g. 0.8. F_CR, the crossover
%                   probability constant from interval [0, 1] helps to maintain
%                   the diversity of the population but should be close to 1 for most.
%                   practical cases. Only separable problems do better with CR close to 0.
%                   If the parameters are correlated, high values of F_CR work better.
%                   The reverse is true for no correlation.
%
%                   The number of population members I_NP is also not very critical. A
%                   good initial guess is 10*I_D. Depending on the difficulty of the
%                   problem I_NP can be lower than 10*I_D or must be higher than 10*I_D
%                   to achieve convergence.
%
%                   deopt is a vectorized variant of DE which, however, has a
%                   property which differs from the original version of DE:
%                   The random selection of vectors is performed by shuffling the
%                   population array. Hence a certain vector can't be chosen twice
%                   in the same term of the perturbation expression.
%                   Due to the vectorized expressions deopt executes fairly fast
%                   in MATLAB's interpreter environment.
%
% Parameters:       fname        (I)    String naming a function f(x,y) to minimize.
%                   S_struct     (I)    Problem data vector (must remain fixed during the
%                                       minimization). For details see Rundeopt.m.
%                   ---------members of S_struct----------------------------------------------------
%                   F_VTR        (I)    "Value To Reach". deopt will stop its minimization
%                                       if either the maximum number of iterations "I_itermax"
%                                       is reached or the best parameter vector "FVr_bestmem"
%                                       has found a value f(FVr_bestmem,y) <= F_VTR.
%                   FVr_minbound (I)    Vector of lower bounds FVr_minbound(1) ... FVr_minbound(I_D)
%                                       of initial population.
%                                       *** note: these are not bound constraints!! ***
%                   FVr_maxbound (I)    Vector of upper bounds FVr_maxbound(1) ... FVr_maxbound(I_D)
%                                       of initial population.
%                   I_D          (I)    Number of parameters of the objective function.
%                   I_NP         (I)    Number of population members.
%                   I_itermax    (I)    Maximum number of iterations (generations).
%                   F_weight     (I)    DE-stepsize F_weight from interval [0, 2].
%                   F_CR         (I)    Crossover probability constant from interval [0, 1].
%                   I_strategy   (I)    1 --> DE/rand/1
%                                       2 --> DE/local-to-best/1
%                                       3 --> DE/best/1 with jitter
%                                       4 --> DE/rand/1 with per-vector-dither
%                                       5 --> DE/rand/1 with per-generation-dither
%                                       6 --> DE/rand/1 either-or-algorithm
%                   I_refresh     (I)   Intermediate output will be produced after "I_refresh"
%                                       iterations. No intermediate output will be produced
%                                       if I_refresh is < 1.
%
% Return value:     FVr_bestmem      (O)    Best parameter vector.
%                   S_bestval.I_nc   (O)    Number of constraints
%                   S_bestval.FVr_ca (O)    Constraint values. 0 means the constraints
%                                           are met. Values > 0 measure the distance
%                                           to a particular constraint.
%                   S_bestval.I_no   (O)    Number of objectives.
%                   S_bestval.FVr_oa (O)    Objective function values.
%                   I_nfeval         (O)    Number of function evaluations.
%
% Note:
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU
% General Public License can be obtained from the
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [FVr_bestmem,S_bestval,I_nfeval,OUTPUT] = deopt(fname,S_struct)

accuracy = 0.0001;

global initial_flag;
initial_flag = 0;

%-----This is just for notational convenience and to keep the code uncluttered.--------
I_NP         = S_struct.I_NP;
F_weight     = S_struct.F_weight;
F_CR         = S_struct.F_CR;
I_D          = S_struct.I_D;
FVr_minbound = S_struct.FVr_minbound;
FVr_maxbound = S_struct.FVr_maxbound;
I_bnd_constr = S_struct.I_bnd_constr;
I_itermax    = S_struct.I_itermax;
F_VTR        = S_struct.F_VTR;
I_strategy   = S_struct.I_strategy;
I_refresh    = S_struct.I_refresh;
I_plotting   = S_struct.I_plotting;

%-----Check input variables---------------------------------------------
if (I_NP < 5)
    I_NP=5;
    fprintf(1,' I_NP increased to minimal value 5\n');
end
if ((F_CR < 0) | (F_CR > 1))
    F_CR=0.5;
    fprintf(1,'F_CR should be from interval [0,1]; set to default value 0.5\n');
end
if (I_itermax <= 0)
    I_itermax = 200;
    fprintf(1,'I_itermax should be > 0; set to default value 200\n');
end
I_refresh = floor(I_refresh);

%-----Initialize population and some arrays-------------------------------
FM_pop = zeros(I_NP,I_D); %initialize FM_pop to gain speed

%----FM_pop is a matrix of size I_NPx(I_D+1). It will be initialized------
%----with random values between the min and max values of the-------------
%----parameters-----------------------------------------------------------

for k=1:I_NP
    FM_pop(k,:) = FVr_minbound + rand(1,I_D).*(FVr_maxbound - FVr_minbound);
end

FM_popold     = zeros(size(FM_pop));  % toggle population
FVr_bestmem   = zeros(1,I_D);% best population member ever
FVr_bestmemit = zeros(1,I_D);% best population member in iteration
I_nfeval      = 0;                    % number of function evaluations

%---------My Function By Jam 2016.6.3-------------------
tic
tic
flag =0;
% init
S_bestmem = zeros(I_itermax,I_D);        %save the best member for every  generation
% S_bestva = zeros(I_itermax,1);        %save the best value for every  generation
FDC.r = zeros(I_itermax,1);              %initialization
FDC.Cfd = zeros(I_itermax,1);
DS.nk = zeros(I_itermax,I_D);
%FC.fm = zeros(I_itermax-1,1);
%-------------------------------------------------------


%------Evaluate the best member after initialization----------------------

I_best_index   = 1;                   % start with first population member

S_val(1)       = getFitnessValue(fname,FM_pop(I_best_index,:),S_struct); %feval(fname,FM_pop(I_best_index,:),var);



S_bestval = S_val(1);                 % best objective function value so far
I_nfeval  = I_nfeval + 1;
for k=2:I_NP                          % check the remaining members
    S_val(k)  = getFitnessValue(fname,FM_pop(k,:),S_struct); % feval(fname,FM_pop(k,:),var);
    I_nfeval  = I_nfeval + 1;
    if (left_win(S_val(k),S_bestval) == 1)
        I_best_index   = k;              % save its location
        S_bestval      = S_val(k);
    end
end
FVr_bestmemit = FM_pop(I_best_index,:); % best member of current iteration
S_bestvalit   = S_bestval;              % best value of current iteration

FVr_bestmem = FVr_bestmemit;            % best member ever

%------jam add 2016.7---------------
S_bestmem(1,:) = FVr_bestmemit;
S_bestva(1) = S_bestval;      %best value
%SDEV.ab = sum(FM_pop)/I_NP;
%SDEV.a(1,:) = sum((bsxfun(@minus,FM_pop , SDEV.ab)).^2)/I_NP
SDEV.a(1) = std(FM_pop(:));


%------jam add 2018.1--------------- falg:STA
%生成一列在[1,n]范围内的m个不重复的整数,m随机
STA.n = randi([I_NP * 0.1, I_NP]);
% STA.n = 100;
tp=randperm(I_NP,STA.n);
%选择对应的种群个体
ts= FM_pop(tp,:);
STA.a(1) = std(ts(:))/sqrt(STA.n);

%end


%----------- Jam 20170516 flag:update F and CR
%     F_CR = repmat(F_CR, I_NP, I_D);
%     F_epsilon = 0.1;
%     F_weight_e = F_weight;
%     F_weight = repmat(F_weight, I_NP, I_D);


%-----------------------------------
%------DE-Minimization---------------------------------------------
%------FM_popold is the population which has to compete. It is--------
%------static through one iteration. FM_pop is the newly--------------
%------emerging population.----------------------------------------

FM_pm1   = zeros(I_NP,I_D);   % initialize population matrix 1
FM_pm2   = zeros(I_NP,I_D);   % initialize population matrix 2
FM_pm3   = zeros(I_NP,I_D);   % initialize population matrix 3
FM_pm4   = zeros(I_NP,I_D);   % initialize population matrix 4
FM_pm5   = zeros(I_NP,I_D);   % initialize population matrix 5
FM_bm    = zeros(I_NP,I_D);   % initialize FVr_bestmember  matrix
FM_ui    = zeros(I_NP,I_D);   % intermediate population of perturbed vectors
FM_mui   = zeros(I_NP,I_D);   % mask for intermediate population
FM_mpo   = zeros(I_NP,I_D);   % mask for old population
FVr_rot  = (0:1:I_NP-1);               % rotating index array (size I_NP)
FVr_rotd = (0:1:I_D-1);       % rotating index array (size I_D)
FVr_rt   = zeros(I_NP);                % another rotating index array
FVr_rtd  = zeros(I_D);                 % rotating index array for exponential crossover
FVr_a1   = zeros(I_NP);                % index array
FVr_a2   = zeros(I_NP);                % index array
FVr_a3   = zeros(I_NP);                % index array
FVr_a4   = zeros(I_NP);                % index array
FVr_a5   = zeros(I_NP);                % index array
FVr_ind  = zeros(4);

FM_meanv = ones(I_NP,I_D);

I_iter = 1;

%% jam add 20180202  flag:dictance plot
% figure;
% if(strcmp(S_struct.TestFunctionType, 'ZDT') || strcmp(S_struct.TestFunctionType, 'dtlz'))
%     plot(I_iter, S_bestva(1).FVr_oa,'.');
%     xlabel("迭代数");
% else
%     dis_temp = pdist2(S_bestmem(1,:) ,S_struct.bestmemit);
%     plot(dis_temp,S_bestva(1).FVr_oa,'.');
%     xlabel("个体到全局最优个体的欧式距离");
% end
% ylabel("适应值");
% title(S_struct.title);
% hold on;



% while ((I_iter < I_itermax) && (S_bestval.FVr_oa(1) > F_VTR) && (S_struct.I_Fes > I_nfeval))
while ((S_bestval.FVr_oa(1) > F_VTR) && (S_struct.I_Fes > I_nfeval))    
    
    
    
    FM_popold = FM_pop;                  % save the old population
    S_struct.FM_pop = FM_pop;
    S_struct.FVr_bestmem = FVr_bestmem;
    
    FVr_ind = randperm(4);               % index pointer array
    
    FVr_a1  = randperm(I_NP);                   % shuffle locations of vectors
    FVr_rt  = rem(FVr_rot+FVr_ind(1),I_NP);     % rotate indices by ind(1) positions
    FVr_a2  = FVr_a1(FVr_rt+1);                 % rotate vector locations
    FVr_rt  = rem(FVr_rot+FVr_ind(2),I_NP);
    FVr_a3  = FVr_a2(FVr_rt+1);
    FVr_rt  = rem(FVr_rot+FVr_ind(3),I_NP);
    FVr_a4  = FVr_a3(FVr_rt+1);
    FVr_rt  = rem(FVr_rot+FVr_ind(4),I_NP);
    FVr_a5  = FVr_a4(FVr_rt+1);
    
    FM_pm1 = FM_popold(FVr_a1,:);             % shuffled population 1
    FM_pm2 = FM_popold(FVr_a2,:);             % shuffled population 2
    FM_pm3 = FM_popold(FVr_a3,:);             % shuffled population 3
    FM_pm4 = FM_popold(FVr_a4,:);             % shuffled population 4
    FM_pm5 = FM_popold(FVr_a5,:);             % shuffled population 5
    
    for k=1:I_NP                              % population filled with the best member
        FM_bm(k,:) = FVr_bestmemit;             % of the last iteration
    end
    
    FM_mui = rand(I_NP,I_D) < F_CR;  % all random numbers < F_CR are 1, 0 otherwise
    
    %----Insert this if you want exponential crossover.----------------
    %FM_mui = sort(FM_mui');	  % transpose, collect 1's in each column
    %for k  = 1:I_NP
    %  n = floor(rand*I_D);
    %  if (n > 0)
    %     FVr_rtd     = rem(FVr_rotd+n,I_D);
    %     FM_mui(:,k) = FM_mui(FVr_rtd+1,k); %rotate column k by n
    %  end
    %end
    %FM_mui = FM_mui';			  % transpose back
    %----End: exponential crossover------------------------------------
    
    FM_mpo = FM_mui < 0.5;    % inverse mask to FM_mui
    
    if (I_strategy == 1)                             % DE/rand/1
        % Jam mody F_weight * to .*
        FM_ui = FM_pm3 + F_weight .*(FM_pm1 - FM_pm2);   % differential variation
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;     % crossover
        FM_origin = FM_pm3;
    elseif (I_strategy == 2)                         % DE/local-to-best/1
        FM_ui = FM_popold + F_weight*(FM_bm-FM_popold) + F_weight*(FM_pm1 - FM_pm2);
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;
        FM_origin = FM_popold;
    elseif (I_strategy == 3)                         % DE/best/1 with jitter
        FM_ui = FM_bm + (FM_pm1 - FM_pm2).*((1-0.9999)*rand(I_NP,I_D)+F_weight);
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;
        FM_origin = FM_bm;
    elseif (I_strategy == 4)                         % DE/rand/1 with per-vector-dither
        f1 = ((1-F_weight)*rand(I_NP,1)+F_weight);
        for k=1:I_D
            FM_pm5(:,k)=f1;
        end
        FM_ui = FM_pm3 + (FM_pm1 - FM_pm2).*FM_pm5;    % differential variation
        FM_origin = FM_pm3;
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;     % crossover
    elseif (I_strategy == 5)                          % DE/rand/1 with per-vector-dither
        f1 = ((1-F_weight)*rand+F_weight);
        FM_ui = FM_pm3 + (FM_pm1 - FM_pm2)*f1;         % differential variation
        FM_origin = FM_pm3;
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;     % crossover
    else                                              % either-or-algorithm
        if (rand < 0.5);                               % Pmu = 0.5
            FM_ui = FM_pm3 + F_weight*(FM_pm1 - FM_pm2);% differential variation
        else                                           % use F-K-Rule: K = 0.5(F+1)
            FM_ui = FM_pm3 + 0.5*(F_weight+1.0)*(FM_pm1 + FM_pm2 - 2*FM_pm3);
        end
        FM_origin = FM_pm3;
        FM_ui = FM_popold.*FM_mpo + FM_ui.*FM_mui;     % crossover
    end
    
    %-----Optional parent+child selection-----------------------------------------
    
    
    %-----Select which vectors are allowed to enter the new population------------
    for k=1:I_NP
        
        %=====Only use this if boundary constraints are needed==================
        if (I_bnd_constr == 1)
            for j=1:I_D %----boundary constraints via bounce back-------
                if (FM_ui(k,j) > FVr_maxbound(j))
                    FM_ui(k,j) = FVr_maxbound(j) + rand*(FM_origin(k,j) - FVr_maxbound(j));
                end
                if (FM_ui(k,j) < FVr_minbound(j))
                    FM_ui(k,j) = FVr_minbound(j) + rand*(FM_origin(k,j) - FVr_minbound(j));
                end
            end
        end
        %=====End boundary constraints==========================================
        
        S_tempval = getFitnessValue(fname, FM_ui(k,:),S_struct); % feval(fname,FM_ui(k,:),var);   % check cost of competitor
        I_nfeval  = I_nfeval + 1;
        if (left_win(S_tempval,S_val(k)) == 1)
            FM_pop(k,:) = FM_ui(k,:);                    % replace old vector with new one (for new iteration)
            S_val(k)   = S_tempval;                      % save value in "cost array"
            
            %----we update S_bestval only in case of success to save time-----------
            if (left_win(S_tempval,S_bestval) == 1)
                S_bestval = S_tempval;                    % new best value
                FVr_bestmem = FM_ui(k,:);                 % new best parameter vector ever
                
            end
        end
    end % for k = 1:NP
    
    
  I_iter =  I_iter + 1;   
    
    %%Jam add 20180202  flag:dictance plot
% if(strcmp(S_struct.TestFunctionType, 'ZDT') || strcmp(S_struct.TestFunctionType, 'dtlz'))
%     plot(I_iter, [S_val.FVr_oa], '.');
% else
%     dis_temp = pdist2(FM_ui(:,:),S_struct.bestmemit);
%     plot(dis_temp,[S_val.FVr_oa]','.');
% end

%     
    
    
    FVr_bestmemit = FVr_bestmem;       % freeze the best member of this iteration for the coming
    % iteration. This is needed for some of the strategies.
    
    
    
    
    %----Output section----------------------------------------------------------
    
    if (I_refresh > 0)
        if ((rem(I_iter,I_refresh) == 0) || I_iter == 1)
            fprintf(1,'Iteration: %d,  Best: %f,  F_weight: %f,  F_CR: %f,  I_NP: %d\n',I_iter,S_bestval.FVr_oa(1),F_weight(1),F_CR(1),I_NP);
            %var(FM_pop)
            format long e;
            for n=1:I_D
                fprintf(1,'best(%d) = %g ',n,FVr_bestmem(n));
                fprintf(1,'\n');
            end
            if (I_plotting >= 1)
                PlotIt(FVr_bestmem,I_iter,S_struct);
            end
        end
    end
    
    %if (rem(I_iter,3) == 1)
    %   pause;
    %end
    
    

    
    
    
    %----My Function By Jam 2016.5.30----------------------------------------------------
    S_bestmem(I_iter,:) = FVr_bestmemit; % best parameter vector
    S_bestva(I_iter) = S_bestval;      %best value
    
    %--------SDEV
    SDEV.a(I_iter) = std(FM_pop(:));
    
    %----My Function By Jam 2018.1.3---------------------------
    %------jam add 2018.1--------------- flag:STA
    %生成一列在[I_NP * 0.1,n]范围内的m个不重复的整数,m随机
%     STA.n = randi([I_NP * 0.1, I_NP]);
%     tp=randperm(I_NP,STA.n);
%     %选择对应的种群个体
%     ts= FM_pop(tp,:);
%     %统计采样
%     STA.a(I_iter) = std(ts(:))/sqrt(STA.n);
    
    %end
    
    if ( abs (S_struct.bestval - S_bestval.FVr_oa) < accuracy & flag ==0)
        %    if (I_iter == 20)
        diter =    I_iter;
        dur = toc;
        flag =1;
    end
    
    %% jam add 20180202
    %生成一列在[1,n]范围内的m个不重复的整数
%     rdn = 100;
%     rdm=randperm(rdn);
    
    %%%----jam  20170516   flag:update F and CR
%        favg_iter = sum([S_val(:).FVr_oa])/I_NP;
%        %change CR
%         F_CR1 = F_CR(:,1);
%         F_CR_mui =  favg_iter > [S_val(:).FVr_oa]';
%         F_CR_mpo = F_CR_mui < 0.5;    % inverse mask
%         F_CR1 = F_CR1 .* F_CR_mui  +   F_CR_mpo .* normrnd(0.5, 0.5, I_NP, 1);
%         F_CR = repmat(F_CR1, 1, I_D);
      %change F
%         var_1 = (1 - favg_iter + [S_val(:).FVr_oa])';
%         var_2 = 1 - favg_iter + S_bestval.FVr_oa;
%         var_r1 = rand(I_NP, 1);
%         var_r2 = rand(I_NP, 1);
%         F_weight_new =  F_weight_e + var_r1 .* ( var_1 / var_2);
%         F_weight_mui = or((favg_iter > [ S_val(:).FVr_oa]' ), (var_r2 < F_epsilon));
%         F_weight_mpo = F_weight_mui < 0.5;
%         F_weight = F_weight_new .* F_weight_mui + F_weight(:,1) .* F_weight_mpo;
%         F_weight = repmat(F_weight, 1, I_D);
    
    
    
end %---end while ((I_iter < I_itermax) ...


%  S_bestmem(I_iter,:) = FVr_bestmemit; % best parameter vector
%  S_bestva(I_iter) = S_bestval;      %best value
iter = I_iter;

% if can't find threshold, all time;
if(flag ==0)
    diter =    I_iter;
    dur = toc ;
end

S_bestva_FVr_oa = [S_bestva(1:iter).FVr_oa]'; % 每一代最优解，提取出来方便计算

%----A. Fitness Distance Correlation(FDC)
%---- new Version jam 20180202
FDC =  CalFDC(S_bestmem,S_bestva_FVr_oa,iter,S_struct)
a = 1;
%-----B

%     Rd.a=0.01; %选的空间段
%     Rd.tL = 1;  %步长1
%     Rd.T = fix(iter*Rd.a); %选取的长度
%     Rd.t = 1 + fix(rand(1).*(iter - Rd.T*Rd.tL));  %下边界
%     Rd.tT = Rd.t + Rd.T;%上边界
%     Rd.fb = sum([S_bestva(Rd.t:Rd.tT).FVr_oa])/ Rd.T;
%     temp1=0;
%     temp2=0
%     for rdi = Rd.t :Rd.tL:Rd.tT-Rd.tL
%         temp1= temp1+(S_bestva(rdi).FVr_oa - Rd.fb)*(S_bestva(rdi+Rd.tL).FVr_oa - Rd.fb);
%         temp2= temp2+ (S_bestva(rdi).FVr_oa - Rd.fb)^2;
%     end
%     Rd.r01 = temp1/temp2;
% %     fprintf(1,' Rd.r01 = %.3f \n', Rd.r);
%
%     Rd.a=0.1; %选的空间段
%     Rd.tL = 1;  %步长1
%     Rd.T = fix(iter*Rd.a); %选取的长度
%     Rd.t = 1 + fix(rand(1).*(iter - Rd.T*Rd.tL));  %下边界
%     Rd.tT = Rd.t + Rd.T;%上边界
%     Rd.fb = sum([S_bestva(Rd.t:Rd.tT).FVr_oa])/ Rd.T;
%     temp1=0;
%     temp2=0
%     for rdi = Rd.t :Rd.tL:Rd.tT-Rd.tL
%         temp1= temp1+(S_bestva(rdi).FVr_oa - Rd.fb)*(S_bestva(rdi+Rd.tL).FVr_oa - Rd.fb);
%         temp2= temp2+ (S_bestva(rdi).FVr_oa - Rd.fb)^2;
%     end
%     Rd.r1 = temp1/temp2;
% %     fprintf(1,' Rd.r01 = %.3f, Rd.r1 = %.3f \n', Rd.r01,Rd.r1);

Rd.a=0.1; %选的空间段
Rd.tL = 1;  %步长1
Rd.T = round(iter*Rd.a); %选取的长度
Rd.select = randsrc(1, Rd.T, 1:iter);
Rd.fb=0;
%计算fb
for gmi = 1 : Rd.tL :Rd.T
    Rd.fb= Rd.fb + S_bestva(Rd.select(gmi)).FVr_oa;
end
Rd.fb = Rd.fb/(Rd.T/Rd.tL);
%计算r
temp1 = 0;
temp2 = 0;
for gmi = 1 : Rd.tL :Rd.T - Rd.tL
    temp1 = temp1 + (S_bestva(gmi).FVr_oa - Rd.fb)*(S_bestva(gmi+Rd.tL).FVr_oa - Rd.fb);
    temp2= temp2+ (S_bestva(gmi).FVr_oa - Rd.fb)^2;
end
Rd.r1 = temp1/temp2;



Rd.a=0.5; %选的空间段
Rd.tL = 1;  %步长1
Rd.T = round(iter*Rd.a); %选取的长度
Rd.select = randsrc(1, Rd.T, 1:iter);
Rd.fb=0;
%计算fb
for gmi = 1 : Rd.tL :Rd.T
    Rd.fb= Rd.fb + S_bestva(Rd.select(gmi)).FVr_oa;
end
Rd.fb = Rd.fb/(Rd.T/Rd.tL);
%计算r
temp1 = 0;
temp2 = 0;
for gmi = 1 : Rd.tL :Rd.T - Rd.tL
    temp1 = temp1 + (S_bestva(gmi).FVr_oa - Rd.fb)*(S_bestva(gmi+Rd.tL).FVr_oa - Rd.fb);
    temp2= temp2+ (S_bestva(gmi).FVr_oa - Rd.fb)^2;
end
Rd.r5 = temp1/temp2;


%-----C
%S_bestmem(I_iter,:) = FVr_bestmemit; % best parameter vector

for dsi = 1: iter-1
    DS.n(dsi) = abs(S_bestmem(dsi+1) - S_bestmem(dsi));
end
%      plot(1:iter-1, DS.n);

%-----D


FC.N = 25;
FC.K = 10;
FC.b = 0.5;
for fci = 1: iter
    FC.fm(fci) = (1 - (FC.K + 1) / FC.N) .* [S_bestva(fci).FVr_oa] + (FC.K + 1) / FC.N * FC.b;
end
%     plot([S_bestva(:).FVr_oa],FC.fm');
%   fprintf(1,'FC.fm = %.3f \n', FC.fm(iter));


%----E

%     GM.a=0.01+rand(1); %可选的空间段
%     GM.tL = 2;  %步长2
%     GM.T = fix(iter*GM.a /GM.tL); %选取的长度
%     GM.t = 1 + fix(rand(1).*(iter - GM.T*GM.tL));  %下边界
%     GM.tT = GM.t + GM.T;%上边界
%     fb=0;
%     i=0;
%     for gmi = GM.t : GM.tL : GM.tT-GM.tL
%         i=i+1;
%         GM.gt(i) = abs((S_bestva(gmi).FVr_oa - S_bestva(gmi+GM.tL).FVr_oa )/GM.tL);
%         fb= fb+GM.gt(i);
%     end
%     GM.avg= fb/ i;
%     Gm.dev = sqrt( sum((GM.avg-GM.gt).^2)/(i-1) )
% %     fprintf(1,' GM.avg = %.3f, Gm.dev = %.3f \n', GM.avg,Gm.dev);

GM.a= 0.01+rand(1); %选的空间段
GM.tL = 1;  %步长1
GM.T = round(iter*GM.a); %选取的长度
if (GM.T >iter)
    GM.T = iter;
end
GM.select = randsrc(1, GM.T, 1:iter);
GM.g(1) = 0;
for gmi = 1 : GM.T - 1;
    if (GM.select(gmi) == GM.select(gmi + 1) & GM.select(gmi) + 1 <iter)
        GM.select(gmi) = GM.select(gmi) + 1;
    end
    GM.g(gmi) = (S_bestva(GM.select(gmi + 1)).FVr_oa - S_bestva(GM.select(gmi)).FVr_oa)/...
        (GM.select(gmi + 1) - GM.select(gmi));
    if (isnan(GM.g(gmi)))
        GM.g(gmi) = 0;
    end
end
GM.avg = sum(abs(GM.g))/(GM.T - 1);
GM.dev = sqrt( sum(GM.avg-abs(GM.g).^2) / (GM.T - 1));
%  plot(1:GM.T-1,[S_bestva(GM.select(1:GM.T-1)).FVr_oa]);






allTime = toc;

Time.dur = dur;
Time.allTime = allTime;

Iter.diter = diter;
Iter.iter = iter;


OUTPUT.FDC = FDC;   %适应值距离相关性
OUTPUT.Rd = Rd;     %粗糙度
OUTPUT.GM = GM;     %梯度
OUTPUT.FC = FC;     %适应值云
OUTPUT.DS = DS;     %
OUTPUT.SDEV = SDEV; %标准差
OUTPUT.STA = STA;   %统计采样
OUTPUT.Time = Time;
OUTPUT.Iter = Iter;
OUTPUT.S_bestva = S_bestva; % each iter best fitness
OUTPUT.S_bestmem = S_bestmem; % each iter best individual
OUTPUT.fname = fname;

Output(OUTPUT, S_struct);

end

function FDC = CalFDC(S_bestmem,S_bestva_FVr_oa,iter,S_struct)
FDC.Cfb = sum(S_bestva_FVr_oa)/iter;
FDC.Cd = pdist2( S_bestmem(1:iter,:) ,S_struct.bestmemit);
FDC.Cdb = sum(FDC.Cd)/iter;
FDC.Cfd = sum((S_bestva_FVr_oa -  FDC.Cfb) .* (FDC.Cd - FDC.Cdb))/iter;
FDC.af = std2(S_bestva_FVr_oa);
FDC.ad = std2(FDC.Cd);
FDC.r =  FDC.Cfd/FDC.af/FDC.ad;
end
