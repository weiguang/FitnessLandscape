%
% 各种测试函数的二维和三维图
%

clear;clc;
tic

%Ackley
% D=1
% X=[-32:.5:32];
% Y= -20*exp(-0.2*sqrt(X.^2))-exp(cos(2*pi.*X))+20 +exp(1)
% % % 另一种计算方法
% % % Y=[]
% % %  for x = X
% % %      y=-20*exp(-0.2*sqrt(x*x))-exp(cos(2*pi*x))+20 +exp(1)
% % %      Y = [Y y] 
% % %  end
%  plot(X,Y) %画图
%  title('Ackley');
 

% %Ackley  3-D
% [X1,X2] = meshgrid(-32:.05:32, -32:.5:32);
% Y= -20*exp(-0.2 * sqrt(0.5 *( X1.^2 +  X2.^2)))-exp(0.5*(cos(2*pi.*X1)+cos(2*pi.*X2)))+20 +exp(1)
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Ackley 3-D')

% % subplot(2,1,2)
% % surfc(X1,X2,Y)




% %Beale
% %这个好像确定是二维的，去掉x2看看
%  X=[-4.5:.1:4.5];
%  Y=(1.5-X).^2 +(2.25-X).^2 + (2.65-X).^2 
%  plot(X,Y) %画图
 

% %Beale  3-D
% [X1,X2] = meshgrid(-4.5:.02:4.5, -4.5:.02:4.5);
% Y=  (1.5 - X1 + X1.*X2).^2 + (2.25 - X1+ X1.* (X2.^2)).^2 + (2.625 - X1 + X1.* (X2.^3)).^2;
% subplot(2,1,1);
% mesh(X1,X2,Y);
% title('Beale 3-D');
% 
% subplot(2,1,2);
% surfc(X1,X2,Y);



%Goldstein-Price
% 只有二维的


% %Goldstein-Price  3-D
% [X1,X2] = meshgrid(-2:.01:2, -2:.01:2);
% Y= (1+(X1+X2+1).^2 * (19-14.*X1 + 3.*(X1.^2)-14.*X2 + 6.*X1.*X2 + 3.*(X2.^2)))...
%     *(30+ (2.*X1-3.*X2).^2 ...
%     *(18-32.*X1 + 12.*(X1.^2) + 48.*X2 - 36.*X1.*X2 + 27.*(X2.^2)))
% %subplot(1,1,1)
% mesh(X1,X2,Y)

 
%Griewank
% D=1
%  X=[-600:0.01:600];
%  Y = 1/4000.*(X.^2)-cos(X)+1
%  plot(X,Y) %画图
%另一种方法
% Y=[]
%  for x = X
%      y=1/4000 * x^2 - cos(x)+1
%      Y = [Y y] 
%  end
%  title('Griewank');

%Griewank  3-D
% [X1,X2] = meshgrid(-600:1:600, -600:1:600);
% Y= 1/4000 * (X1.^2 + X2.^2) - (cos(X1) * cos(X2./sqrt(2))) +1
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Griewank 3-D')
% 
% subplot(2,1,2)
% surfc(X1,X2,Y)


 
%Quadric (Schwefel 1.2)
% D=1
%  X=[-100:.1:100];
%   Y=X.^2
%  plot(X,Y) %画图

% Y=[]
%  for x = X
%      y=x^2
%      Y = [Y y] 
%  end
%  title('Quadric');

%Quadric (Schwefel 1.2) 3-D
% [X1,X2] = meshgrid(-100:.1:100, -100:.1:100);
% Y=  X1.^2 + (X1 + X2).^2
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Quadric (Schwefel 1.2) 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)



%Quartic
% D=1
% X=[-1.28:.01:1.28];
% Y=X.^4
% plot(X,Y) %画图
% Y=[]
%  for x = X
%      y=x^4
%      Y = [Y y] 
%  end
% title('Quartic');

