%plotting experimental data
clearvars
close all

fig=figure('visible','on');
set(fig, 'Position',  [541,1126,919,895])
set(gcf,'color','w');
left_color = [0 0 0];
right_color = [0 0 0.5];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% ax1 = axes();
% hold(ax1,'on')
% grid(ax1,'on')
% xlabel(ax1,'$t$','Interpreter','Latex','FontSize', 14)
% ylabel(ax1,'$P_h(t)$','Interpreter','Latex','FontSize', 14)
% axis(ax1,'square')
%axis(ax1,[-10 450 -0.5 20])

kp=[30,40,80,85,90,100,300];
ki=[3,5,1,2,85,4,10];
for i=1:length(kp)
    file=sprintf('Data/pH_Data_20220826/Data_kp_%d_ki_%d.csv',kp(i),ki(i)); 
    [date,sp,y,u] = csvimport(file, 'columns', {'Date-Time','sp','y','u'});
    t=((1:1:length(sp)).*5)./60;
    subplot(length(kp),1,i)
    yyaxis left
        plot(t,sp,'r.-')
        hold on
        plot(t,y,'k-','LineWidth',2)
        xlabel('$t$','Interpreter','Latex','FontSize', 14)
        ylabel('$P_h(t)$','Interpreter','Latex','FontSize', 14)
        xlim([0,t(end)])
    yyaxis right
        plot(t,u,'b')
        ylabel('$\Phi(t)$','Interpreter','Latex','FontSize', 14)          
end

legend('set point','response','input')
