function [time_simu,trajectory_simu] = trajectory_simulation(d,theta,lambda,time0,delta_t,Q)
% simulate the trajectory of inventory levels
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% time0: the time of order arrival
% delta_t: the time resolution
% Q: the order quantity
% output parameter:
% time_simu: simulated sampling time
% trajectory_simu: simulated inventory level


% initial inventory trajectory
trajectory_simu = Q;
% initial inventory level
level_remain=Q;
% initial time
time_simu=time0;
% record t_{k-1}
time_k1=time0;
% record t_k
time_k=time_k1+delta_t;
% demand quantity
demand = 0.5*d*exp(-lambda*(time_k-time0))+0.5*d*exp(-lambda*(time_k1-time0));
% deteriorating quantity
deterioration=theta*(0.5*levelattime(d,theta,lambda,time0,time_k,Q) ...
    +0.5*levelattime(d,theta,lambda,time0,time_k1,Q));
% reduction expectation
reduction_expectation = delta_t*(deterioration+demand);
% random reduction
reduction=poissrnd(reduction_expectation);
% level remain = level remain - random reduction
level_remain=level_remain-reduction;
% update t_{k-1}
time_k1=time_k;
% update t_{k}
time_k=time_k+delta_t;
while level_remain > 0
    % store sampling time
    time_simu=[time_simu;time_k1];
    % store inventory level
    trajectory_simu=[trajectory_simu;level_remain];
    % demand quantity
    demand = 0.5*d*exp(-lambda*(time_k-time0))+0.5*d*exp(-lambda*(time_k1-time0));
    % deteriorating quantity
    deterioration=theta*(0.5*levelattime(d,theta,lambda,time0,time_k,Q) ...
    +0.5*levelattime(d,theta,lambda,time0,time_k1,Q));
    % reduction expectation
    reduction_expectation = delta_t*(deterioration+demand);
    % random reduction
    reduction=poissrnd(reduction_expectation);
    % level remain = level remain - random reduction
    level_remain=level_remain-reduction;
    % update t_{k-1}
    time_k1=time_k;
    % update t_{k}
    time_k=time_k+delta_t;
end

end

