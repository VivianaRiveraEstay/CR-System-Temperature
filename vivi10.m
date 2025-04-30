function dY = vivi10(~,Y,P)
%% Parameter of the model:

%Patch 1

bmax1=P(1);
theta1=P(2);
m0_1=P(3);
alpha1=P(4);
gamma1=P(5);
c1=P(6);
Topt_x_0_1=P(7);
mu1=P(8);
epsilon1=P(9);
Gx1=P(10);


amax1=P(11);
phi1=P(12);
h_opt1=P(13);
p1=P(14);
q0_1=P(15);
delta1=P(16);
beta1=P(17);
sigma1=P(18);
Topt_y_0_1=P(19);
eta1=P(20);
Gy1=P(21);

%Patch 2


bmax2=P(22);
theta2=P(23);
m0_2=P(24);
alpha2=P(25);
gamma2=P(26);
c2=P(27);
Topt_x_0_2=P(28);
mu2=P(29);
epsilon2=P(30);
Gx2=P(31);


amax2=P(32);
phi2=P(33);
h_opt2=P(34);
p2=P(35);
q0_2=P(36);
delta2=P(37);
beta2=P(38);
sigma2=P(39);
Topt_y_0_2=P(40);
eta2=P(41);
Gy2=P(42);

%Patch 3


bmax3=P(43);
theta3=P(44);
m0_3=P(45);
alpha3=P(46);
gamma3=P(47);
c3=P(48);
Topt_x_0_3=P(49);
mu3=P(50);
epsilon3=P(51);
Gx3=P(52);


amax3=P(53);
phi3=P(54);
h_opt3=P(55);
p3=P(56);
q0_3=P(57);
delta3=P(58);
beta3=P(59);
sigma3=P(60);
Topt_y_0_3=P(61);
eta3=P(62);
Gy3=P(63);


disx1=P(64);
disx2=P(65);
disx3=P(66);
disx4=P(67);
dis5=P(68);
dis6=P(69);


%Functions

b1=bmax1*exp((-(Y(5)-(mu1*Y(2)+Topt_x_0_1))^2)/(2*theta1^2));
b_u1=b1*mu1*(Y(5)-(mu1*Y(2)+Topt_x_0_1))/theta1^2;
m1=(m0_1-gamma1*Y(2))*exp(alpha1*Y(5));
m_u1=-gamma1*exp(alpha1*Y(5));
a1=amax1*exp((-(Y(5)-(eta1*Y(4)+Topt_y_0_1))^2)/(2*sigma1^2));
h1=phi1*(Y(5)-(eta1*Y(4)+Topt_y_0_1))^2+h_opt1;
q1=(q0_1-delta1*Y(4))*exp(beta1*Y(5));
F1=Y(1)*a1/(1+a1*h1*Y(1));
a_v1=amax1*exp((-(Y(5)-(eta1*Y(4)+Topt_y_0_1))^2)/(2*sigma1^2))*eta1*(Y(5)-(eta1*Y(4)+Topt_y_0_1))/sigma1;
h_v1=-2*phi1*(Y(5)-(eta1*Y(4)+Topt_y_0_1))*eta1;
q_v1=-delta1*exp(beta1*Y(5));
F_v1=(a_v1*Y(1)*(1+a1*h1*Y(1))-(a_v1*h1*Y(1)+a1*h_v1*Y(1))*a1*Y(1))/(1+a1*h1*Y(1))^2;


b2=bmax2*exp((-(Y(10)-(mu2*Y(7)+Topt_x_0_2))^2)/(2*theta2^2));
b_u2=b2*mu2*(Y(10)-(mu2*Y(7)+Topt_x_0_2))/theta2^2;
m2=(m0_2-gamma2*Y(7))*exp(alpha2*Y(10));
m_u2=-gamma2*exp(alpha2*Y(10));
a2=amax2*exp((-(Y(10)-(eta2*Y(9)+Topt_y_0_2))^2)/(2*sigma2^2));
h2=phi2*(Y(10)-(eta2*Y(9)+Topt_y_0_2))^2+h_opt2;
q2=(q0_2-delta2*Y(9))*exp(beta2*Y(10));
F2=Y(6)*a2/(1+a2*h2*Y(6));
a_v2=amax2*exp((-(Y(10)-(eta2*Y(9)+Topt_y_0_2))^2)/(2*sigma2^2))*eta2*(Y(10)-(eta2*Y(9)+Topt_y_0_2))/sigma2;
h_v2=-2*phi2*(Y(10)-(eta2*Y(9)+Topt_y_0_2))*eta2;
q_v2=-delta2*exp(beta2*Y(10));
F_v2=(a_v2*Y(6)*(1+a2*h2*Y(6))-(a_v2*h2*Y(6)+a2*h_v2*Y(6))*a2*Y(6))/(1+a2*h2*Y(6))^2;



