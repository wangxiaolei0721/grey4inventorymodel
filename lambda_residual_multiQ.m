function residual = lambda_residual_multiQ(time0,time,trajectory_smooth,trajectory_derivative_smooth,lambdaeqtheta,lambda)
% residual function of lambda under multiple orders
% input parameter:
% time0: the time of order arrival
% trajectory_smooth: smoothed trajectory
% trajectory_derivative_smooth: first derivative of smoothed trajectory
% lambda: a parameter governing the decreasing rate of the demand
% lambdaeqtheta:lambda=theta, 1 is TRUE, 0 is FALSE
% output parameter
% residual: residual vector of derivative


% demand vector 1
demand_vector1=exp(-lambda*(time{1}-time0));
demand_vector2=exp(-lambda*(time{2}-time0));
demand_vector3=exp(-lambda*(time{3}-time0));
% merged demand vector
demand_vector=[demand_vector1;demand_vector2;demand_vector3];
% merged smooth trajectory
trajectory_smooth=[trajectory_smooth{1};trajectory_smooth{2};trajectory_smooth{3}];
% merged first derivative
trajectory_derivative_smooth=[trajectory_derivative_smooth{1};trajectory_derivative_smooth{2};trajectory_derivative_smooth{3}];
if lambdaeqtheta
    % X: vector of dependent variable
    X=trajectory_derivative_smooth + lambda*trajectory_smooth;
    % data matrix for parameter estimation
    H_lambda=-demand_vector;
    % estimates
    d_estimation = (H_lambda'*H_lambda)\H_lambda'*X;
    % estimate of first derivative
    trajectory_derivative_estimation=H_lambda*d_estimation;
    % computing residual
    residual=X-trajectory_derivative_estimation;
else
    % X: vector of dependent variable
    X=trajectory_derivative_smooth;
    % data matrix for parameter estimation
    H_lambda=-[trajectory_smooth,demand_vector];
    % estimates
    d_estimation = (H_lambda'*H_lambda)\H_lambda'*X;
    % estimate of first derivative
    trajectory_derivative_estimation=H_lambda*d_estimation;
    % computing residual
    residual=X-trajectory_derivative_estimation;
end
end

