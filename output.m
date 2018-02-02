function output(OUTPUT,S_struct)
FDC = OUTPUT.FDC;   %适应值距离相关性,单值v
Rd = OUTPUT.Rd;     %粗糙度，单值v
GM = OUTPUT.GM;     %梯度v
FC = OUTPUT.FC;     %适应值云
DS = OUTPUT.DS;     %Dynamic Severity
SDEV = OUTPUT.SDEV; %标准差
STA = OUTPUT.STA;   %统计采样v
Time = OUTPUT.Time;
Iter = OUTPUT.Iter;
S_bestva = OUTPUT.S_bestva; % each iter best fitness
S_bestmem = OUTPUT.S_bestmem; % each iter best individual

I_D = size(S_bestmem(1,:),2);
iter = Iter.iter;

%输出
Time
fprintf(1,"function name:%s, D = %d \n", S_struct.title , I_D);
fprintf(1,'FDC.r = %.5f, Cfd = %.5f\n',FDC.r, FDC.Cfd);
%fprintf(1,'Cfd = %.3f , Cfb = %.3f, FDC.r = = %.3f\n',FDC.Cfd,FDC.Cfb,FDC.r);
fprintf(1,'Rd.r1 = %.3f , Rd.r5 = %.3f \n', Rd.r1,Rd.r5); 
%fprintf(1,'FC.fm = %.3f \n', FC.fm(iter));
fprintf(1,'GM.avg = %.3f \n',  GM.avg);
% fprintf(1,'GM.avg = %.3f , GM.dev = %.3f \n',  GM.avg, GM.dev);
fprintf(1,'failure times = %d , success times = %d, SRate = success/all = %f\n',Iter.diter, Iter.iter - Iter.diter, (Iter.iter - Iter.diter)/Iter.iter);
fprintf(1,'failure time = %.6f, all time = %.6f, PC = success/all = %f\n', Time.dur,Time.allTime, (Time.allTime - Time.dur)/Time.allTime);


OUTPUT1(1) = FDC.Cfd;
OUTPUT1(2) = FDC.Cfb;
OUTPUT1(3) =  Rd.r1;
OUTPUT1(4) = Rd.r5;
OUTPUT1(5) = GM.avg;
OUTPUT1(6) = GM.dev;
% str = [num2str(iter - diter), '/', num2str(iter)];
OUTPUT1(7) = (Iter.iter - Iter.diter)/Iter.iter;
OUTPUT1(8) = ((Time.allTime - Time.dur)/Time.allTime);


if (S_struct.I_D == 2 && ~strcmp(S_struct.TestFunctionType, 'CEC2017'))
  %----Define the mesh of samples----------------------------------
   [FVr_x,FM_y]=meshgrid(S_struct.FVc_xx',S_struct.FVc_yy') ;
   FM_meshd = S_struct.FM_meshd;
   surfc(FVr_x,FM_y,FM_meshd);
%    mesh(FVr_x,FM_y,FM_meshd);
%   mesh(S_struct.FM_meshd);
  figure;
end
% plot(1:iter, STA.a,'g');
% xlabel('k');
% ylabel('statistic sampling'); 

% grid on;
% 
% figure;
% plot(1:GM.T-1,[S_bestva(GM.select(1:GM.T-1)).FVr_oa]);
% xlabel('t');
% ylabel('Fitness gradients'); 
% 
% % figure;
% % plot(1:iter-1, DS.n);
% % xlabel('Landscape time');
% % ylabel('Dynamic severity'); 
% 

%figure;
plot(1:iter, SDEV.a);
xlabel('迭代次数');
ylabel('标准差'); 


 figure;
plot(1:iter, [S_bestva(:).FVr_oa],'o');
xlabel('迭代次数');
ylabel('种群最优解');
hold on;
plot(S_struct.bestval,'*');
hold off;

figure;
hist(pdist2(S_bestmem ,S_struct.bestmemit),20);
xlabel('最优个体到全局最优个体的欧式距离');
ylabel('数量'); 


figure;
hist((STA.a),20);
xlabel('样本平均值的标准偏差');
ylabel('数量'); 



%% old function  output

% grid on;
% subplot(2,2,1);
% plot(1:iter-1, DS.n);
% xlabel('Landscape time');
% % figure;
% % hold on;
% ylabel('Dynamic severity'); 
% 
% subplot(2,2,2);
% plot(1:GM.T-1,[S_bestva(GM.select(1:GM.T-1)).FVr_oa]);
% xlabel('t');
% ylabel('Fitness gradients'); 
% 
% % subplot(2,2,3);
% % plot(1:iter, SDEV.a);
% % xlabel('k');
% % ylabel('standard deviation'); 
% 
% 
% subplot(2,2,3);
% plot(1:iter, STA.a);
% xlabel('k');
% ylabel('statistic sampling'); 
% 
% subplot(2,2,4);
% plot(1:iter, [S_bestva(:).FVr_oa]);
% xlabel('k');
% ylabel('Optimum'); 

% subplot(2,3,2)
% plot([S_bestva(1:iter).FVr_oa],FC.fm');
% xlabel('Fitness value');
% ylabel('Mean fitness cloud'); 

% %      subplot(2,1,1)
% %        plot([1:I_iter-1],FDC.r(1:I_iter-1));
% %        title('r与迭代次数')
% %       %  hold on;
% %       subplot(2,1,2)
% %        plot([1:I_iter-1],FDC.Cfd(1:I_iter-1)');
% %        title('Cfd与迭代次数')

end