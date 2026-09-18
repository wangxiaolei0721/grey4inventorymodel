function T = optimal_cycle_appro(lambda,d,p,c,h,K)
% compute optimal cycle
% input parameter:
% theta: quantity decay rate
% d: basic demand
% lambda: quality decay rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% K: ordering cost per cycle
% output parameter:
% T: optimal order cycle



T = sqrt(2*K/(d*(p*lambda+h)));


end

