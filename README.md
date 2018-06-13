# FitnessLandscape

使用几个适应度景观的指标分析DE


# benchmark function

 ## classical function:
 
* Rosenbrock
* Griewank
* Ackley
* Rastrigin
* Quadric(Schwefel_102)
....

## CEC2005
NEW: Add CEC2017 beanchmark


## CEC2017
NEW: Add CEC2017 beanchmark

## How to run
1. Old function 
* add directory "OldFunctions" to search path, you can run  `AddWorkPath.m` . You should uncomment `addpath(genpath([pwd '\OldFunctions']))`;
* run `RunOldFunctions\myRunOldFunctions.m`

2. CEC 2017
* run `AddWorkPath.m` to add directory to search path.
* run `RunCEC2017\myRunCEC2017.m`

3. CEC 2005
* run `AddWorkPath.m` to add directory to search path.
* run `RunCEC2005\myRunCEC2005.m`

note:you need to cheak CEC function can run.In dir 'CEC****',you can run `testCEC****.m` to test. "****" is year.
  
---
### NEW: This project can analayze MOP 
 
4.ZDT
* run `AddWorkPath.m` to add directory to search path.
* run `RunZDT\myRunZDT.m`

5.DTLZ 
* run `AddWorkPath.m` to add directory to search path.
* run `RunDTLZ\myRunDTLZ.m`


## Requirement
* MATLAB R2016a or later
* If you want to run CEC fucntion, you need to install C++ compiler(VS or mingw)


## Rederence
You can see dir ` Rederence`. 
