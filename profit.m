function profit = profit(lambda,d,p,c,h,K,T)
% profit function
% input parameter:
% lambda: decay rate
% d: basic demand
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% K: ordering cost per cycle
% T: order cycle
% output parameter:
% profit: total profits at T


% if theta == lambda
par1=d*(p*lambda+h)/(lambda^2);
par2=d*(c*lambda+h)/lambda;
profit=par1*(1-exp(-lambda*T))./T-par2-K./T;


end
