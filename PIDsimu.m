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
e=zeros(1,3);
%% Control parameters
kp=70;
kd=0;
ki=0.3;
q0=kp+kd/Ts+ki*Ts;
q1=-kp-2*kd/Ts;
q2=kd/Ts;

%% Setpoint
dph=8;

%% Simulation
fig=figure('visible','on');
set(fig, 'Position',  [454,239,919,573])
set(gcf,'color','w');
t=0:0.5:1000; %simulationtime
h = animatedline;
h.Color='red';
h.LineWidth=2;
axis([0,t(end)/60,0,14])
ylabel('$P_h$','Interpreter','Latex','FontSize', 14)
xlabel('$t$','Interpreter','Latex','FontSize', 14)

for k = 1:length(t)
    y(1)=Fk(y,u,num,den); %model
    e(1)=dph-y(1); %error
    u(1)=u(2)+q0*e(1)+q1*e(2)+q2*e(3); %control
    addpoints(h,t(k)/60,y(1));
    drawnow
    y=circshift(y,1); 
    u=circshift(u,1);
    e=circshift(e,1);
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
