function dY = vivi3(~,Y,P)
%% Parametros del modelo:

rmax=P(1);
theta=P(2);
m=P(3);
K=P(4);
T_opt_0=P(5);
epsilon=P(6);
Tmax=P(7);
G=P(8);

%El modelo
%% Lista de Ecuaciones
dY=zeros(3,1);
dY(1) = Y(1)*(1-Y(1)/K)*rmax*(exp((-(Y(3)-m*Y(2)-T_opt_0)^2)/(2*theta^2)));
dY(2) = G*(1-Y(1)/K)*rmax * exp((-(Y(3)-m*Y(2)-T_opt_0)^2)/(2*theta^2))* m*(Y(3)-m*Y(2)-T_opt_0)/theta^2;
dY(3) = epsilon;

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(3) < Tmax
        dY(3) = epsilon;
    else
        dY(3) = 0;
    end

