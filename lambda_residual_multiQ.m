function residual = lambda_residual_multiQ(t0,time_train,level_diff_train,level_train,lambda)
% residual function of lambda under multiple orders
% input parameter:
% t0: the time of order arrival
% time_train: the sample time
% Q_vector_train: order quantity vector
% level_diff_train: level changes
% lambda: decay rate
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
    E=[E;E_i];
end
% X: vector of dependent variable
Y=l + 2\lambda*(L_j1+L_j).*delta_T;
% data matrix for parameter estimation
H_lambda=-2\E.*delta_T;
% estimates
d_estimation = (H_lambda'*H_lambda)\H_lambda'*Y;
% estimate of first derivative
level_diff_estimation=H_lambda*d_estimation;
% computing residual
residual=Y-level_diff_estimation;
end

