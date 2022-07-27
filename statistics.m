close all
clearvars
clc

%Performs the statistics to find the average linear model of an hydroponic
%system 
%Guel-Cortez 2022

load('analysis.mat')

Delays=[tau1 tau2 tau3 tau4 tau5 tau6 tau7 tau8];
MD=mean(Delays);
varD=var(Delays);

systems={sys1,sys2,sys3,sys4,sys5,sys6,sys7,sys8};
im=zeros(1,8);
km=zeros(1,8);

for i=1:8
    [num,den] = tfdata(systems{i},'v');
    im(i)=num(3);
    km(i)=den(2);
end
Mim=mean(im);
varim=var(im);
Mkm=mean(km);
varkm=var(km);

%% Average model
Avsys=tf([0 0 Mim],[1 Mkm 0],'InputDelay',MD)

save('statistics.mat')
