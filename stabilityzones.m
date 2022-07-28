%simulation of PID control in a hydroponic system
%Guel-Cortez 2022
close all
clearvars
clc

load('statistics.mat')

w=0:1e-3:0.7;

fig=figure('visible','on');
set(fig, 'Position',  [454,239,919,573])
set(gcf,'color','w');
ax1 = axes();
hold(ax1,'on')
grid(ax1,'on')
xlabel(ax1,'$k_p$','Interpreter','Latex','FontSize', 14)
ylabel(ax1,'$k_i$','Interpreter','Latex','FontSize', 14)
axis(ax1,'square')
axis(ax1,[-10 450 -0.5 20])

ax2 = axes('Position',[0.65 0.65 0.28 0.28]);
hold(ax2,'on')
grid(ax2,'on')
axis(ax2,'square')
axis(ax2,[0 70 -0.5 1.5])

kp0=-3000:1:3000;
ki0=zeros(1,length(kp0));

Cls=rand(length(im),3);
B = 0.5*ones(length(im),1);
Cls(:,3)=B;
for i=length(im):-1:1
    kpx=im(i).^(-1).*w.*(w.*cos(Delays(i).*w)+km(i).*sin(Delays(i).*w));
    kix=(-1).*im(i).^(-1).*w.^2.*((-1).*km(i).*cos(Delays(i).*w)+w.*sin(Delays(i).*w));
    [x0,y0] = intersections(kpx,kix,kp0,ki0);
    x0=x0(x0>=0);
    if length(x0)>1
    index=find((kpx<=x0(2)) & (kix>=0) & (kpx>=0));
    I=detectAC(index);
    if I>1
        index=index(1:I);
    end
    area(ax1,kpx(index),kix(index),'FaceColor',Cls(i,:),'FaceAlpha',0.3,'EdgeColor','none')
    area(ax2,kpx(index),kix(index),'FaceColor',Cls(i,:),'FaceAlpha',0.3,'EdgeColor','none')
    %plot(ax1,kpx(index),kix(index),'b','LineWidth',2)
    %plot(ax2,kpx(index),kix(index),'b','LineWidth',2)
    text(ax1,kpx(floor(index(end)/2)),kix(floor(index(end)/2)), sprintf('Sys %d', i),'Color','k')
     text(ax2,kpx(floor(index(end)/2)),kix(floor(index(end)/2)), sprintf('Sys %d', i),'Color','k')
    else
        %plot(ax1,kpx,kix,'b','LineWidth',2)
        %plot(ax2,kpx,kix,'b','LineWidth',2)
    end
end
plot(ax1,kp0,ki0,'r','LineWidth',2)
plot(ax2,kp0,ki0,'r','LineWidth',2)
%%
kp=[30 100 300];
kd=[0.3 4 10];

plot(ax1,kp,kd,'k.','MarkerSize',15)

s = tf('s');
C1=kp(1)+kd(1)/s;
C2=kp(2)+kd(2)/s;
C3=kp(3)+kd(3)/s;
T1=feedback(Avsys*C1,1);
[y1,t1]=step(T1,500);
T2=feedback(Avsys*C2,1);
[y2,t2]=step(T2,500);
T3=feedback(Avsys*C3,1);
[y3,t3]=step(T3,500);

figure
set(gcf,'color','w');
subplot(3,1,1)
plot(t1,y1)
title(['(k_p,k_i)=(' num2str(kp(1)) ',' num2str(kd(1)) ')']);
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
subplot(3,1,2)
plot(t2,y2)
title(['(k_p,k_i)=(' num2str(kp(2)) ',' num2str(kd(2)) ')']);
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
subplot(3,1,3)
plot(t3,y3)
title(['(k_p,k_i)=(' num2str(kp(3)) ',' num2str(kd(3)) ')']);
xlabel('$t$','Interpreter','Latex','FontSize', 16)
ylabel('$y(t)$','Interpreter','Latex','FontSize', 16)
