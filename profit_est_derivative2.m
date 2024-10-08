function profit_est_appro_der2 = profit_est_derivative2(T)
%PROFIT_EST_DERIVATIVE2
%    PROFIT_EST_APPRO_DER2 = PROFIT_EST_DERIVATIVE2(T)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2024-09-28 23:22:12

t2 = 1.0./T.^3;
t3 = T.*7.485687543625216e-2;
t4 = -t3;
t5 = exp(t4);
et1 = t2.*-2.0e+2-t2.*(t5.*5.984525432619786e+3-5.984525432619786e+3).*2.0-(t5.*3.35345982605726e+1)./T;
et2 = 1.0./T.^2.*t5.*(-8.959657497094047e+2);
profit_est_appro_der2 = et1+et2;
end
