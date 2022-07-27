close all
clearvars
clc
%Performs model estimations imposing a linear time-delayed model in a
%hydroponic system, the estimation of the model parameters uses a simple
%generic genetic algorithm
%Guel-Cortez 2022
% 
load('WS_PH2.mat')
% subplot(2,1,2)
%% Initial experimental data
figure
yyaxis left
plot(t1,flujo)
yyaxis right
plot(t2,ph)
%Model estimations
%% Model 1
tx=t1((t1>=53)& (t1<=185));
y=ph((t1>=53)& (t1<=185))-7.51;
u=flujo((t1>=53)& (t1<=185));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau1=sol(3);
sys1 = tf(num,den,'InputDelay',sol(3));

%% Model 2
tx=t1((t1>=185)& (t1<=315));
y=ph((t1>=185)& (t1<=315))-6.42;
u=flujo((t1>=185)& (t1<=315));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau2=sol(3);
sys2 = tf(num,den,'InputDelay',sol(3));

%% Model 3
tx=t1((t1>=315)& (t1<=450));
y=ph((t1>=315)& (t1<=450))-6.95;
u=flujo((t1>=315)& (t1<=450));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau3=sol(3);
sys3 = tf(num,den,'InputDelay',sol(3));

%% Model 4
tx=t1((t1>=450)& (t1<=585));
y=ph((t1>=450)& (t1<=585))-6.29;
u=flujo((t1>=450)& (t1<=585));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau4=sol(3);
sys4 = tf(num,den,'InputDelay',sol(3));

%% Model 5
tx=t1((t1>=585)& (t1<=715));
y=ph((t1>=585)& (t1<=715))-6.76;
u=flujo((t1>=585)& (t1<=715));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau5=sol(3);
sys5 = tf(num,den,'InputDelay',sol(3));

%% Model 6
tx=t1((t1>=715)& (t1<=845));
y=ph((t1>=715)& (t1<=845))-6.33;
u=flujo((t1>=715)& (t1<=845));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau6=sol(3);
sys6 = tf(num,den,'InputDelay',sol(3));

%% Model 7
tx=t1((t1>=845)& (t1<=980));
y=ph((t1>=845)& (t1<=980))-6.66;
u=flujo((t1>=845)& (t1<=980));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau7=sol(3);
sys7 = tf(num,den,'InputDelay',sol(3));

%% Model 8
tx=t1((t1>=980)& (t1<=1086));
y=ph((t1>=980)& (t1<=1086))-6.23;
u=flujo((t1>=980)& (t1<=1086));

options = optimoptions('ga','PlotFcn',"gaplotbestf",'UseParallel', true,'MaxStallGenerations',500,'MaxGenerations',1000);
[x,fval] = ga(@(K) Pestimation(tx,u,y,K),3,[],[],[],[],[-100;0;0],[100;100;100],[],options);

[ye,sol]=Pestimation(tx,u,y,x);
figure
yyaxis left
 plot(tx,u,'r')
yyaxis right
 plot(tx,y,'b')
 hold on
 plot(tx,ye,'k')
 xlim([tx(1),tx(end)])
 
num = sol(1);
den = [1 sol(2) 0];
tau8=sol(3);
sys8 = tf(num,den,'InputDelay',sol(3));

save('analysis.mat')
function varargout= Pestimation(t,u,y,K)
    num = K(1);
    den = [1 K(2) 0];
    sys = tf(num,den,'InputDelay',K(3));
    ye = lsim(sys,u,t);
    %cost = norm(y - ye,2)^2+0.5*norm(K,2)^2; 
    cost = norm(y - ye,2)^2;%+0.5*norm(K,2)^2; 

    if abs(nargout)==1
        varargout={cost};
    else
        varargout={ye,K};
    end
end