%Quartic 3-D
% [X1,X2] = meshgrid(-1.28:.01:1.28, -1.28:.01:1.28);
% Y= 1.* X1.^4 + 2.* (X2.^4)
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Quartic 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)



%Rastrigin
% D=1
% X=[-51.2:.1:51.2];
% Y= X.^2-10*cos(2*pi.*X)+10
%  plot(X,Y) %画图
% Y=[]
%     for x = X
%        y=x*x - 10*cos(2*pi*x) +10;
%        ySum = 0;
%        for d = 1:D
%             ySum = ySum+y;
%        end
%     Y = [Y ySum] 
%     end
% 
% title('Rastrigin');


%Rastrigin 3-D
% [X1,X2] = meshgrid(-5.12:.02:5.12, -5.12:.02:5.12);
% Y= (X1.^2 -10*cos(2*pi.*X1) + 10) + (X2.^2 -10*cos(2*pi.*X2) + 10)
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Rastrigin 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)



%Rosenbrock (generalized)
%至少二维

%Rosenbrock (generalized) 3-D
% [X1,X2] = meshgrid(-2.048:.001:2.048, -2.048:.001:2.048);
% Y= 100*(X2-X1.^2).^2+(X1-1).^2
% subplot(1,1,1)
% mesh(X1,X2,Y)

%Rosenbrock (generalized) 4-D
% [X1,X2,X3] = meshgrid(-2.048:.06:2.048, -2.048:.06:2.048, -2.048:.06:2.048);
% Y= 100*(X2-X1.^2).^2+(X1-1).^2 + 100*(X3-X2.^2).^2+(X2-1).^2;
% xslice = [0:.08:2]; 
% yslice = [0:.08:2]; 
% zslice = [-2:.08:0];
% slice(X1,X2,X3,Y,xslice,yslice,zslice)
% colormap hsv


%Salomon
% D=1
% X=[-100:.2:100]
% Y=-cos(2*pi.*X.^2)+0.1*sqrt(X.^2)+1
% plot(X,Y) %画图
% Y=[]
%  for x = X
%      y=-cos(2*pi*x*x)+0.1*sqrt(x*x)+1
%      Y = [Y y] 
%  end

% title('Salomon');


%Salomon 3-D
% [X1,X2] = meshgrid(-100:1:100, -100:1:100);
% Y= -cos(2*pi*sqrt(X1.^2 + X2.^2)) + 0.1*sqrt(X1.^2 + X2.^2)+1
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Salomon 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)


%Schwefel 2.22
% D=1
% X=[-10:.1:10];
% Y=abs(X).*2
% plot(X,Y) %画图
% Y=[]
%  for x = X
%      y=abs(x)+abs(x)
%      Y = [Y y] 
%  end
% title('Schwefel 2.22');

%Schwefel 2.22 3-D
% [X1,X2] = meshgrid(-10:.1:10, -10:.1:10);
% Y= abs(X1) + abs(X2) + abs(X1).*abs(X2)
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Schwefel 2.22 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)



%Schwefel 2.26
% D=1
% X=[-500:500];
% Y=[]
%  for x = X
%      y=-(x*sin(sqrt(abs(x))));
%      Y = [Y y]; 
%  end
%  plot(X,Y) %画图
% title('Schwefel 2.26');


%Schwefel 2.26 3-D
% [X1,X2] = meshgrid(-500:3:500, -500:3:500);
% Y= -( X1.*sin(sqrt(abs(X1))) + X2.*sin(sqrt(abs(X2))))
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Schwefel 2.26 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)


%Spherical
% D=1
% X=[-100:100];
% Y=[]
%  for x = X
%      y=x^2
%      Y = [Y y] 
%  end
%  plot(X,Y) %画图
% title('Spherical');

