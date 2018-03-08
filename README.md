# FitnessLandscape

使用几个适应度景观的指标分析DE


# benchmark function

 ## classical function:
 
* Rosenbrock
* Griewank
* Ackley
* Rastrigin
* Quadric(Schwefel_102)

## CEC2005
NEW: Add CEC2017 beanchmark


## CEC2017
NEW: Add CEC2017 beanchmark

## How to run
1. Old function 
* add directory "OldFunctions" to search path, you can run  `AddWorkPath.m` . You should uncomment `addpath(genpath([pwd '\OldFunctions']))`;
* run `myRun.m`

2. CEC 2017
* run `AddWorkPath.m` to add directory to search path.
* run `RunCEC2017\myRunCEC2017.m`

2. CEC 2005
* run `AddWorkPath.m` to add directory to search path.
* run `RunCEC2005\myRunCEC2005.m`
