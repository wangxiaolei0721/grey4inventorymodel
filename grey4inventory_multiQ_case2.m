% clear data and figure
clc;
clear;
close all;
%% model setting
% equation parameter
d=12;
theta=0.03;
lambda=0.05;
% lambdaeqtheta:lambda=theta, 1 is TRUE, 0 is FALSE
lambdaeqtheta=0;
% the order quantity
Q_order=[400;280;320;360];
% the time of order arrival
time0=0;
% the time resolution
delta_t=1;
% generate the trajectory of inventory levels
[time_true1,trajectory_true1] = trajectory(theta,d,lambda,time0,delta_t,Q_order(1));
[time_true2,trajectory_true2] = trajectory(theta,d,lambda,time0,delta_t,Q_order(2));
[time_true3,trajectory_true3] = trajectory(theta,d,lambda,time0,delta_t,Q_order(3));
[time_true4,trajectory_true4] = trajectory(theta,d,lambda,time0,delta_t,Q_order(4));
% produce simulated trajectory
rng(1); % 1
[time_simu1,trajectory_simu1] = trajectory_simulation(theta,d,lambda,time0,delta_t,Q_order(1));
[time_simu2,trajectory_simu2] = trajectory_simulation(theta,d,lambda,time0,delta_t,Q_order(2));
[time_simu3,trajectory_simu3] = trajectory_simulation(theta,d,lambda,time0,delta_t,Q_order(3));
[time_simu4,trajectory_simu4] = trajectory_simulation(theta,d,lambda,time0,delta_t,Q_order(4));
%% smoothing
% smooth interval
rangeval1=[time_simu1(1),time_simu1(end)];
rangeval2=[time_simu2(1),time_simu2(end)];
rangeval3=[time_simu3(1),time_simu3(end)];
rangeval4=[time_simu4(1),time_simu4(end)];
% number of spline basis
nbasis=4;
% cubic B-spline basis
basisobj1 = create_bspline_basis(rangeval1, nbasis);
% perform parameter estimation to obtain functional data objects
fdobj1=smooth_basis(time_simu1,trajectory_simu1,basisobj1);
% cubic B-spline basis
basisobj2 = create_bspline_basis(rangeval2, nbasis);
% perform parameter estimation to obtain functional data objects
fdobj2=smooth_basis(time_simu2,trajectory_simu2,basisobj2);
% cubic B-spline basis
basisobj3 = create_bspline_basis(rangeval3, nbasis);
% perform parameter estimation to obtain functional data objects
fdobj3=smooth_basis(time_simu3,trajectory_simu3,basisobj3);
% cubic B-spline basis
basisobj4 = create_bspline_basis(rangeval4, nbasis);
% perform parameter estimation to obtain functional data objects
fdobj4=smooth_basis(time_simu4,trajectory_simu4,basisobj4);
% evaluate smoothed trajectory
trajectory_smooth1=eval_fd(time_simu1, fdobj1);
trajectory_smooth2=eval_fd(time_simu2, fdobj2);
trajectory_smooth3=eval_fd(time_simu3, fdobj3);
trajectory_smooth4=eval_fd(time_simu4, fdobj4);
% evaluate derivative of smoothed trajectory
trajectory_derivative_smooth1=eval_fd(time_simu1, fdobj1, 1);
trajectory_derivative_smooth2=eval_fd(time_simu2, fdobj2, 1);
trajectory_derivative_smooth3=eval_fd(time_simu3, fdobj3, 1);
trajectory_derivative_smooth4=eval_fd(time_simu4, fdobj4, 1);
% plot time vs level
figure('unit','centimeters','position',[5,5,30,20],'PaperPosition',[5,5,30,20],'PaperSize',[30,20])
tiledlayout(2,2,'Padding','Compact');
nexttile
% plot time vs true level
plot(time_true1,trajectory_true1,'LineWidth',1)
hold on
% plot simulated time vs simulated level
plot(time_simu1,trajectory_simu1,'LineWidth',1.5)
% plot smoothed time vs smoothed level
plot(time_simu1,trajectory_smooth1,'Color',[0 191 191]/255,'LineStyle','--','LineWidth',2.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'(a) Q=400'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level"],'location','northeast','FontSize',10,'NumColumns',1)
nexttile
% plot time vs true level
plot(time_true2,trajectory_true2,'LineWidth',1)
hold on
% plot simulated time vs simulated level
plot(time_simu2,trajectory_simu2,'LineWidth',1.5)
% plot smoothed time vs smoothed level
plot(time_simu2,trajectory_smooth2,'Color',[0 191 191]/255,'LineStyle','--','LineWidth',2.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'(b) Q=320'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level"],'location','northeast','FontSize',10,'NumColumns',1)
nexttile
% plot time vs true level
plot(time_true3,trajectory_true3,'LineWidth',1)
hold on
% plot simulated time vs simulated level
plot(time_simu3,trajectory_simu3,'LineWidth',1.5)
% plot smoothed time vs smoothed level
plot(time_simu3,trajectory_smooth3,'Color',[0 191 191]/255,'LineStyle','--','LineWidth',2.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'(c) Q=280'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level"],'location','northeast','FontSize',10,'NumColumns',1)
nexttile
% plot time vs true level
plot(time_true4,trajectory_true4,'LineWidth',1)
hold on
% plot simulated time vs simulated level
plot(time_simu4,trajectory_simu4,'LineWidth',1.5)
% plot smoothed time vs smoothed level
plot(time_simu4,trajectory_smooth4,'Color',[0 191 191]/255,'LineStyle','--','LineWidth',2.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'(d) Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level"],'location','northeast','FontSize',10,'NumColumns',1)
% save figure
savefig(gcf,'.\figure\case2_simulation_level.fig')
%% estimation
% simulated time 1,2,3 for parameter estimation
time_simu={time_simu1,time_simu2,time_simu3};
% smoothed trajectory 1,2,3 for parameter estimation
trajectory_smooth={trajectory_smooth1,trajectory_smooth2,trajectory_smooth3};
% derivative of smoothed trajectory 1,2,3 for parameter estimation
trajectory_derivative_smooth={trajectory_derivative_smooth1,trajectory_derivative_smooth2,trajectory_derivative_smooth3};
% initial lambda
lambda_initial=0;
% lsqnonlin function setting
opt_options=optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','MaxFunctionEvaluations',100,'FunctionTolerance',1e-8,'StepTolerance',1e-6);
% residual function of lambda under multiple orders
minobjfun = @(lambda) lambda_residual_multiQ(time0,time_simu,trajectory_smooth,trajectory_derivative_smooth,lambdaeqtheta,lambda);
% lambda optimazation
lambda_estimate = lsqnonlin(minobjfun,lambda_initial,0,.1,opt_options);
% demand vector 1
demand_vector1=exp(-lambda_estimate*(time_simu1-time0));
demand_vector2=exp(-lambda_estimate*(time_simu2-time0));
demand_vector3=exp(-lambda_estimate*(time_simu3-time0));
% merged demand vector
demand_vector=[demand_vector1;demand_vector2;demand_vector3];
% merged smooth trajectory
trajectory_smooth=[trajectory_smooth1;trajectory_smooth2;trajectory_smooth3];
% merged first derivative
trajectory_derivative_smooth=[trajectory_derivative_smooth1;trajectory_derivative_smooth2;trajectory_derivative_smooth3];
% data matrix for parameter estimation
H_lambda=-[trajectory_smooth,demand_vector];
% estimates
parameter_estimate = (H_lambda'*H_lambda)\H_lambda'*trajectory_derivative_smooth;
theta_estimate = parameter_estimate(1);
d_estimate = parameter_estimate(2);
%% validation plot
% derivative plot
figure('unit','centimeters','position',[5,5,30,20],'PaperPosition',[5,5,30,20],'PaperSize',[30,20])
tiledlayout(2,2,'Padding','Compact');
nexttile
% demand vector 1
demand_vector1=exp(-lambda_estimate*(time_simu1-time0));
% data matrix for evaluating derivative
H_lambda1=-[trajectory_smooth1,demand_vector1];
% estimate derivative
trajectory_derivative_estimate1=H_lambda1*parameter_estimate;
plot(time_simu1,trajectory_derivative_smooth1,'LineWidth',1)
hold on;
plot(time_simu1,trajectory_derivative_estimate1,'LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory change'],'FontSize',14)
title({'(a) Q=400'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Smoothed derivative","Fitted derivative"],'location','southeast','FontSize',8,'NumColumns',1)
nexttile
% demand vector 2
demand_vector2=exp(-lambda_estimate*(time_simu2-time0));
% data matrix for evaluating derivative
H_lambda2=-[trajectory_smooth2,demand_vector2];
% estimate derivative
trajectory_derivative_estimate2=H_lambda2*parameter_estimate;
plot(time_simu2,trajectory_derivative_smooth2,'LineWidth',1)
hold on;
plot(time_simu2,trajectory_derivative_estimate2,'LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory change'],'FontSize',14)
title({'(b) Q=320'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Smoothed derivative","Fitted derivative"],'location','southeast','FontSize',8,'NumColumns',1)
nexttile
% demand vector 3
demand_vector3=exp(-lambda_estimate*(time_simu3-time0));
% data matrix for evaluating derivative
H_lambda3=-[trajectory_smooth3,demand_vector3];
% estimate derivative
trajectory_derivative_estimate3=H_lambda3*parameter_estimate;
plot(time_simu3,trajectory_derivative_smooth3,'LineWidth',1)
hold on;
plot(time_simu3,trajectory_derivative_estimate3,'LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory change'],'FontSize',14)
title({'(c) Q=280'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Smoothed derivative","Fitted derivative"],'location','southeast','FontSize',8,'NumColumns',1)
nexttile
% demand vector 4
demand_vector4=exp(-lambda_estimate*(time_simu4-time0));
% data matrix for evaluating derivative
H_lambda4=-[trajectory_smooth4,demand_vector4];
% estimate derivative
trajectory_derivative_estimate4=H_lambda4*parameter_estimate;
plot(time_simu4,trajectory_derivative_smooth4,'LineWidth',1)
hold on;
plot(time_simu4,trajectory_derivative_estimate4,'LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory change'],'FontSize',14)
title({'(d) Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Smoothed derivative","Fitted derivative"],'location','southeast','FontSize',8,'NumColumns',1)
% save figure
savefig(gcf,'.\figure\case2_fitted_derivative.fig')
% level plot
figure('unit','centimeters','position',[5,5,15,10],'PaperPosition',[5,5,15,10],'PaperSize',[15,10])
[time_estimate4,trajectory_smooth_estimate4]=trajectory(theta_estimate,d_estimate,lambda_estimate,time0,delta_t,Q_order(4));
plot(time_true4,trajectory_true4,'LineStyle','--','LineWidth',1)
hold on
plot(time_simu4,trajectory_simu4,'LineStyle','--','LineWidth',1.5)
plot(time_simu4,trajectory_smooth4,'LineStyle','--','LineWidth',1.5)
plot(time_estimate4,trajectory_smooth_estimate4,'LineStyle','--','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'Order quantity Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level","Estimated level"],'location','northeast','FontSize',8,'NumColumns',1)
% save(".\data\parameter.mat","lambda_estimate","theta_estimate","d_estimate")
%% optimization
% economic parameter
p=6.0;
c=4.0;
h=0.02;
% order cycle to be evaluated
T_eval = [1:0.1:60];
% profit corresponding to simulated parameters
profit_true = profit(theta,d,lambda,p,c,h,T_eval);
% optimal order cycle corresponding to simulated parameters
T_true_optimal = optimal_cycle(theta,p,c,h);
% optimal order quantity corresponding to estimated parameters
Q_true_optimal=T2Q(theta,d,lambda,T_true_optimal);
% optimal profit corresponding to simulated parameters
profit_true_optimal = profit(theta,d,lambda,p,c,h,T_true_optimal);
% profit corresponding to estimated parameters
profit_estimate = profit(theta_estimate,d_estimate,lambda_estimate,p,c,h,T_eval);
% optimal order cycle corresponding to estimated parameters
T_estimate_optimal = optimal_cycle(theta_estimate,p,c,h);
% optimal order quantity corresponding to estimated parameters
Q_estimate_optimal=T2Q(theta_estimate,d_estimate,lambda_estimate,T_estimate_optimal);
% optimal profit corresponding to estimated parameters
profit_estimate_optimal = profit(theta_estimate,d_estimate,lambda_estimate,p,c,h,T_estimate_optimal);
figure('unit','centimeters','position',[5,5,30,10],'PaperPosition',[5,5,30,10],'PaperSize',[30,10])
tiledlayout(1,3,'Padding','Compact');
nexttile
% plot T vs profit
plot(T_eval,profit_true,'LineStyle','-','LineWidth',1.5,'Color',[0, 114, 189]/255)
hold on
plot(T_true_optimal,profit_true_optimal,'LineStyle','none','Color',[0, 114, 189]/255,'Marker','*','MarkerSize',8,'LineWidth',1)
plot(T_eval,profit_estimate,'LineStyle','-','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(T_estimate_optimal,profit_estimate_optimal,'LineStyle','none','Color',[0.8500 0.3250 0.0980],'Marker','*','MarkerSize',8,'LineWidth',1)
xlabel({'Hour'},'FontSize',14)
ylabel(['Profit'],'FontSize',14)
title({'(a) Profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Profit based on simulation parameters","Optimal order quantity for simulation parameters","Profit based on estimated parameters","Optimal order quantity for estimated parameters"],'location','southwest','FontSize',6,'NumColumns',1)
% derivative of profit corresponding to simulated parameters
profit_der_true = profit_derivative(theta,d,lambda,p,c,h,T_eval);
% derivative of profit corresponding to optimal order cycle
profit_der_true_optimal = profit_derivative(theta,d,lambda,p,c,h,T_true_optimal);
% derivative of profit corresponding to estimated parameters
profit_der_estimate = profit_derivative(theta_estimate,d_estimate,lambda_estimate,p,c,h,T_eval);
% derivative of profit corresponding to optimal order cycle
profit_der_estimate_optimal = profit_derivative(theta_estimate,d_estimate,lambda_estimate,p,c,h,T_estimate_optimal);
nexttile
% plot T vs first derivative of profit
plot(T_eval,profit_der_true,'LineStyle','-','LineWidth',1.5)
hold on
plot(T_true_optimal,profit_der_true_optimal,'LineStyle','none','Color',[0, 114, 189]/255,'Marker','*','MarkerSize',8,'LineWidth',1)
plot(T_eval,profit_der_estimate,'LineStyle','-','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(T_estimate_optimal,profit_der_estimate_optimal,'LineStyle','none','Color',[0.8500 0.3250 0.0980],'Marker','*','MarkerSize',8,'LineWidth',1)
xlabel({'Hour'},'FontSize',14)
ylabel(['First derivative of profit'],'FontSize',14)
title({'(b) First derivative of profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
%
% second derivative of profit corresponding to simulated parameters
profit_der2_true = profit_derivative2(theta,d,lambda,p,c,h,T_eval);
% second derivative of profit corresponding to estimated parameters
profit_der2_estimate = profit_derivative2(theta_estimate,d_estimate,lambda_estimate,p,c,h,T_eval);
nexttile
% plot T vs second derivative of profit
plot(T_eval,profit_der2_true,'LineStyle','-','LineWidth',1.5,'Color',[0, 114, 189]/255)
hold on
plot(T_eval,profit_der2_estimate,'LineStyle','-','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
yline(0,"--")
xlabel({'Hour'},'FontSize',14)
ylabel(['Second derivative of Profit'],'FontSize',14)
title({'(c) Second derivative of profit'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
% save figure
savefig(gcf,'.\figure\case2_optimization.fig')


