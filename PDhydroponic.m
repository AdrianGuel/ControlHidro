%simulation of PID control in a hydroponic system
close all
clearvars
clc

load('analysis.mat')
Ts=0.5;
sysd1n = c2d(sys1n,Ts,'foh');
sysd1p = c2d(sys1p,Ts,'foh');

%% Comparison continous vs discrte step response
% figure
% subplot(2,1,1)
% impulse(sys1n,'--',sysd1n,'-')
% subplot(2,1,2)
% impulse(sys1p,'--',sysd1p,'-')
% [numd1n,dend1n] = tfdata(sysd1n,'v');
% [numd1p,dend1p] = tfdata(sysd1p,'v');
%%
w=0:1e-3:2;
kpx=0.195351E0.*(0.1E3.*w.^2.*cos(0.896E1.*w)+0.9601E4.*w.*sin(0.896E1.*w));
kdx=(-0.195351E0).*(0.9601E4.*cos(0.896E1.*w)+(-0.1E3).*w.*sin(0.896E1.*w));
kd0=-3000:1:3000;
kp0=zeros(1,length(kd0));
figure
set(gcf,'color','w');
plot(kpx,kdx,'b')
hold on 
plot(kp0,kd0,'r')
axis([-50 400 -2000 2000])
xlabel('$k_p$','Interpreter','Latex','FontSize', 16)
ylabel('$k_d$','Interpreter','Latex','FontSize', 16)
%%
[kp,kd]=ginput(3);
s = tf('s');
C1=kp(1)+kd(1)*s;
C2=kp(2)+kd(2)*s;
C3=kp(3)+kd(3)*s;
T1=feedback(sys1p*C1,1);
[y1,t1]=step(T1,500);
T2=feedback(sys1p*C2,1);
[y2,t2]=step(T2,500);
T3=feedback(sys1p*C3,1);
[y3,t3]=step(T3,500);

figure
set(gcf,'color','w');
subplot(3,1,1)
plot(t1,y1)
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
subplot(3,1,2)
plot(t2,y2)
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
subplot(3,1,3)
plot(t3,y3)
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