%Spherical 3-D
% [X1,X2] = meshgrid(-100:.5:100, -100:.5:100);
% Y=X1.^2 + X2.^2
% subplot(1,1,1)
% mesh(X1,X2,Y)
% title('Spherical 3-D')
% subplot(2,1,2)
% surfc(X1,X2,Y)


% %Alpine
%  X=[-10:.1:10];
%  Y=X.*sin(X)+0.1*abs(X)
%  plot(X,Y) %画图


% % %Alpine 3-D
% [X1,X2] = meshgrid(-10:.1:10, -10:.1:10);
% Y=  X1.*sin(X1)+0.1*abs(X1) + X2.*sin(X2)+0.1*abs(X2)
% mesh(X1,X2,Y)



% % %Bohachevsky 3-D
% [X1,X2] = meshgrid(-15:.1:15, -15:.1:15);
% Y= X1.^2+2*X2.^2-0.3*cos(3*pi.*X1)-0.4*cos(4*pi.*X2.^2)+0.7
% mesh(X1,X2,Y)

% % %Egg Holder 3-D
% [X1,X2] = meshgrid(-512:1:512, -512:1:512);
% Y= -(X2+47)*sin(sqrt(abs(X2+X1/2+47)))+sin(sqrt(abs(X1-(X2+47))))*sin(-X1);
% mesh(X1,X2,Y)

% % %Levy 3-D
% [X1,X2] = meshgrid(-10:.1:10, -10:.1:10);
% Y= (sin(3*pi*X1)).^2 +(X1-1).^2 *(1+(sin(3*pi*X2)).^2 ) +(X2-1).^2*(1+(sin(2*pi*X2)).^2)
% mesh(X1,X2,Y)


% %Michalewiez
%  X=[0:.01:pi];
%  Y= -( sin(X).*(sin(X.^2/pi)).^20)
%  plot(X,Y) %画图

% %Michalewiez 3-D
% [X1,X2] = meshgrid(0:.01:pi, 0:.01:pi);
% Y= -( sin(X1).*(sin(X1.^2/pi)).^20  + sin(X2).*(sin(2*X2.^2/pi)).^20)
% mesh(X1,X2,Y)


% %six-hump camel-back 3-D
% [X1,X2] = meshgrid(-5:.1:5, -5:.1:5);
% Y= 4*X1.^2-2.1*X2.^4+1/3*X1.^6+X1.*X2-4*X2.^2+4*X2.^4
% mesh(X1,X2,Y)


% % %step
%  X=[-20:.1:20];
%  Y= (X+0.5).^2
%  plot(X,Y) %画图

% %step 3-D
% [X1,X2] = meshgrid(-20:.1:20,-20:.1:20);
% Y= (X1+0.5).^2 + (X2+0.5).^2
% mesh(X1,X2,Y)

% % %Weierstrass
%  X=[-0.5:.01:0.5]
%  t1=0;
%  t2=0;
%  for k=0:20
%      t1=t1+ 0.5^k*cos(2*pi*3^k*(X+0.5))
%      t2=t2+0.5^k*cos(2*pi*3^k*0.5)
%  end
%  Y= t1-t2
%  plot(X,Y) %画图


% %step 3-D
% [X1,X2] = meshgrid(-0.5:.01:0.5,-0.5:.01:0.5);
%  t1=0;
%  t12=0
%  t2=0;
%  for k=0:20
%      t1=t1+ 0.5^k*cos(2*pi*3^k*(X1+0.5))
%      t12= t12 + 0.5^k*cos(2*pi*3^k*(X2+0.5))
%      t2=t2+0.5^k*cos(2*pi*3^k*0.5)
%  end
%  Y= t1+ t12 -2*t2
% mesh(X1,X2,Y)



% % %Zakharcv
% [X1,X2] = meshgrid(-5:.1:10,-5:.1:10);
% Y= X1.^2 + X2.^2 + (X1/2+ X2).^2 + (X1/2+ X2).^4
% mesh(X1,X2,Y)

toc


