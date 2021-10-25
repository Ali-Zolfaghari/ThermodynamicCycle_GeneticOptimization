clear,clc
close all
format long
format compact



CD = cd;

SYS = ['c:\ees32\ees.exe ',CD,'\CycleProject.ees /solve'];

lb = [3.0 1200 700 0.75 0.75];
ub = [7.0 1520 900 0.95 0.95];
NP = 25;
MaxIter = 50;
gamma = 1.0;
NS = 5;
PC = 0.80;

[X , FX] = GA(lb,ub,NP,PC,MaxIter,gamma,SYS,NS);

propinfo = {X(end,1) X(end,2) X(end,3) X(end,4) X(end,5)};

fid_I = fopen('fm.dat','w');
fprintf(fid_I,'%f %f\r\n',propinfo{1,:});
fclose(fid_I);

fid_O = fopen('tm.dat','w');
fclose(fid_O);

system(SYS);

Output = dlmread('tm.dat');

% RESULT
disp('=======================================================================');
disp([' mfuel  =  '  num2str(Output(2))]);
disp([' T3     =  '  num2str(X(end,3))]);
disp([' T4     =  '  num2str(X(end,2))]);
disp([' T7     =  '  num2str(Output(1))]);
disp([' P2/P1  =  '  num2str(X(end,1))]);
disp([' etac   =  '  num2str(X(end,4))]);
disp([' etat   =  '  num2str(X(end,5))]);
disp('=======================================================================');










