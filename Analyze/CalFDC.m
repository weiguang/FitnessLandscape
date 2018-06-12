function FDC = CalFDC(S_bestmem,S_bestva_FVr_oa,iter,S_struct)
%CalFDC 计算FDC
%   S_bestmem 算法计算得到的最优个体
%   S_bestva_FVr_oa 算法计算得到的最优值
%   iter 运行的迭代次数
%   S_struct 结构体，运行参数的设置（主要是全局最优个体和对应的适应值）
FDC.Cfb = sum(S_bestva_FVr_oa)/iter;
FDC.Cd = pdist2( S_bestmem(1:iter,:) ,S_struct.bestmemit);
FDC.Cdb = sum(FDC.Cd)/iter;
FDC.Cfd = sum((S_bestva_FVr_oa -  FDC.Cfb) .* (FDC.Cd - FDC.Cdb))/iter;
FDC.af = std2(S_bestva_FVr_oa);
FDC.ad = std2(FDC.Cd);
FDC.r =  FDC.Cfd/FDC.af/FDC.ad;
end

