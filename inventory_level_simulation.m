function [time_simu,level_diff_simu,level_simu] = inventory_level_simulation(theta,d,lambda,t0,delta_t,Q)
% simulate the trajectory of inventory levels
% input parameter:
% theta: quantity decay rate
% d: basic demand
% lambda: quality decay rate
% t0: the time of order arrival
% delta_t: the time resolution
% Q: the order quantity
% output parameter:
% time_simu: simulated sampling time
% level_diff_simu: simulated inventory changes
% level_simu: simulated inventory level


% initial inventory data
time_simu=[];
level_diff_simu = [];
level_simu = [];
% initial inventory level
level_remain=Q;
% record t_{k-1}
time_k1=t0;
% record t_k
time_k=time_k1+delta_t;
% demand quantity
% demand = -lambda\d*(exp(-lambda.*(time_k-t0))-exp(-lambda.*(time_k1-t0)));
demand = d*(0.5*exp(-lambda.*(time_k-t0))+0.5*exp(-lambda.*(time_k1-t0)));
% deteriorating quantity
deterioration=theta*(0.5*levelattime(theta,d,lambda,t0,Q,time_k) ...
    +0.5*levelattime(theta,d,lambda,t0,Q,time_k1));
% reduction expectation
reduction_expectation = delta_t*(deterioration+demand);
% random reduction
reduction=poissrnd(reduction_expectation);
% level remain = level remain - random reduction
level_remain=level_remain-reduction;
while level_remain > 0
    % store sampling time
    time_simu=[time_simu;time_k];
    % store inventory level and changes
    level_simu=[level_simu;level_remain];
    level_diff_simu = [level_diff_simu;-reduction];
    % update t_{k-1}
    time_k1=time_k;
    % update t_{k}
    time_k=time_k+delta_t;
    % demand quantity
    demand = d*(0.5*exp(-lambda.*(time_k-t0))+0.5*exp(-lambda.*(time_k1-t0)));
    % deteriorating quantity
    deterioration=theta*(0.5*levelattime(theta,d,lambda,t0,Q,time_k) ...
        +0.5*levelattime(theta,d,lambda,t0,Q,time_k1));
    % reduction expectation
    reduction_expectation = delta_t*(deterioration+demand);
    % random reduction
    reduction=poissrnd(reduction_expectation);
    % level remain = level remain - random reduction
    level_remain=level_remain-reduction;
end


end

