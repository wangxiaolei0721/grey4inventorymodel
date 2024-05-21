function T = optimal_cycle(theta,p,c,h)
% compute profit
% input parameter:
% theta: deteriorating rate
% p: sales price
% c: production cost
% h: holding cost per unit per unit of time
% output parameter:
% T: optimal order cycles


T = log((p*theta+h)/(c*theta+h))/theta;

end

