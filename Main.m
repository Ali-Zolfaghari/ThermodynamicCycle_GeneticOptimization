%***************************************************************************************************
%*   Optimize thermo cycle by presented code.
%*   I take no responsibilities for any errors in the code or damage thereby.
%*   Please notify me at zolfaghari1992iut@gmail.com if the code is used in any type of application.
%***************************************************************************************************
%*   Developer   : Ali Zolfaghari Sichani (10-10-2019)
%***************************************************************************************************
%*   References  : 
%*   https://web.mit.edu/16.unified/www/FALL/thermodynamics/notes/node111.html
%*   https://www.ohio.edu/mechanical/thermo/property_tables/combustion
%*************************************************************************************************** 
%*   Solving cycle in EES
%*   Inputs      :
%*   lb,ub    (lower and upper bound : [(P2/P1) (T4) (T3) (etac) (etat) ])
%*   NP       (number of population   )
%*   MaxIter  (max. iteration         )
%*   PC       (factor of non-mutation )
%*   Outputs      :
%*   mfuel    (fuel mass flow rate                        )
%*   T3       (air temperature inlet of combustion        )
%*   T4       (flue gas temperature outlet of combustion  )
%*   T7       (stack gas temperature outlet of generator  )
%*   P2/P1    (compressor pressure ratio                  )
%*   etac     (compressor efficiency                      )
%*   etat     (turbine efficiency                         )
%***************************************************************************************************


clear,clc
close all
format compact
format long


lb = [3.0 1200 700 0.75 0.75];
ub = [7.0 1520 900 0.95 0.95];
NP = 25;
MaxIter = 50;
PC = 0.80;





CD = cd;
SYS = ['c:\ees32\ees.exe ',CD,'\CycleProject.ees /solve'];
NS = 5;
gamma = 1.0;

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










