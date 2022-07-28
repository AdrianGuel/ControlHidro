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
y=5*ones(1,length(den));
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
%dph=8;
t=0:Ts:1000; %simulationtime
dph=8*heaviside(t)-2*heaviside(t-400);
%% Simulation
fig=figure('visible','on');
set(fig, 'Position',  [454,239,919,573])
set(gcf,'color','w');
subplot(2,1,1)
h = animatedline;
h.Color='red';
h.LineWidth=2;
hsp = animatedline;
hsp.Color='blue';
hsp.LineWidth=2;
axis([0,t(end)/60,0,14])
ylabel('$P_h$','Interpreter','Latex','FontSize', 14)
xlabel('$t$','Interpreter','Latex','FontSize', 14)
grid on

subplot(2,1,2)
h2 = animatedline;
h2.Color='black';
h2.LineWidth=2;
xlim([0,t(end)/60])
ylabel('$u$','Interpreter','Latex','FontSize', 14)
xlabel('$t$','Interpreter','Latex','FontSize', 14)
grid on

[A,map] = rgb2ind(frame2im(getframe(fig)),256);
imwrite(A,map,'2.gif','LoopCount',65535,'DelayTime',0.01);

for k = 1:length(t)
    y(1)=Fk(y,u,num,den); %model
    e(1)=dph(k)-y(1); %error
    u(1)= control(u,e,q);%control PID
    [y,e,u]=shifting(y,e,u);
    addpoints(h,t(k)/60,y(1));
    addpoints(hsp,t(k)/60,dph(k));
    addpoints(h2,t(k)/60,u(1));
    drawnow
    if(mod(k,20)==0)
        [A,map] = rgb2ind(frame2im(getframe(fig)),256);
        imwrite(A,map,'2.gif','WriteMode','append','DelayTime',0.01);
    end
end

function uk=control(u,e,q)
    uk=u(2)+q(1)*e(1)+q(2)*e(2)+q(3)*e(3);
    %% Saturation
    if uk>20
        uk=20;
    end
    if uk<-20
        uk=-20;
    end    
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
