function  mutpop = mutation(mutpop,pop,data,gamma,SYS)

nmut = data.nmut;
npop = data.npop;

for n = 1:nmut
    I = randi([1 npop]);
    mutpop(n).x = UniformMutation(pop(I).x,0.01,data.lb,data.ub);
    [mutpop(n).x , mutpop(n).fit] = fitness(mutpop(n).x,data.lb,data.ub,gamma,SYS);
end

end

function y = UniformMutation(x,R,lb,ub)

n = numel(x);
I = randsample(n,ceil(R*n));
d = unifrnd(-0.3,0.9,size(lb)).*(ub-lb);
x(I) = x(I)+d(I);
y = x;

end


