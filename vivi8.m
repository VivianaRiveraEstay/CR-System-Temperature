function dY = vivi8(~,Y,P)


bmax=P(1);
theta=P(2);
m0=P(3);
alpha=P(4);
gamma=P(5);
c=P(6);
Topt_x_0=P(7);
mu=P(8);
epsilon=P(9);
Gx=P(10);

amax=P(11);
phi=P(12);
h_opt=P(13);
p=P(14);
q0=P(15);
delta=P(16);
beta=P(17);
sigma=P(18);
Topt_y_0=P(19);
eta=P(20);
Gy=P(21);


b=bmax*exp((-(Y(5)-(mu*Y(2)+Topt_x_0))^2)/(2*theta^2));
b_u=b*mu*(Y(5)-(mu*Y(2)+Topt_x_0))/theta^2;
m=(m0-gamma*Y(2))*exp(alpha*Y(5));
m_u=-gamma*exp(alpha*Y(5));
a=amax*exp((-(Y(5)-(eta*Y(4)+Topt_y_0))^2)/(2*sigma^2));
h=phi*(Y(5)-(eta*Y(4)+Topt_y_0))^2+h_opt;
q=(q0-delta*Y(4))*exp(beta*Y(5));
F=Y(1)*a/(1+a*h*Y(1));
a_v=amax*(exp((-(Y(5)-(eta*Y(4)+Topt_y_0))^2)/(2*sigma^2)))*eta*(Y(5)-(eta*Y(4)+Topt_y_0))/sigma;
h_v=-2*phi*(Y(5)-(eta*Y(4)+Topt_y_0))*eta;
q_v=-delta*exp(beta*Y(5));
F_v=(a_v*Y(1)*(1+a*h*Y(1))-(a_v*h*Y(1)+a*h_v*Y(1))*a*Y(1))/(1+a*h*Y(1))^2;

dY=zeros(5,1);

dY(1) = Y(1)*(b-m)-c*Y(1)^2-Y(3)*F; 
dY(2) = (1-Y(2))*Gx*(b_u - m_u);
dY(3) = p*Y(3)*F-Y(3)*q;
dY(4) = (1-Y(4))*Gy*(p*F_v-q_v);
dY(5) = epsilon; 

%The adaptation happens when T_{h} is bigger than T_{opt,0}

 if Y(5)<epsilon*200+13
     dY(5) = epsilon;
 else
     dY(5)=0;
 end

if Y(5)<=Topt_x_0+Y(2)*3
    dY(2)=0;
else
    dY(2)=(1-Y(2))*Gx*(b_u - m_u); 
end

if Y(5)<=Topt_y_0+Y(4)*3
    dY(4)=0;
else
    dY(4)=(1-Y(4))*Gy*(p*F_v-q_v);
end


end   
