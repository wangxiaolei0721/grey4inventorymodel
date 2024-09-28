function profit = profit_appro(theta,d,lambda,p,c,h,A,T)
% compute approximate profit
% input parameter:
% theta: quantity decay rate
% d: basic demand
% lambda: quality decay rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% A: ordering cost per cycle
% T: order cycle
% output parameter:
% profit: total profits at T


% two case
if theta == lambda
    % if theta == lambda
    profit=d*(p-c)-d*(p*lambda+h).*T/2-A./T;
else
    % when theta != lambda
    par=d*((c*theta+h)+lambda*(p-c));
    profit=d*(p-c)-par.*T/2-A./T;
end

end

