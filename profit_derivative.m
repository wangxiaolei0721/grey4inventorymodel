function derivative = profit_derivative(theta,d,lambda,p,c,h,T)
% calculate the first derivative of profit with respect to order cycle
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% T: order cycles
% output parameter:
% profit: first derivatives of profit at T


% d*(p*theta+h)/theta
par1= d*(p*theta+h)/theta;
% d*(c*theta+h)/theta
par2=d*(c*theta+h)/theta;
% two case
if theta == lambda
    % if theta == lambda
    derivative=par1*exp(-lambda*T)-par2;
else
    % when theta != lambda
    derivative=par1*exp(-lambda*T)-par2*exp((theta-lambda)*T);
end

