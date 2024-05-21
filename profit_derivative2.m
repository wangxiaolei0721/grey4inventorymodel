function derivative2 = profit_derivative2(theta,d,lambda,p,c,h,T)
% calculate the second derivative of profit with respect to order cycle
% input parameter:
% theta: deteriorating rate
% d: initial demand
% lambda: a parameter governing the decreasing rate of the demand
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% T: order cycles
% output parameter:
% profit: second derivatives of profit at T


% p*theta+h
par1= p*theta+h;
% c*theta+h
par2=c*theta+h;
% two case
if theta == lambda
    % if theta == lambda    
    derivative2=-d*par1;
else
    % when theta != lambda
    derivative2=d/theta*(par1*-lambda*exp(-lambda*T)-par2*(theta-lambda)*exp((theta-lambda)*T));
end

