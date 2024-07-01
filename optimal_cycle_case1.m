% clear data and figure
clc;
clear;
close all;
%
load(".\data\parameter1.mat")
% economic parameter
p=6.0;
c=4.0;
h=0.02;
A=100;
%% true parameter
% order cycle to be evaluated
T_eval = (1:0.1:60)';
T_interval=[1,60];
% profit corresponding to simulated parameters
profit_true = profit(d,theta,lambda,p,c,h,A,T_eval);
% optimal order cycle corresponding to simulated parameters
T_true_optimal = optimal_cycle(d,theta,lambda,p,c,h,A,T_interval);
% optimal order quantity corresponding to estimated parameters
Q_true_optimal=T2Q(d,theta,lambda,T_true_optimal);
% optimal profit corresponding to simulated parameters
profit_true_optimal = profit(d,theta,lambda,p,c,h,A,T_true_optimal);
%
syms T;
profit_syms = profit(d,theta,lambda,p,c,h,A,T);
profit_true_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_true_der2=diff(profit_syms,2);
matlabFunction(profit_true_der1,"File","profit_true_derivative1");
matlabFunction(profit_true_der2,"File","profit_true_derivative2");
profit_true_der1=profit_true_derivative1(T_eval);
profit_true_der2=profit_true_derivative2(T_eval);
%% profit_appro
% profit corresponding to simulated parameters
profit_approx_value = profit_approx(d,theta,lambda,p,c,h,A,T_eval);
% optimal order cycle corresponding to simulated parameters
T_approx_optimal = optimal_cycle_approx(d,theta,lambda,p,c,h,A);
% optimal order quantity corresponding to estimated parameters
Q_approx_optimal=T2Q(d,theta,lambda,T_approx_optimal);
% optimal profit corresponding to simulated parameters
profit_approx_optimal = profit(d,theta,lambda,p,c,h,A,T_approx_optimal);
%
syms T;
profit_syms = profit_approx(d,theta,lambda,p,c,h,A,T);
profit_approx_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_approx_der2=diff(profit_syms,2);
matlabFunction(profit_approx_der1,"File","profit_approx_derivative1");
matlabFunction(profit_approx_der2,"File","profit_approx_derivative2");
profit_approx_der1=profit_approx_derivative1(T_eval);
profit_approx_der2=profit_approx_derivative2(T_eval);
%% estimate parameter
% profit corresponding to simulated parameters
profit_est = profit(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T_eval);
% optimal order cycle corresponding to simulated parameters
T_est_optimal = optimal_cycle(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T_interval);
% optimal order quantity corresponding to estimated parameters
Q_est_optimal=T2Q(d_estimate,theta_estimate,lambda_estimate,T_est_optimal);
% optimal profit corresponding to simulated parameters
profit_est_optimal = profit(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T_est_optimal);
%
syms T;
profit_syms = profit(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T);
profit_est_approx_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_est_approx_der2=diff(profit_syms,2);
matlabFunction(profit_est_approx_der1,"File","profit_est_derivative1");
matlabFunction(profit_est_approx_der2,"File","profit_est_derivative2");
profit_est_der1=profit_est_derivative1(T_eval);
profit_est_der2=profit_est_derivative2(T_eval);
%%
% profit corresponding to simulated parameters
profit_est_approx = profit_approx(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T_eval);
% optimal order cycle corresponding to simulated parameters
T_est_approx_optimal = optimal_cycle_approx(d_estimate,theta_estimate,lambda_estimate,p,c,h,A);
% optimal order quantity corresponding to estimated parameters
Q_est_approx_optimal=T2Q(d_estimate,theta_estimate,lambda_estimate,T_est_approx_optimal);
% optimal profit corresponding to simulated parameters
profit_est_approx_optimal = profit(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T_est_approx_optimal);
%
syms T;
profit_syms = profit_approx(d_estimate,theta_estimate,lambda_estimate,p,c,h,A,T);
profit_est_approx_der1=diff(profit_syms,1);
% T_optimal=vpasolve(profit_der1==0,T,T_interval);
profit_est_approx_der2=diff(profit_syms,2);
matlabFunction(profit_est_approx_der1,"File","profit_est_approx_derivative1");
matlabFunction(profit_est_approx_der2,"File","profit_est_approx_derivative2");
profit_est_approx_der1=profit_est_approx_derivative1(T_eval);
profit_est_approx_der2=profit_est_approx_derivative2(T_eval);
%% plot
figure('unit','centimeters','position',[5,5,30,10],'PaperPosition',[5,5,30,10],'PaperSize',[30,10])
tile=tiledlayout(1,3,'Padding','Compact');
nexttile
%
plot(T_eval,profit_true,'LineStyle','-','LineWidth',1.5)
hold on;
plot(T_eval,profit_approx_value,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est_approx,'LineStyle','-','LineWidth',1.5)
%
plot(T_true_optimal,profit_true_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[0, 114, 189]/255)
plot(T_approx_optimal,profit_approx_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[217, 83, 25]/255)
plot(T_est_optimal,profit_est_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[237, 177, 32]/255)
plot(T_est_approx_optimal,profit_est_approx_optimal,'LineStyle','none','Marker','*','MarkerSize',8,'Color',[126, 47, 142]/255)
%
xlabel({'Hour'},'FontSize',14)
ylabel(['Profit'],'FontSize',14)
title({'(a) Profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legends=["Profit for true parameters",...
    "Approximate profit for true parameters",...
    "Profit for estimated parameters",...
    "Approximate profit for estimated parameters",...
    ];
legend(legends,'location','southwest','FontSize',6,'NumColumns',1)
%% plot T vs first derivative of profit
nexttile
plot(T_eval,profit_true_der1,'LineStyle','-','LineWidth',1.5)
hold on
plot(T_eval,profit_approx_der1,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est_der1,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est_approx_der1,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['First derivative of profit'],'FontSize',14)
title({'(b) First derivative of profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
%% second derivative of profit corresponding to simulated parameters
nexttile
plot(T_eval,profit_true_der2,'LineStyle','-','LineWidth',1.5)
hold on
plot(T_eval,profit_approx_der2,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est_der2,'LineStyle','-','LineWidth',1.5)
plot(T_eval,profit_est_approx_der2,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['First derivative of profit'],'FontSize',14)
title({'(b) First derivative of profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
% save figure
savefig(gcf,'.\figure\case1_optimization.fig')
exportgraphics(gcf,'.\figure\case1_optimization.pdf')


