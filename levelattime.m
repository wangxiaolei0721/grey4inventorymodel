function level = levelattime(theta,d,lambda,time0,time,Q)
% calculate inventory levels at a specific time
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% time0: the time of order arrival
% Q: the order quantity
% output parameter
% level: inventory level


% calculate order cycle based on order quantity
T=Q2T(theta,d,lambda,Q);
% the moment when the inventory drops to 0
tT=time0+T;
% two case
if theta == lambda
    % if theta == lambda
    level=d*exp(-theta*(time-time0)).*(tT-time);
else
    % when theta != lambda
    T=tT-time0;
    par=d/(theta-lambda);
    level=par*(exp(theta*(tT-time)-lambda*T)-exp(-lambda*(time-time0)));
end