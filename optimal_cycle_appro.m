function T = optimal_cycle_appro(theta,d,lambda,p,c,h,A)
% compute optimal cycle
% input parameter:
% theta: quantity decay rate
% d: basic demand
% lambda: quality decay rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% A: ordering cost per cycle
% output parameter:
% T: optimal order cycle


% two case
if theta == lambda
    T = sqrt(2*A/(d*(p*lambda+h)));
else
    T = sqrt(2*A/(d*((c*theta+h)+lambda*(p-c))));
end

end

