function level = levelattime(theta,d,lambda,t0,Q,time)
% calculate inventory levels at a specific time
% input parameter:
% theta: quantity decay rate
% d: basic demand
% lambda: quality decay rate
% t0: the time of order arrival
% Q: the order quantity
% time: the time to be evaluated
% output parameter
% level: inventory level


% calculate order cycle based on order quantity
T=Q2T(theta,d,lambda,Q);
% the moment when the inventory drops to 0
tT=t0+T;
% two case
if theta == lambda
    % if theta == lambda
    level=d*exp(-lambda*(time-t0)).*(tT-time);
else
    % when theta != lambda
    T=tT-t0;
    par=d/(theta-lambda);
    level=par*(exp(theta*(tT-time)-lambda*T)-exp(-lambda*(time-t0)));
end

