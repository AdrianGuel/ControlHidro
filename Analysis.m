close all
clearvars
clc

H2 = tf([2.465e-05 6.219e-06 2.019e-08 1.028e-09],[1 0.01741 0.0002487 2.542e-08 3.609e-10]); %T=0.5
H3 = tf([0.000156 2.13e-06 -8.442e-09 4.754e-11],[1 0.01117 5.318e-05 5.787e-07 7.115e-11],'InputDelay', 11);

% subplot(2,1,1)
% H=tf([1 0.5],[1 2 0],'InputDelay', 7*0.5);
% impulse(H)
% 
load('WS_PH2.mat')
% subplot(2,1,2)
%
% figure
% yyaxis left
% plot(t1,flujo)
% yyaxis right
% plot(t2,ph)

%% Negative input
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
sys1n = tf(num,den,'InputDelay',sol(3));

%% Positive input
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
sys1p = tf(num,den,'InputDelay',sol(3));

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
