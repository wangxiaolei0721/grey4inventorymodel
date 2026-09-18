function T = optimal_cycle(lambda,d,p,h,K,T_interval)
% compute optimal cycle
% input parameter:
% lambda: decay rate
% d: basic demand
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% K: ordering cost per cycle
% T_interval: interval of T
% output parameter:
% T: optimal order cycle


syms T;
par=d*(p*lambda+h);
eqn = par*(lambda*T+1)*exp(-lambda.*T) == par-K*lambda^2;
T=vpasolve(eqn,T,T_interval);

end

