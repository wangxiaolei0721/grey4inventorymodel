function profit = profit_appro(lambda,d,p,c,h,K,T)
% compute approximate profit
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



profit=d*(p-c)-d*(p*lambda+h).*T/2-K./T;

end

