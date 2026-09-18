% clear data and figure
clc;
clear;
close all;
%
load(".\data\case_estimates.mat")
% economic parameter
p=6.0;
c=4.0;
h=0.2;
K=100;
%% true parameter
% order cycle to be evaluated
T_eval = (1:0.2:7)';
T_interval=[1,7];
% profit corresponding to simulated parameters
profit_true_value = profit(lambda,d,p,c,h,K,T_eval);
% optimal order cycle corresponding to simulated parameters
T_true_optimal = optimal_cycle(lambda,d,p,h,K,T_interval);
% optimal order quantity corresponding to estimated parameters
Q_true_optimal = d*T_true_optimal;
% optimal profit corresponding to simulated parameters
profit_true_optimal = profit(lambda,d,p,c,h,K,T_true_optimal);
%
syms T;
profit_syms = profit(lambda,d,p,c,h,K,T);
profit_true_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_true_der2=diff(profit_syms,2);
matlabFunction(profit_true_der1,"File","profit_true_derivative1");
matlabFunction(profit_true_der2,"File","profit_true_derivative2");
profit_true_der1=profit_true_derivative1(T_eval);
profit_true_der2=profit_true_derivative2(T_eval);
%% profit_appro
% profit corresponding to simulated parameters
profit_appro_value = profit_appro(lambda,d,p,c,h,K,T_eval);
% optimal order cycle corresponding to simulated parameters
T_true_appro_optimal = optimal_cycle_appro(lambda,d,p,c,h,K);
% optimal order quantity corresponding to estimated parameters
Q_true_appro_optimal=d*T_true_appro_optimal;
% optimal profit corresponding to simulated parameters
profit_true_appro_optimal = profit_appro(lambda,d,p,c,h,K,T_true_appro_optimal);
%
syms T;
profit_syms = profit_appro(lambda,d,p,c,h,K,T);
profit_appro_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_appro_der2=diff(profit_syms,2);
matlabFunction(profit_appro_der1,"File","profit_true_appro_derivative1");
matlabFunction(profit_appro_der2,"File","profit_true_appro_derivative2");
profit_appro_der1=profit_appro_derivative1(T_eval);
profit_appro_der2=profit_appro_derivative2(T_eval);
%% estimate parameter
% profit corresponding to simulated parameters
profit_est_value = profit(lambda_estimate,d_estimate,p,c,h,K,T_eval);
% optimal order cycle corresponding to simulated parameters
T_est_optimal = optimal_cycle(lambda_estimate,d_estimate,p,h,K,T_interval);
% optimal order quantity corresponding to estimated parameters
Q_est_optimal=d_estimate*T_est_optimal;
% optimal profit corresponding to simulated parameters
profit_est_optimal = profit(lambda_estimate,d_estimate,p,c,h,K,T_est_optimal);
%
syms T;
profit_syms = profit(lambda_estimate,d_estimate,p,c,h,K,T);
profit_est_appro_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_est_appro_der2=diff(profit_syms,2);
matlabFunction(profit_est_appro_der1,"File","profit_est_derivative1");
matlabFunction(profit_est_appro_der2,"File","profit_est_derivative2");
profit_est_der1=profit_est_derivative1(T_eval);
profit_est_der2=profit_est_derivative2(T_eval);
%%
% profit corresponding to simulated parameters
profit_est_appro = profit_appro(lambda_estimate,d_estimate,p,c,h,K,T_eval);
% optimal order cycle corresponding to simulated parameters
T_est_appro_optimal = optimal_cycle_appro(lambda_estimate,d_estimate,p,c,h,K);
% optimal order quantity corresponding to estimated parameters
Q_est_appro_optimal=d_estimate*T_est_appro_optimal;
% optimal profit corresponding to simulated parameters
profit_est_appro_optimal = profit_appro(lambda_estimate,d_estimate,p,c,h,K,T_est_appro_optimal);
%
syms T;
profit_syms = profit_appro(lambda_estimate,d_estimate,p,c,h,K,T);
profit_est_appro_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_est_appro_der2=diff(profit_syms,2);
matlabFunction(profit_est_appro_der1,"File","profit_est_appro_derivative1");
matlabFunction(profit_est_appro_der2,"File","profit_est_appro_derivative2");
profit_est_appro_der1=profit_est_appro_derivative1(T_eval);
profit_est_appro_der2=profit_est_appro_derivative2(T_eval);
%% plot
figure('unit','centimeters','position',[5,5,40,15],'PaperPosition',[5,5,40,15],'PaperSize',[40,15])
tile=tiledlayout(1,3,'Padding','Compact');
nexttile
%
plot(T_eval,profit_true_value,'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',3)
hold on;
plot(T_eval,profit_est_value,'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',3)
plot(T_eval,profit_appro_value,'LineStyle','-','LineWidth',2,'Marker','x','MarkerSize',3)
plot(T_eval,profit_est_appro,'LineStyle','-','LineWidth',2,'Marker','square','MarkerSize',3)
%
plot(T_true_optimal,profit_true_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[0, 114, 189]/255)
plot(T_est_optimal,profit_est_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[237, 177, 32]/255)
plot(T_true_appro_optimal,profit_true_appro_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[217, 83, 25]/255)
plot(T_est_appro_optimal,profit_est_appro_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[126, 47, 142]/255)
%
xlabel({'Day'},'FontSize',14)
ylabel(['Profit'],'FontSize',14)
title({'(a) Profit'},'FontSize',16)
set(gca,'FontSize',14) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
%% plot T vs first derivative of profit
nexttile
plot(T_eval,profit_true_der1,'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',3)
hold on
plot(T_eval,profit_appro_der1,'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',3)
plot(T_eval,profit_est_der1,'LineStyle','-','LineWidth',2,'Marker','x','MarkerSize',3)
plot(T_eval,profit_est_appro_der1,'LineStyle','-','LineWidth',2,'Marker','square','MarkerSize',3)
yline(0,'LineStyle','--','LineWidth',2)
xlabel({'Day'},'FontSize',14)
ylabel(['First derivative of profit'],'FontSize',14)
title({'(b) First derivative of profit'},'FontSize',16)
set(gca,'FontSize',14) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
%% second derivative of profit corresponding to simulated parameters
nexttile
plot(T_eval,profit_true_der2,'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',3)
hold on
plot(T_eval,profit_appro_der2,'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',3)
plot(T_eval,profit_est_der2,'LineStyle','-','LineWidth',2,'Marker','x','MarkerSize',3)
plot(T_eval,profit_est_appro_der2,'LineStyle','-','LineWidth',2,'Marker','square','MarkerSize',3)
yline(0,'LineStyle','--','LineWidth',2)
xlabel({'Day'},'FontSize',14)
ylabel(['Second derivative of profit'],'FontSize',14)
title({'(b) Second derivative of profit'},'FontSize',16)
set(gca,'FontSize',14) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legends=["Profit for simulated parameters",...
    "Profit for estimated parameters",...
    "Approimate profit for simulated parameters",...
    "Approimate profit for estimated parameters",...
    ];
legend(legends,'location','southeast','FontSize',10,'NumColumns',1)
% save figure
savefig(gcf,'.\figure\case_optimization.fig')
exportgraphics(gcf,'.\figure\case_optimization.pdf')


