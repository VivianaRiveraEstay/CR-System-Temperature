function dY = vivi6(~,Y,P)
%% Parametros del modelo:

bmax1=P(1);
theta1=P(2);
m1=P(3);
mu0_1=P(4);
alpha1=P(5);
gamma1=P(6);
q1=P(7);
T_opt_0_1=P(8);
epsilon1=P(9);
Tmax1=P(10);
G1=P(11);


bmax2=P(12);
theta2=P(13);
m2=P(14);
mu0_2=P(15);
alpha2=P(16);
gamma2=P(17);
q2=P(18);
T_opt_0_2=P(19);
epsilon2=P(20);
Tmax2=P(21);
G2=P(22);

bmax3=P(23);
theta3=P(24);
m3=P(25);
mu0_3=P(26);
alpha3=P(27);
gamma3=P(28);
q3=P(29);
T_opt_0_3=P(30);
epsilon3=P(31);
Tmax3=P(32);
G3=P(33);

d1=P(34);
d2=P(35);
d3=P(36);
d4=P(37);
d5=P(38);
d6=P(39);



%El modelo
%% Lista de Ecuaciones
dY=zeros(9,1);
dY(1) = Y(1)*(bmax1*(exp((-(Y(3)-m1*Y(2)-T_opt_0_1)^2)/(2*theta1^2)))-(mu0_1-gamma1*Y(2))*exp(alpha1*Y(3)))-q1*Y(1)^2+d1*Y(4)-d4*Y(1);
dY(2) = (1-Y(2))*G1*(bmax1 * exp((-(Y(3)-m1*Y(2)-T_opt_0_1)^2)/(2*theta1^2))* m1*(Y(3)-m1*Y(2)-T_opt_0_1)/theta1^2 + gamma1*exp(alpha1*Y(3)));
dY(3) = epsilon1;

dY(4) = Y(4)*(bmax2*(exp((-(Y(6)-m2*Y(5)-T_opt_0_2)^2)/(2*theta2^2)))-(mu0_2-gamma2*Y(5))*exp(alpha2*Y(6)))-q2*Y(4)^2+d2*Y(7)-d1*Y(4)+d4*Y(1)-d5*Y(4);
dY(5) = (1-Y(5))*G2*(bmax2 * exp((-(Y(6)-m2*Y(5)-T_opt_0_2)^2)/(2*theta2^2))* m2*(Y(6)-m2*Y(5)-T_opt_0_2)/theta2^2 + gamma2*exp(alpha2*Y(6)));
dY(6) = epsilon2;

dY(7) = Y(7)*(bmax3*(exp((-(Y(9)-m3*Y(8)-T_opt_0_3)^2)/(2*theta3^2)))-(mu0_3-gamma3*Y(8))*exp(alpha3*Y(9)))-q3*Y(7)^2-d3*Y(7)+d6*Y(4);
dY(8) = (1-Y(8))*G3*(bmax3 * exp((-(Y(9)-m3*Y(8)-T_opt_0_3)^2)/(2*theta3^2))* m3*(Y(9)-m3*Y(8)-T_opt_0_3)/theta3^2 + gamma3*exp(alpha3*Y(9)));
dY(9) = epsilon3;

%The adaptation happens when T_{h} is bigger than T_{opt,0}

if Y(3)>T_opt_0_1
    dY(2) = (1-Y(2))*G1*(bmax1 * exp((-(Y(3)-m1*Y(2)-T_opt_0_1)^2)/(2*theta1^2))* m1*(Y(3)-m1*Y(2)-T_opt_0_1)/theta1^2 + gamma1*exp(alpha1*Y(3)));
else
    dY(2)=0;
end

if Y(6)>T_opt_0_2
    dY(5) = (1-Y(5))*G2*(bmax2 * exp((-(Y(6)-m2*Y(5)-T_opt_0_2)^2)/(2*theta2^2))* m2*(Y(6)-m2*Y(5)-T_opt_0_2)/theta2^2 + gamma2*exp(alpha2*Y(6)));
else
    dY(5)=0;
end

if Y(9)>T_opt_0_3
    dY(8) = (1-Y(8))*G3*(bmax3 * exp((-(Y(9)-m3*Y(8)-T_opt_0_3)^2)/(2*theta3^2))* m3*(Y(9)-m3*Y(8)-T_opt_0_3)/theta3^2 + gamma3*exp(alpha3*Y(9)));
else
    dY(8)=0;
end

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(3) < Tmax1
        dY(3) = epsilon1;
    else
        dY(3) = 0;
    end

 % Aplicar la condición para la variable Y(6) environmental variable
    if Y(6) < Tmax2
        dY(6) = epsilon2;
    else
        dY(6) = 0;
    end

 % Aplicar la condición para la variable Y(9) environmental variable
    if Y(9) < Tmax3
        dY(9) = epsilon3;
    else
        dY(9) = 0;
    end   