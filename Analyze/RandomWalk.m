
function walk = RandomWalk(dim,domain,steps,step_size)
% Random walk 
% eg:
% dim = 2;
% domain = [-100,100];
% steps = 500;
% step_size = 2;
% walk = zeros(1,dim);
% RandomWalk(2,[-100,100],100,1)

domainSize = domain(2)-domain(1);

%  shift domain
% shift = 0;
% if(domain(1) <0 )
%    shift =  - domain(1);
% end
% newDomain = domain + shift;

%% modify step_size
bei = steps / domainSize;
newDomain = domain;
if( bei > 1)
    newDomain = round(domain .* bei);
end

walk(1,:) = randi(newDomain,1,dim);
newDomainSize = newDomain(2)-newDomain(1);

%% cec 2017
% fhd=str2func('cec17_func');
% % x=randi([-100,100],1,D);
% func_num = 10;
% fitness(1) = feval(fhd,walk(i,:)',func_num);

i = 1;
while i < steps
    temp = walk(i,:) + randi([0,step_size],1,dim);
    walk(i + 1,:)  = temp - (temp > newDomain(2)) * newDomainSize;
%     pause(.005);
   

%% plot fitness;    
%     fitness(i) = feval(fhd,walk(i,:)',func_num);
%     plot(fitness);

i = i + 1;
end

walk = walk / bei;
%% plot individual     
    if (dim == 1)
    plot(walk);
    elseif (dim == 2 )
        plot(walk(:,1),walk(:,2));
    end
    

end

%% RandomWalk Ò»Î¬,²½¿Õ¼ä[-1,1]
function RandomWalk1D_One(step) 
i = 1;
y = 0;
while i <= step
    a=sign(randn);
    y(i+1)=y(i)+a;
    pause(.05);
    plot(y)
    i=i+1;
end
end