function profit_der1 = profit_derivative1(T)
%PROFIT_DERIVATIVE1
%    PROFIT_DER1 = PROFIT_DERIVATIVE1(T)

%    This function was generated by the Symbolic Math Toolbox version 9.3.
%    2024-09-19 09:15:07

t2 = 1.0./T;
t4 = T./5.0e+1;
t6 = T.*(3.0./1.0e+2);
t3 = t2.^2;
t5 = -t4;
t8 = -t6;
t7 = exp(t5);
t9 = exp(t8);
profit_der1 = t3.*1.0e+2+t3.*(t9.*3.2e+3-3.2e+3)-t3.*(t7.*3.6e+3-3.6e+3)-t2.*t7.*7.2e+1+t2.*t9.*9.6e+1;
end
