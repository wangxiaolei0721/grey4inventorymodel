function T = Q2T(theta,d,lambda,Q)
% Q to T: from order quantity to order cycle
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% Q: the order quantity
% output parameter:
% T: order cycle


% two case
if theta == lambda
    % if theta == lambda
    T=Q/d;
else
    % when theta != lambda
    par=theta-lambda;
    par2=log(Q*par/d+1);
    T=par2/par;
end