b3=bmax3*exp((-(Y(15)-(mu3*Y(12)+Topt_x_0_3))^2)/(2*theta3^2));
b_u3=b3*mu3*(Y(15)-(mu3*Y(12)+Topt_x_0_3))/theta3^2;
m3=(m0_3-gamma3*Y(12))*exp(alpha3*Y(15));
m_u3=-gamma3*exp(alpha3*Y(15));
a3=amax3*exp((-(Y(15)-(eta3*Y(14)+Topt_y_0_3))^2)/(2*sigma3^2));
h3=phi3*(Y(15)-(eta3*Y(14)+Topt_y_0_3))^2+h_opt3;
q3=(q0_3-delta3*Y(14))*exp(beta3*Y(15));
F3=Y(11)*a3/(1+a3*h3*Y(11));
a_v3=amax3*exp((-(Y(15)-(eta3*Y(14)+Topt_y_0_3))^2)/(2*sigma3^2))*eta3*(Y(15)-(eta3*Y(14)+Topt_y_0_3))/sigma3;
h_v3=-2*phi3*(Y(15)-(eta3*Y(14)+Topt_y_0_3))*eta3;
q_v3=-delta2*exp(beta3*Y(15));
F_v3=(a_v3*Y(11)*(1+a3*h3*Y(11))-(a_v3*h3*Y(11)+a3*h_v3*Y(11))*a3*Y(11))/(1+a3*h3*Y(11))^2;

%% Equations
dY=zeros(15,1);


dY(1) = Y(1)*(b1-m1)-c1*Y(1)^2-Y(3)*F1-disx1*Y(1)+disx2*Y(6); 
dY(2) = (1-Y(2))*Gx1*(b_u1 - m_u1);
dY(3) = p1*Y(3)*F1-Y(3)*q1;
dY(4) = (1-Y(4))*Gy1*(p1*F_v1-q_v1);
dY(5) = epsilon1;

dY(6) = Y(6)*(b2-m2)-c2*Y(6)^2-Y(8)*F2+disx1*Y(1)-disx2*Y(6)-disx3*Y(6)+disx4*Y(11); 
dY(7) = (1-Y(7))*Gx2*(b_u2 - m_u2);
dY(8) = p2*Y(8)*F2-Y(8)*q2;
dY(9) = (1-Y(9))*Gy2*(p2*F_v2-q_v2);
dY(10) = epsilon2;


dY(11) = Y(11)*(b3-m3)-c3*Y(11)^2-Y(13)*F3+disx3*Y(6)-disx4*Y(11); 
dY(12) = (1-Y(12))*Gx3*(b_u3 - m_u3);
dY(13) = p3*Y(13)*F3-Y(13)*q3;
dY(14) = (1-Y(14))*Gy3*(p3*F_v3-q_v3);
dY(15) = epsilon3;

%The adaptation happens when T_{h} is bigger than T_{opt,0}

 if Y(5)<epsilon1*200+21
     dY(5) = epsilon1;
 else
     dY(5)=0;
 end

if Y(5)<=Topt_x_0_1+Y(2)*3
    dY(2)=0;
else
    dY(2)=(1-Y(2))*Gx1*(b_u1 - m_u1); 
end

if Y(5)<=Topt_y_0_1+Y(4)*3
    dY(4)=0;
else
    dY(4)=(1-Y(4))*Gy1*(p1*F_v1-q_v1);
end

%Patch 2

 if Y(10)<epsilon2*200+22
     dY(10) = epsilon2;
 else
     dY(10)=0;
 end

if Y(10)<=Topt_x_0_2+Y(7)*3
    dY(7)=0;
else
    dY(7)=(1-Y(7))*Gx2*(b_u2 - m_u2); 
end

if Y(10)<=Topt_y_0_2+Y(9)*3
    dY(9)=0;
else
    dY(9)=(1-Y(9))*Gy2*(p2*F_v2-q_v2);
end




%Patch 3

 if Y(15)<epsilon3*200+23
     dY(15) = epsilon3;
 else
     dY(15)=0;
 end

if Y(15)<=Topt_x_0_3+Y(12)*3
    dY(12)=0;
else
    dY(12)=(1-Y(12))*Gx3*(b_u3 - m_u3); 
end

if Y(15)<=Topt_y_0_3+Y(14)*3
    dY(14)=0;
else
    dY(14)=(1-Y(14))*Gy3*(p3*F_v3-q_v3);
end


end   
