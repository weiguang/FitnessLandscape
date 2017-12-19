function output(OUTPUT)
FDC = OUTPUT.FDC ;
Rd = OUTPUT.Rd;
GM = OUTPUT.GM;
FC = OUTPUT.FC;
DS = OUTPUT.DS;
SDEV = OUTPUT.SDEV;
Time = OUTPUT.Time;
Iter = OUTPUT.Iter;
S_bestva = OUTPUT.S_bestva; % each iter best fitness
S_bestmem = OUTPUT.S_bestmem; % each iter best individual

I_D = size(S_bestmem(1,:),2);
iter = Iter.iter;

%输出
fprintf(1,'D = %d \n',I_D);
fprintf(1,'Cfd = %.3f\n',FDC.Cfd);
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

grid on;
subplot(2,2,1);
plot(1:iter-1, DS.n);
xlabel('Landscape time');
% figure;
% hold on;
ylabel('Dynamic severity'); 

subplot(2,2,2);
plot(1:GM.T-1,[S_bestva(GM.select(1:GM.T-1)).FVr_oa]);
xlabel('t');
ylabel('Fitness gradients'); 

subplot(2,2,3);
plot(1:iter, SDEV.a);
xlabel('k');
ylabel('standard deviation'); 

subplot(2,2,4);
plot(1:iter, [S_bestva(:).FVr_oa]);
xlabel('k');
ylabel('Optimum'); 


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