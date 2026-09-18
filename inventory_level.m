function [time,level_diff,level] = inventory_level(lambda,d,t0,delta_t,Q)
% generate the inventory levels
% input parameter:
% lambda: decay rate
% d: basic demand
% t0: the time of order arrival
% delta_t: the time resolution
% Q: the order quantity
% output parameter
% time: simulated sampling time
% level_diff_simu: simulated inventory changes
% level_simu: simulated inventory level


% calculate order cycle based on order quantity
T=Q/d;
% the moment when the inventory drops to 0
tT=t0+T;
% generate sampling time with time resolution as the step size
time=[(t0+delta_t):delta_t:tT]';
level=d*exp(-lambda.*(time-t0)).*(tT-time);
% inventory changes
level_diff=diff([Q;level]);


end
