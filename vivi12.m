function dY = vivi12(~,Y,P)


N=3; %number of patches

Ax=zeros(N);
Ay=zeros(N);
for k=1:N
    Ax(k,k+1)=0.;
    Ax(k+1,k)=0.;

    Ay(k,k+1)=0.;
    Ay(k+1,k)=0.;
end



bmax=P(1:N);
theta=P(N+1:2*N);
m0= P(2*N+1:3*N);
alpha= P(3*N+1:4*N);
gamma= P(4*N+1:5*N);
c=P(5*N+1:6*N);
Topt_x_0=P(6*N+1:7*N);
mu=P(7*N+1:8*N);
epsilon= P(8*N+1:9*N);
Gx=P(9*N+1:10*N);

amax=P(10*N+1:11*N);
phi=P(11*N+1:12*N);
h_opt=P(12*N+1:13*N);
p=P(13*N+1:14*N);
q0=P(14*N+1:15*N);
delta=P(15*N+1:16*N);
beta=P(16*N+1:17*N);
sigma=P(17*N+1:18*N);
Topt_y_0=P(18*N+1:19*N);
eta=P(19*N+1:20*N);
Gy= P(20*N+1:21*N);


umbral1 = 1e-5;
umbral2 = 1;


dY=zeros(5*N,1);



for i=1:N
    
dispersion_prey_left = 0;
dispersion_prey_right = 0;

dispersion_predator_left = 0;
dispersion_predator_right = 0;

if i > 1
    dispersion_prey_left = Ax(i-1,i) * Y(5*(i-1)-4) - Ax(i,i-1) * Y(5*i-4);
end

if i < N
    dispersion_prey_right = Ax(i+1,i) * Y(5*(i+1)-4) - Ax(i,i+1) * Y(5*i-4);
end

if i > 1
    dispersion_predator_left = Ay(i-1,i) * Y(5*(i-1)-2) - Ay(i,i-1) * Y(5*i-2);
end

if i < N
    dispersion_predator_right = Ay(i+1,i) * Y(5*(i+1)-2) - Ay(i,i+1) * Y(5*i-2);
end

  

%Functions


b(i)=bmax(i)*exp((-(Y(5*i)-(mu(i)*Y(5*i-3)+Topt_x_0(i)))^2)/(2*theta(i)^2));
b_u(i)=b(i)*mu(i)*(Y(5*i)-(mu(i)*Y(5*i-3)+Topt_x_0(i)))/(theta(i))^2;
m(i)=(m0(i)-gamma(i)*Y(5*i-3))*exp(alpha(i)*Y(5*i));
m_u(i)=-gamma(i)*exp(alpha(i)*Y(5*i));
a(i)=amax(i)*exp((-(Y(5*i)-(eta(i)*Y(5*i-1)+Topt_y_0(i)))^2)/(2*sigma(i)^2));
h(i)=phi(i)*(Y(5*i)-(eta(i)*Y(5*i-1)+Topt_y_0(i)))^2+h_opt(i);
q(i)=(q0(i)-delta(i)*Y(5*i-1))*exp(beta(i)*Y(5*i));
F(i)=Y(5*i-4)*a(i)/(1+a(i)*h(i)*Y(5*i-4));
a_v(i)=amax(i)*(exp((-(Y(5*i)-(eta(i)*Y(5*i-1)+Topt_y_0(i)))^2)/(2*sigma(i)^2)))*eta(i)*(Y(5*i)-(eta(i)*Y(5*i-1)+Topt_y_0(i)))/sigma(i);
h_v(i)=-2*phi(i)*(Y(5*i)-(eta(i)*Y(5*i-1)+Topt_y_0(i)))*eta(i);
q_v(i)=-delta(i)*exp(beta(i)*Y(5*i));
F_v(i)=(a_v(i)*Y(5*i-4)*(1+a(i)*h(i)*Y(5*i-4))-(a_v(i)*h(i)*Y(5*i-4)+a(i)*h_v(i)*Y(5*i-4))*a(i)*Y(5*i-4))/(1+a(i)*h(i)*Y(5*i-4))^2;


%% Equations

dY(5*i-4) = Y(5*i-4)*(b(i)-m(i)) - c(i)*(Y(5*i-4))^2 - Y(5*i-2)*F(i) + dispersion_prey_left + dispersion_prey_right;
dY(5*i-3) = (1-Y(5*i-3))*Gx(i)*(b_u(i) - m_u(i));
dY(5*i-2) = p(i)*Y(5*i-2)*F(i)-Y(5*i-2)*q(i) + dispersion_predator_left + dispersion_predator_right; 
dY(5*i-1) = (1-Y(5*i-1))*Gy(i)*(p(i)*F_v(i)-q_v(i));
dY(5*i) = epsilon(i);


%The adaptation happens when T_{h} is bigger than T_{opt,0}

 if Y(5*i)<epsilon(i)*200+13+i
     dY(5*i) = epsilon(i);
 else
     dY(5*i)=0;
 end

if Y(5*i)<=Topt_x_0(i)+3*Y(5*i-3)
    dY(5*i-3)=0;
else
    dY(5*i-3)=(1-Y(5*i-3))*Gx(i)*(b_u(i) - m_u(i)); 
end

if Y(5*i)<=Topt_y_0(i)+3*Y(5*i-1)
    dY(5*i-1)=0;
else
    dY(5*i-1)=(1-Y(5*i-1))*Gy(i)*(p(i)*F_v(i)-q_v(i));
end

end

end
