function dY = vivi(~,Y,P)
%% Parametros del modelo:

bmax=P(1);
tau=P(2);
sigma2=P(3);
K=P(4);
mu0=P(5);
mu1=P(6);
A=P(7);
epsilon=P(8);
Emax=P(9);

%El modelo
%% Lista de Ecuaciones
dY=zeros(3,1);
dY(1) = Y(1)*((((bmax*tau)/((sigma2+tau^(2))^(1/2)))*exp((-(Y(3)-Y(2))^(2))/(2*(sigma2+tau^(2)))))*(1-Y(1)/K)*(Y(1)-A)- (mu0+mu1*(sigma2+Y(2)^(2))));
dY(2) = sigma2*(((Y(3)-Y(2))/(sigma2+tau^(2)))*((((bmax*tau)/(sigma2+tau^(2))^(1/2))*exp((-(Y(3)-Y(2))^(2))/(2*(sigma2+tau^(2)))))*(1-(Y(1)/K))*(Y(1)-A))- 2*mu1*Y(2));
dY(3) = epsilon;

 % Aplicar la condición para la variable Y(3) environmental variable
    if Y(3) < Emax
        dY(3) = epsilon;
    else
        dY(3) = 0;
    end

    

end



