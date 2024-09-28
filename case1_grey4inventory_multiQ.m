% clear data and figure
clc;
clear;
close all;
%% model setting
% equation parameter
theta=0.08;
d=50;
lambda=0.08;
% lambdaeqtheta:lambda=theta, 1 is TRUE, 0 is FALSE
lambdaeqtheta=1;
% produce simulated trajectory
rng(0); % 1 2 5
% the order quantity
Q_vector=360+randi([0,120],10,1);
% the time of order arrival
t0=0;
% the time resolution
delta_t=1;
% order cycles
m=length(Q_vector);
%% initialization of data storage
time_true = {};
time_true_t0 = {};
level_diff_true = {};
level_true = {};
time_simu = {};
time_simu_t0 = {};
level_diff_simu = {};
level_simu = {};
% generate the inventory levels
for i = 1:m
    % true level
    [time_true_i,level_diff_true_i,level_true_i] = inventory_level(theta,d,lambda,t0,delta_t,Q_vector(i));
    time_true{i}=time_true_i;
    level_diff_true{i}=level_diff_true_i;
    time_true_t0{i}=[t0;time_true_i];
    level_true{i}=[Q_vector(i);level_true_i];
    % simulated level
    [time_simu_i,level_diff_simu_i,level_simu_i] = inventory_level_simulation(theta,d,lambda,t0,delta_t,Q_vector(i));
    time_simu{i} = time_simu_i;
    level_diff_simu{i}=level_diff_simu_i;
    time_simu_t0{i}=[t0;time_simu_i];
    % level_simu{i}=[Q_vector(i);level_simu_i];
end
%% cumulative generation
for i = 1:m
    time_i=time_simu_t0{i};
    time_i_diff=diff(time_i);
    level_diff_i=level_diff_simu{i};
    level_simu_i = [Q_vector(i);Q_vector(i) + cumsum(level_diff_i.*time_i_diff)];
    level_simu{i}=level_simu_i;
end
%% estimation
train_length = 0.8 * m;
% simulated time 1,2,3 for parameter estimation
time_train=time_simu(1:train_length);
level_diff_train=level_diff_simu(1:train_length);
level_train=level_simu(1:train_length);
Q_vector_train = Q_vector(1:train_length);
%% estimation
% initial lambda
lambda_initial=0;
% lsqnonlin function setting
opt_options=optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','MaxFunctionEvaluations',100,'FunctionTolerance',1e-8,'StepTolerance',1e-6);
% residual function of lambda under multiple orders
minobjfun = @(lambda) lambda_residual_multiQ(t0,time_train,level_diff_train,level_train,lambdaeqtheta,lambda);
% lambda optimazation
lambda_estimate= lsqnonlin(minobjfun,lambda_initial,0,0.2,opt_options);
estimate = lambda2par(t0,time_train,level_diff_train,level_train,lambdaeqtheta,lambda_estimate);
if lambdaeqtheta
    theta_estimate=lambda_estimate;
    d_estimate=estimate;
else
    theta_estimate=estimate(1);
    d_estimate=estimate(2);
end
%% fit level
time_fit = {};
level_fit = {};
level_diff_fit = {};
for i = 1:m
    [time_fit_i,level_diff_fit_i,level_fit_i] = inventory_level(theta_estimate,d_estimate,lambda_estimate,t0,delta_t,Q_vector(i));
    time_fit{i}=time_fit_i;
    level_diff_fit{i}=level_diff_fit_i;
    time_fit_t0{i}=[t0;time_fit_i];
    level_fit{i}=[Q_vector(i);level_fit_i];
end
%% plot
% plot time vs level
finvertorydiff=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
tiledlayout(2,m/2,'Padding','Compact');
%
finvertory=figure('unit','centimeters','position',[5,5,40,20],'PaperPosition',[5,5,40,20],'PaperSize',[40,20]);
tiledlayout(2,m/2,'Padding','Compact');
for i = 1:m
    figure(finvertorydiff)
    nexttile
    plot(time_true{i},level_diff_true{i},'LineWidth',1)
    hold on
    plot(time_simu{i},level_diff_simu{i},'LineWidth',1)
    plot(time_fit{i},level_diff_fit{i},'LineWidth',1)
    xlabel({'Day'},'FontSize',12)
    ylabel(['Inventory change'],'FontSize',12)
    title(strcat("(",char(96 + i),") The ", num2str(i),"-th ordering cycle"),'FontSize',14)
    set(gca,'FontName','Book Antiqua','FontSize',10)
    if i==10
        legend(["Standard inventory changes","Simulated inventory changes","Fitted inventory changes"],'location','northeast','FontSize',8,'NumColumns',1)
    end
    figure(finvertory)
    nexttile
    plot(time_true_t0{i},level_true{i},'LineWidth',1)
    hold on
    plot(time_simu_t0{i},level_simu{i},'LineWidth',1)
    plot(time_fit_t0{i},level_fit{i},'LineWidth',1)
    xlabel({'Day'},'FontSize',12)
    ylabel(['Inventory level'],'FontSize',12)
    title(strcat("(",char(96 + i),") The ", num2str(i),"-th ordering cycle"),'FontSize',14)
    set(gca,'FontName','Book Antiqua','FontSize',10)
    if i==10
        legend(["Standard inventory level","Simulated inventory level"],'location','northeast','FontSize',8,'NumColumns',1) % ,"Fitted inventory level"
    end
end
save(".\data\case1_estimates.mat","theta","d","lambda","theta_estimate","d_estimate","lambda_estimate")


% save figure
savefig(finvertorydiff,'.\figure\case1_level_diff.fig')
exportgraphics(finvertorydiff,'.\figure\case1_level_diff.pdf')
savefig(finvertory,'.\figure\case1_level.fig')
exportgraphics(finvertory,'.\figure\case1_level.pdf')

