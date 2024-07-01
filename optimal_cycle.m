function T = optimal_cycle(d,theta,lambda,p,c,h,A,T_interval)
% compute profit
% input parameter:
% d: basic demand
% theta: quantity deteriorating rate
% lambda: quality decay rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% A: ordering cost per cycle
% T_interval: interval of T
% output parameter:
% T: optimal order cycles


syms T;
% two case
if theta == lambda
    par=d*(p*lambda+h);
    eqn = par*(lambda*T+1)*exp(-lambda.*T) == par-A*lambda^2;
    T=vpasolve(eqn,T,T_interval);
else
    par1=d*(p*theta+h)*(theta-lambda);
    par2=d*(c*theta+h)*lambda;
    par3=lambda*theta*(theta-lambda);
    eqn=par1*(lambda.*T+1)*exp(-lambda.*T)-par2*((theta-lambda).*T-1)*exp((theta-lambda).*T)==par1+par2-A*par3;
    T=vpasolve(eqn,T,T_interval);
end

end

