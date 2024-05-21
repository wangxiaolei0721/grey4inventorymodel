function [time,trajectory] = trajectory(theta,d,lambda,time0,delta_t,Q)
% generate the trajectory of inventory levels
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% time0: the time of order arrival
% delta_t: the time resolution
% Q: the order quantity
% output parameter
% time: sampling time
% trajectory: inventory level


% calculate order cycle based on order quantity
T=Q2T(theta,d,lambda,Q);
% the moment when the inventory drops to 0
tT=time0+T;
% generate sampling time with time resolution as the step size
time=[time0:delta_t:tT]';
% two case
if theta == lambda
    % if theta == lambda
    trajectory=d*exp(-theta*(time-time0)).*(tT-time);
else
    % when theta != lambda
    par=d/(theta-lambda);
    trajectory=par*(exp(theta*(tT-time)-lambda*T)-exp(-lambda*(time-time0)));
end

end
