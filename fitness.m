function [x , Z] = fitness(x,lb,ub,gamma,SYS)

x = max(x,lb);
x = min(x,ub);

rp = x(1);
T4 = x(2);
T3 = x(3);
etc = x(4);
ett = x(5);

propinfo = {rp T4 T3 etc ett};

fid_I = fopen('fm.dat','w');
fprintf(fid_I,'%f %f %f %f %f\r\n',propinfo{1,:});
fclose(fid_I);

fid_O = fopen('tm.dat','w');
fclose(fid_O);

system(SYS);

Output = dlmread('tm.dat');

T7 = Output(1);
mdot = Output(2);

Z = mdot;

c(1) = sign(max(400.0-T7,0.0));
c(2) = sign(max(T4-1520.0,0.0));

ch(1) = c(1)*((400.0-T7)^2.0);
ch(2) = c(2)*((T4-1520.0)^2.0);

% ch(1) = (max(400.0-T7,0.0));
% ch(2) = (max(T4-1520.0,0.0));

ch( ch < 0.0000001 ) = 0.0;

sumch = sum(ch);

Z = Z+gamma*sumch;

end
