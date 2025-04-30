function dY = vivi5(~,Y,P)
%% Parametros del modelo:

bmax=P(1);
theta=P(2);
m=P(3);
mu0=P(4);
alpha=P(5);
gamma=P(6);
q=P(7);
T_opt_0=P(8);
epsilon=P(9);
Tmax=P(10);
G=P(11);




%El modelo
%% Lista de Ecuaciones
dY=zeros(3,1);
dY(1) = Y(1)*(bmax*(exp((-(Y(3)-m*Y(2)-T_opt_0)^2)/(2*theta^2)))-(mu0-gamma*Y(2))*exp(alpha*Y(3)))-q*Y(1)^2;
dY(2) = (1-Y(2))*G*(bmax * exp((-(Y(3)-m*Y(2)-T_opt_0)^2)/(2*theta^2))* m*(Y(3)-m*Y(2)-T_opt_0)/theta^2 + gamma*exp(alpha*Y(3)));
dY(3) = epsilon;

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(3) < Tmax
        dY(3) = epsilon;
    else
        dY(3) = 0;
    end

