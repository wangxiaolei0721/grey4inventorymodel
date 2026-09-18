function level = levelattime(lambda,d,t0,Q,time)
% calculate inventory levels at a specific time
% input parameter:
% lambda: decay rate
% d: basic demand
% t0: the time of order arrival
% Q: the order quantity
% time: the time to be evaluated
% output parameter
% level: inventory level


% calculate order cycle based on order quantity
T=Q/d;
% the moment when the inventory drops to 0
tT=t0+T;
level=d*exp(-lambda*(time-t0)).*(tT-time);
end

