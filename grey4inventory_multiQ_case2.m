% clear data and figure
clc;
clear;
close all;
%% model setting
% equation parameter
d=12;
theta=0.01;
lambda=0.02;
% lambdaeqtheta:lambda=theta, 1 is TRUE, 0 is FALSE
lambdaeqtheta=0;
% the order quantity
Q_order=[400;280;320;360];
% the time of order arrival
time0=0;
% the time resolution
delta_t=1;
% generate the trajectory of inventory levels
[time_true1,trajectory_true1] = trajectory(d,theta,lambda,time0,delta_t,Q_order(1));
[time_true2,trajectory_true2] = trajectory(d,theta,lambda,time0,delta_t,Q_order(2));
[time_true3,trajectory_true3] = trajectory(d,theta,lambda,time0,delta_t,Q_order(3));
[time_true4,trajectory_true4] = trajectory(d,theta,lambda,time0,delta_t,Q_order(4));
% produce simulated trajectory
rng(7); % 1
[time_simu1,trajectory_simu1] = trajectory_simulation(d,theta,lambda,time0,delta_t,Q_order(1));
[time_simu2,trajectory_simu2] = trajectory_simulation(d,theta,lambda,time0,delta_t,Q_order(2));
[time_simu3,trajectory_simu3] = trajectory_simulation(d,theta,lambda,time0,delta_t,Q_order(3));
[time_simu4,trajectory_simu4] = trajectory_simulation(d,theta,lambda,time0,delta_t,Q_order(4));
%% smoothing
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
plot(time_simu1,trajectory_simu1,'LineWidth',1,'LineStyle','--','Color',[191, 0, 191]/255)
% plot smoothed time vs smoothed level
plot(time_simu1,trajectory_smooth1,'Color',[217, 83, 25]/255,'LineStyle','-','LineWidth',1.5)
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
plot(time_simu2,trajectory_simu2,'LineWidth',1,'LineStyle','--','Color',[191, 0, 191]/255)
% plot smoothed time vs smoothed level
plot(time_simu2,trajectory_smooth2,'Color',[217, 83, 25]/255,'LineStyle','-','LineWidth',1)
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
plot(time_simu3,trajectory_simu3,'LineWidth',1,'LineStyle','--','Color',[191, 0, 191]/255)
% plot smoothed time vs smoothed level
plot(time_simu3,trajectory_smooth3,'Color',[217, 83, 25]/255,'LineStyle','-','LineWidth',1)
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
plot(time_simu4,trajectory_simu4,'LineWidth',1,'LineStyle','--','Color',[191, 0, 191]/255)
% plot smoothed time vs smoothed level
plot(time_simu4,trajectory_smooth4,'Color',[217, 83, 25]/255,'LineStyle','-','LineWidth',1)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'(d) Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Simulated level","Smoothed level"],'location','northeast','FontSize',10,'NumColumns',1)
% save figure
% save figure
savefig(gcf,'.\figure\case2_simulation_level.fig');
exportgraphics(gcf,'.\figure\case2_simulation_level.pdf')
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
exportgraphics(gcf,'.\figure\case2_fitted_derivative.pdf')
%% level plot
figure('unit','centimeters','position',[5,5,30,20],'PaperPosition',[5,5,30,20],'PaperSize',[30,20])
tiledlayout(2,2,'Padding','Compact');
nexttile
[time_estimate1,trajectory_smooth_estimate1]=trajectory(d_estimate,theta_estimate,lambda_estimate,time0,delta_t,Q_order(1));
plot(time_true1,trajectory_true1,'LineStyle','-','LineWidth',1)
hold on
plot(time_estimate1,trajectory_smooth_estimate1,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'Order quantity Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Estimated level"],'location','northeast','FontSize',8,'NumColumns',1)
%
nexttile
[time_estimate2,trajectory_smooth_estimate2]=trajectory(d_estimate,theta_estimate,lambda_estimate,time0,delta_t,Q_order(2));
plot(time_true2,trajectory_true2,'LineStyle','-','LineWidth',1)
hold on
plot(time_estimate2,trajectory_smooth_estimate2,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'Order quantity Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Estimated level"],'location','northeast','FontSize',8,'NumColumns',1)
%
nexttile
[time_estimate3,trajectory_smooth_estimate3]=trajectory(d_estimate,theta_estimate,lambda_estimate,time0,delta_t,Q_order(3));
plot(time_true3,trajectory_true3,'LineStyle','-','LineWidth',1)
hold on
plot(time_estimate3,trajectory_smooth_estimate3,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'Order quantity Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Estimated level"],'location','northeast','FontSize',8,'NumColumns',1)
%
nexttile
[time_estimate4,trajectory_smooth_estimate4]=trajectory(d_estimate,theta_estimate,lambda_estimate,time0,delta_t,Q_order(4));
plot(time_true4,trajectory_true4,'LineStyle','-','LineWidth',1)
hold on
plot(time_estimate4,trajectory_smooth_estimate4,'LineStyle','-','LineWidth',1.5)
xlabel({'Hour'},'FontSize',14)
ylabel(['Inventory level'],'FontSize',14)
title({'Order quantity Q=360'},'FontSize',16)
set(gca,'FontName','Book Antiqua','FontSize',12) % ,'Xlim',[-0.5,7.5],'Ylim',[0,850]
legend(["Standard level","Fitted level"],'location','northeast','FontSize',8,'NumColumns',1)
% save figure
savefig(gcf,'.\figure\case2_fitted_level.fig');
exportgraphics(gcf,'.\figure\case2_fitted_level.pdf')
%%
save(".\data\parameter2.mat","d","lambda","theta","d_estimate","lambda_estimate","theta_estimate")


