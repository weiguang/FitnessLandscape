function AddWorkPath()

addpath(pwd);
addpath(genpath([pwd '\DE']));
 addpath(genpath([pwd '\RunCEC']));
  addpath(genpath([pwd '\Analyze']));

% addpath(genpath([pwd '\OldFunctions']));

addpath(genpath([pwd '\CEC2005']));
addpath(genpath([pwd '\RunCEC2005']));

% addpath(genpath([pwd '\CEC2017']));
% addpath(genpath([pwd '\RunCEC2017']));
%  cd CEC2017
%  mex cec17_func.cpp
%  cd ..


end
