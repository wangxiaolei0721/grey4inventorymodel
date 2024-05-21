function Q = T2Q(theta,d,lambda,T)
% T to Q: from order cycle to order quantity
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% T: order cycle
% output parameter:
% Q: the order quantity


% two case
if theta == lambda
    % if theta == lambda
    Q=d*T;
else
    % when theta != lambda
    par=d/(theta-lambda);
    Q=par*(exp((theta-lambda)*T)-1);
end

