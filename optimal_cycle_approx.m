function T = optimal_cycle_approx(d,theta,lambda,p,c,h,A)
% compute profit
% input parameter:
% d: basic demand
% theta: quantity deteriorating rate
% lambda: quality decay rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% A: ordering cost per cycle
% output parameter:
% T: optimal order cycles


% two case
if theta == lambda
    T = sqrt(2*A/(d*(p*lambda+h)));
else
    T = sqrt(2*A/(d*((c*theta+h)+lambda*(p-c))));
end

end

