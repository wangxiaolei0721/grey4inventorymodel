% clear data and figure
clc;
clear;
close all;
%% model setting
% equation parameter
lambda=0.08;
d=50;
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
    [time_true_i,level_diff_true_i,level_true_i] = inventory_level(lambda,d,t0,delta_t,Q_vector(i));
    time_true{i}=time_true_i;
    level_diff_true{i}=level_diff_true_i;
    time_true_t0{i}=[t0;time_true_i];
    level_true{i}=[Q_vector(i);level_true_i];
    % simulated level
    [time_simu_i,level_diff_simu_i,level_simu_i] = inventory_level_simulation(lambda,d,t0,delta_t,Q_vector(i));
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
minobjfun = @(lambda) lambda_residual_multiQ(t0,time_train,level_diff_train,level_train,lambda);
% lambda optimazation
lambda_estimate= lsqnonlin(minobjfun,lambda_initial,0,0.2,opt_options);
d_estimate = lambda2par(t0,time_train,level_diff_train,level_train,lambda_estimate);
%% fit level
time_fit = {};
time_fit_t0 = {};
level_fit = {};
level_diff_fit = {};
for i = 1:m
    [time_fit_i,level_diff_fit_i,level_fit_i] = inventory_level(lambda_estimate,d_estimate,t0,delta_t,Q_vector(i));
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
    plot(time_true{i},level_diff_true{i},'LineWidth',1.5,'Marker','o','MarkerSize',6)
    hold on
    plot(time_simu{i},level_diff_simu{i},'LineWidth',1.5,'Marker','^','MarkerSize',6)
    plot(time_fit{i},level_diff_fit{i},'LineWidth',1.5,'Marker','square','MarkerSize',6)
    xlabel({'Day'},'FontSize',12)
    ylabel(['Inventory change'],'FontSize',12)
    title(strcat("(",char(96 + i),") ","Ordering cycle ",num2str(i)),'FontSize',14)
    set(gca,'FontSize',12)
    if i==7
        legend(["Standard inventory changes","Simulated inventory changes","Fitted inventory changes"],'location','northwest','FontSize',8,'NumColumns',1)
    end
    figure(finvertory)
    nexttile
    plot(time_true_t0{i},level_true{i},'LineWidth',1.5,'Marker','o','MarkerSize',6)
    hold on
    plot(time_simu_t0{i},level_simu{i},'LineWidth',1.5,'Marker','^','MarkerSize',6)
    xlabel({'Day'},'FontSize',12)
    ylabel(['Inventory level'],'FontSize',12)
    title(strcat("(",char(96 + i),") ","Ordering cycle ",num2str(i)),'FontSize',14)
    set(gca,'FontSize',12)
    if i==8
        legend(["Standard inventory level","Simulated inventory level"],'location','northeast','FontSize',10,'NumColumns',1) % ,"Fitted inventory level"
    end
end
save(".\data\case_estimates.mat","lambda","d","lambda_estimate","d_estimate")

% save figure
savefig(finvertorydiff,'.\figure\case_level_diff.fig')
exportgraphics(finvertorydiff,'.\figure\case_level_diff.pdf')
savefig(finvertory,'.\figure\case_level.fig')
exportgraphics(finvertory,'.\figure\case_level.pdf')

