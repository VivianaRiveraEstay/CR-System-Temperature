function dY = vivi4(~,Y,P)
%% Parametros del modelo:

rmax1=P(1);
theta1=P(2);
m1=P(3);
K1=P(4);
T_opt1_0=P(5);
epsilon1=P(6);
Tmax1=P(7);
G1=P(8);
d1=P(9);

rmax2=P(10);
theta2=P(11);
m2=P(12);
K2=P(13);
T_opt2_0=P(14);
epsilon2=P(15);
Tmax2=P(16);
G2=P(17);
d2=P(18);

rmax3=P(19);
theta3=P(20);
m3=P(21);
K3=P(22);
T_opt3_0=P(23);
epsilon3=P(24);
Tmax3=P(25);
G3=P(26);
d3=P(27);

%El modelo
%% Lista de Ecuaciones
dY=zeros(9,1);
dY(1) = Y(1)*rmax1*(exp((-(Y(3)-m1*Y(2)-T_opt1_0)^2)/(2*theta1^2)))*(1-Y(1)/K1)-d1*Y(1);
dY(2) = G1*(1-Y(1)/K1)*rmax1 * exp((-(Y(3)-m1*Y(2)-T_opt1_0)^2)/(2*theta1^2))* m1*(Y(3)-m1*Y(2)-T_opt1_0)/theta1^2;
dY(3) = epsilon1;

dY(4) = Y(4)*rmax2*(exp((-(Y(6)-m2*Y(5)-T_opt2_0)^2)/(2*theta2^2)))*(1-Y(4)/K2)+d1*Y(1)-d2*Y(4)+d3*Y(7);
dY(5) = G2*(1-Y(4)/K2)*rmax2 * exp((-(Y(6)-m2*Y(5)-T_opt2_0)^2)/(2*theta2^2))* m2*(Y(6)-m2*Y(5)-T_opt2_0)/theta2^2;
dY(6) = epsilon2;

dY(7) = Y(7)*rmax3*(exp((-(Y(9)-m3*Y(8)-T_opt3_0)^2)/(2*theta3^2)))*(1-Y(7)/K3)+d2*Y(4)-d3*Y(7);
dY(8) = G3*(1-Y(7)/K3)*rmax3 * exp((-(Y(9)-m3*Y(8)-T_opt3_0)^2)/(2*theta3^2))* m3*(Y(9)-m3*Y(8)-T_opt3_0)/theta3^2;
dY(9) = epsilon3;

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(3) < Tmax1
        dY(3) = epsilon1;
    else
        dY(3) = 0;
    end

    % Aplicar la condición para la variable Y(3) environmental variable
    if Y(6) < Tmax2
        dY(6) = epsilon2;
    else
        dY(6) = 0;
    end

    % Aplicar la condición para la variable Y(3) environmental variable
    if Y(9) < Tmax3
        dY(9) = epsilon3;
    else
        dY(9) = 0;
    end
