function dY = vivi2(~,Y,P)
%% Parametros del modelo:

bmax1=P(1);
bmax2=P(2);
tau1=P(3);
tau2=P(4);
sigma2_1=P(5);
sigma2_2=P(6);
K1=P(7);
K2=P(8);
mu0_1=P(9);
mu0_2=P(10);
mu1_1=P(11);
mu1_2=P(12);
a1=P(13);
a2=P(14);
epsilon=P(15);
Emax=P(16);
d1=P(17);

%El modelo
%% Lista de Ecuaciones
dY=zeros(5,1);
dY(1) = Y(1)*((((bmax1*tau1)/((sigma2_1+tau1^(2))^(1/2)))*exp((-(Y(5)-Y(3))^(2))/(2*(sigma2_1+tau1^(2)))))*(1-Y(1)/K1)- (mu0_1+mu1_1*(sigma2_1+Y(3)^(2))));
dY(2) = Y(2)*((((bmax2*tau2)/((sigma2_2+tau2^(2))^(1/2)))*exp((-(Y(5)-Y(4))^(2))/(2*(sigma2_2+tau2^(2)))))*(1-Y(2)/K2)- (mu0_2+mu1_2*(sigma2_2+Y(4)^(2))));
dY(3) = sigma2_1*(((Y(5)-Y(3))/(sigma2_1+tau1^(2)))*((((bmax1*tau1)/(sigma2_1+tau1^(2))^(1/2))*exp((-(Y(5)-Y(3))^(2))/(2*(sigma2_1+tau1^(2)))))*(1-(Y(1)/K1))- 2*mu1_1*Y(3)));
dY(4) = sigma2_2*(((Y(5)-Y(4))/(sigma2_2+tau2^(2)))*((((bmax2*tau2)/(sigma2_2+tau2^(2))^(1/2))*exp((-(Y(5)-Y(4))^(2))/(2*(sigma2_2+tau2^(2)))))*(1-(Y(2)/K2))- 2*mu1_2*Y(4)));
dY(5) = epsilon;

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(5) < Emax
        dY(5) = epsilon;
    else
        dY(5) = 0;
    end

     % Aplicar la condición para
    if Y(2) < 0.3 && Y(1)<2 
        dY(1) = Y(1)*((((bmax1*tau1)/((sigma2_1+tau1^(2))^(1/2)))*exp((-(Y(5)-Y(3))^(2))/(2*(sigma2_1+tau1^(2)))))*(1-Y(1)/K1)- (mu0_1+mu1_1*(sigma2_1+Y(3)^(2)))-d1); 
        dY(2) = Y(2)*((((bmax2*tau2)/((sigma2_2+tau2^(2))^(1/2)))*exp((-(Y(5)-Y(4))^(2))/(2*(sigma2_2+tau2^(2)))))*(1-Y(2)/K2)- (mu0_2+mu1_2*(sigma2_2+Y(4)^(2))))+d1*Y(1);
   
    else
        dY(1) = Y(1)*((((bmax1*tau1)/((sigma2_1+tau1^(2))^(1/2)))*exp((-(Y(5)-Y(3))^(2))/(2*(sigma2_1+tau1^(2)))))*(1-Y(1)/K1)- (mu0_1+mu1_1*(sigma2_1+Y(3)^(2))));
        dY(2) = Y(2)*((((bmax2*tau2)/((sigma2_2+tau2^(2))^(1/2)))*exp((-(Y(5)-Y(4))^(2))/(2*(sigma2_2+tau2^(2)))))*(1-Y(2)/K2)- (mu0_2+mu1_2*(sigma2_2+Y(4)^(2))));
    end

end



