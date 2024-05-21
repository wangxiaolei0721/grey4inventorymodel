function profit = profit(theta,d,lambda,p,c,h,T)
% compute profit
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% T: order cycles
% output parameter:
% profit: total profits at T 


% -d(p*theta +h)/(lambda*theta)
par1= -d*(p*theta+h)/(lambda*theta);
% -d*(c*theta+h)/theta;
par2=-d*(c*theta+h)/theta;
% two case
if theta == lambda
    % if theta == lambda
    profit=par1*(exp(-lambda*T)-1)+par2*T;
else
    % when theta != lambda
    profit=par1*(exp(-lambda*T)-1)+par2/(theta-lambda)*(exp((theta-lambda)*T)-1);
end

