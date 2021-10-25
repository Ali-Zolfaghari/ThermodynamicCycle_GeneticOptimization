function [XBST , BEST] = GA(lb,ub,npop,pc,MaxIter,gamma,SYS,NS)

disp('=======================================================================');
disp('                     Genetic Algorithm Optimization');
disp('=======================================================================');
disp(' Iteration     P2/P1  T4         T3          etac      etat      mfuel');
tic

ncross = 2*round(npop*pc/2);

pm = 1-pc;
nmut = round(npop*pm);

data.npop = npop;
data.ncross = ncross;
data.nmut = nmut;
data.maxiter = MaxIter;
data.lb = lb;
data.ub = ub;

tic
emp.x = [];
emp.fit = [];
emp.info = [];
pop = repmat(emp,npop,1);

for i = 1:npop
    gen{i,1} = randsrc(5,NS,[0 1]);
    gens{i,1} = num2str(gen{i,1});
    for j = 1:5
        X(j) = lb(j) + ((ub(j)-lb(j))/((2^NS)-1))*bin2dec(gens{i,1}(j,:));
    end
    pop(i).x = X;
    [pop(i).x , pop(i).fit] = fitness(pop(i).x,lb,ub,gamma,SYS);
end

for ITER = 1:MaxIter
    
    % Crossover
    crosspop = repmat(emp,ncross,1);
    crosspop = crossover(crosspop,pop,data,gamma,SYS);
    
    % Mutation
    mutpop = repmat(emp,nmut,1);
    mutpop = mutation(mutpop,pop,data,gamma,SYS);
    
    % Merged
    [pop] = [pop;crosspop;mutpop];
    
    % Sorting
    [value,index] = sort([pop.fit]);
    pop = pop(index);
    gpop = pop(1);
    
    % Select
    pop = pop(1:npop);
    
    XBST(ITER,:) = gpop.x;
    BEST(ITER) = gpop.fit;
    MEAN(ITER) = mean([pop.fit]);
    
    fprintf('%10d  %8.3f  %8.3f  %8.3f  %8.3f  %8.3f  %8.3f \n',ITER,gpop.x(1),gpop.x(2),gpop.x(3),gpop.x(4),gpop.x(5),gpop.fit);
    
end

% Results
disp('=======================================================================');
disp(['  Time   =  '  num2str(toc)]);

figure(2)
subplot(2,1,1);plot(BEST(fix(0.01*ITER)+1:ITER),'r','LineWidth',2);title (' GA ');xlabel('Iteration');ylabel('Best Fitness');
subplot(2,1,2);plot(MEAN(fix(0.01*ITER)+1:ITER),'b','LineWidth',2);xlabel('Iteration');ylabel('Mean Fitness');


end
