function AddWorkPath()

addpath(pwd);
addpath(genpath([pwd '\DE']));
addpath(genpath([pwd '\CEC2017']));
% addpath(genpath([pwd '\NewFunction']));
addpath(genpath([pwd '\OldFunctions']));
addpath(genpath([pwd '\RunCEC']));

 cd CEC2017
 mex cec17_func.cpp
 cd ..


end
