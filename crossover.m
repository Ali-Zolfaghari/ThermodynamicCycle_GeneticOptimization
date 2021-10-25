function  crosspop = crossover(crosspop,pop,data,gamma,SYS)

ncross = data.ncross;

f = [pop.fit];
f = 1./f;
f = f./sum(f);
f = cumsum(f);

for n = 1:2:ncross
    
    i1 = find(rand <= f,1,'first');
    i2 = find(rand <= f,1,'first');
    
    [crosspop(n).x , crosspop(n+1).x] = UniformCrossOver(pop(i1).x,pop(i2).x);
    
    [crosspop(n).x , crosspop(n).fit] = fitness(crosspop(n).x,data.lb,data.ub,gamma,SYS);
    [crosspop(n+1).x , crosspop(n+1).fit] = fitness(crosspop(n+1).x,data.lb,data.ub,gamma,SYS);
    
end

end


function [y1,y2] = UniformCrossOver(x1,x2)

R1 = rand(size(x1));
R2 = 1-R1;

y1 = (R1.*x1)+(R2.*x2);
y2 = (R2.*x1)+(R1.*x2);

end


















