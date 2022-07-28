%% recursive PID control in hydroponic system
%Guel-Cortez 2022
%%
clearvars
close all
clc
load('statistics.mat')
Ts=0.5;
dsys = c2d(Avsys,Ts,'foh');
[num,den] = tfdata(dsys,'v');
y=zeros(1,length(den));
u=zeros(1,length(num)+ 21);
e=zeros(1,3); q=zeros(1,3);
%% Control parameters
kp=30;
kd=0;
ki=0.3;
q(1)=kp+kd/Ts+ki*Ts;
q(2)=-kp-2*kd/Ts;
q(3)=kd/Ts;

%% Setpoint
dph=8;

%% Simulation
fig=figure('visible','on');
set(fig, 'Position',  [454,239,919,573])
set(gcf,'color','w');
t=0:0.5:1000; %simulationtime
subplot(2,1,1)
h = animatedline;
h.Color='red';
h.LineWidth=2;
axis([0,t(end)/60,0,14])
ylabel('$P_h$','Interpreter','Latex','FontSize', 14)
xlabel('$t$','Interpreter','Latex','FontSize', 14)

subplot(2,1,2)
h2 = animatedline;
h2.Color='black';
h2.LineWidth=2;
xlim([0,t(end)/60])
ylabel('$u$','Interpreter','Latex','FontSize', 14)
xlabel('$t$','Interpreter','Latex','FontSize', 14)

for k = 1:length(t)
    y(1)=Fk(y,u,num,den); %model
    e(1)=dph-y(1); %error
    u(1)= control(u,e,q);%control PID
    [y,e,u]=shifting(y,e,u);
    addpoints(h,t(k)/60,y(1));
    addpoints(h2,t(k)/60,u(1));
    drawnow

end

function uk=control(u,e,q)
    uk=u(2)+q(1)*e(1)+q(2)*e(2)+q(3)*e(3);
    %% Saturation
%     if uk>100
%         uk=100;
%     end
%     if uk<-100
%         uk=-100;
%     end    
end

function yk=Fk(y,u,num,den)
    yk=[-den(2:end) zeros(1,21) num]*[y(2:end) u]';
    %% Saturation
    if yk>14
        yk=14;
    end
    if yk<0
        yk=0;
    end
end

function [y,e,u]=shifting(y,e,u)
    y=circshift(y,1); 
    u=circshift(u,1);
    e=circshift(e,1);
end