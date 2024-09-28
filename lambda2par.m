function estimation = lambda2par(t0,time_train,level_diff_train,level_train,lambdaeqtheta,lambda)
% calculate the initial values of alpha and beta based on theta
% input parameter:
% t0: the time of order arrival
% time_train: the sample time
% Q_vector_train: order quantity vector
% level_diff_train: level changes
% lambdaeqtheta:lambda=theta, 1 is TRUE, 0 is FALSE
% lambda: quality decay rate
% output parameter
% residual: residual vector of derivative


cell_length=length(time_train);
l=[];
L_j1=[];
L_j=[];
delta_T=[];
E=[];
for i = 1:cell_length
    time_i=[t0;time_train{i}];
    time_i_j1=time_i(1:end-1);
    time_i_j=time_i(2:end);
    time_i_diff=diff(time_i);
    delta_T=[delta_T;time_i_diff];
    level_diff_i=level_diff_train{i};
    l=[l;level_diff_i];
    level_i=level_train{i};
    L_j1=[L_j1;level_i(1:end-1)];
    L_j=[L_j;level_i(2:end)];
    % demand term
    E_i=exp(-lambda.*(time_i_j-t0))+exp(-lambda.*(time_i_j1-t0));
    % E_i=lambda\(exp(-lambda.*(time_i_j-t0))-exp(-lambda.*(time_i_j1-t0)));
    E=[E;E_i];
end
if lambdaeqtheta
    % X: vector of dependent variable
    Y=l + 2\lambda*(L_j1+L_j).*delta_T;
    % data matrix for parameter estimation
    H_lambda=-2\E.*delta_T;
    % H_lambda=E;
    % estimates
    estimation = (H_lambda'*H_lambda)\H_lambda'*Y;
else
    % X: vector of dependent variable
    Y=l;
    % data matrix for parameter estimation
    H_lambda=[-2\(L_j1+L_j).*delta_T,-2\E.*delta_T];
    % H_lambda=[-2\(L_j1+L_j).*delta_T,E];
    % estimates
    estimation = (H_lambda'*H_lambda)\H_lambda'*Y;
end

end

