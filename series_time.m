clc 
close all
clear all
tic;

%% Parametros
format long

%Valores de parametros en el parche 1

N=3;
bmax1=0.79; %[0,1] 1 Priyanga 2015
theta1=2.45; %[1,5]  5 Priyanga 2015
m0_1=0.1; % 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha1=0.01; % 0.2 Vasseur chapter book
gamma1=0.0001; %it has to be tiny
d1=0.001; %c
Topt_x_0_1=18; %20 Vasseur chapter book 2014
mu1=10; 
epsilon1=0.004; %0.02 and 0.04 Chaparro-Pedraza 2021
Tmax1=23;
G1_x=0.01; %

amax1=0.1;
phi1=0.01;
h_opt_1=1;
p1=0.1;
q0_1=0.01;
delta1=0.0001;
beta1=0.01;
sigma1=3;
Topt_y_0_1=16;
eta1=10;
G1_y=0.01;


umbral = 1e-6;

P=[bmax1 theta1 m0_1 alpha1 gamma1 d1 Topt_x_0_1 mu1 epsilon1 Tmax1 G1_x amax1 phi1 h_opt_1 p1 q0_1 delta1 beta1 sigma1 Topt_y_0_1 eta1 G1_y];

%% Condiciones iniciales:
x1=20;%Población inicial presa en parche 1
x2=0; %rasgo primerdio inicial presa en parche 1
x3=10; %Población inicial depredador en parche 1
x4=0; %rasgo primerdio inicial depredador en parche 1
x5=19; %Temperatura inicial del medio ambiente parche 1
x6=20;%Población inicial presa en parche 2
x7=0; %rasgo primerdio inicial presa en parche 2
x8=10; %Población inicial depredador en parche 2
x9=0; %rasgo primerdio inicial depredador en parche 2
x10=19; %Temperatura inicial del medio ambiente parche 2
x11=20;%Población inicial presa en parche 3
x12=0; %rasgo primerdio inicial presa en parche 3
x13=10; %Población inicial depredador en parche 3
x14=0; %rasgo primerdio inicial depredador en parche 3
x15=19; %Temperatura inicial del medio ambiente parche 3


x0=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15];

% Definir intervalo de tiempo
tspan=[0 5000];

%% Simulacion del Modelo
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi9(t, Y, P), tspan, x0, options);


for k=1:N

subplot(N,3,3*k-2),plot(tv,Yv(:,5*k-4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
hold on
plot(tv,Yv(:,5*k-2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
legend('Prey', 'Predator')
set(gca, 'FontSize', 15); 

subplot(N,3,3*k-1),plot(tv,Yv(:,5*k-3),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean trait','FontSize', 14);
hold on
plot(tv,Yv(:,5*k-1),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
legend('Prey', 'Predator')
set(gca, 'FontSize', 15); 

subplot(N,3,3*k),plot(tv,Yv(:,5*k),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature','FontSize', 14);
set(gca, 'FontSize', 15); 
end




function dY = vivi9(~, Y, P)
%% Parametros del modelo en el pache 1:
N=3;

dis=[0 0.2 0 ; 0.1 0 0.1 ; 0 0.2 0];


bmax1 = P(1);
theta1 = P(2);
m0_1 = P(3);
alpha1 = P(4);
gamma1 = P(5);
d1 = P(6);
Topt_x_0_1 = P(7);
mu1 = P(8);
epsilon1 = P(9);
Tmax1 = P(10);
G1_x = P(11);

amax1 = P(12);
phi1 = P(13);
h_opt_1 = P(14);
p1 = P(15);
q0_1 = P(16);
delta1 = P(17);
beta1 = P(18);
sigma1 = P(19);
Topt_y_0_1 = P(20);
eta1 = P(21);
G1_y = P(22);

dY = zeros(5*N, 1); % Inicializar vector de derivadas

for j=1:N   
for i=1:N

suma_disp_presas1 = sum(dis(j,i) * Y(5*i-4)); % Suma de la dispersión de presas desde el parche j hacia el parche i
suma_disp_presas2 = sum(dis(i,j) * Y(5*j-4)); % Suma de la dispersión de presas desde el parche j hacia el parche i


b = bmax1 * exp((-(Y(5*i) - (mu1 * Y(5*i-3) + Topt_x_0_1))^2) / (2 * theta1^2));
b_u = b * mu1 * (Y(5*i) - (mu1 * Y(5*i-3) + Topt_x_0_1)) / theta1^2;
m = (m0_1 - gamma1 * Y(5*i-3)) * exp(alpha1 * Y(5*i));
m_u = -gamma1 * exp(alpha1 * Y(5*i));
a = amax1 * exp((-(Y(5*i) - (eta1 * Y(5*i-1) + Topt_y_0_1))^2) / (2 * sigma1^2));
h = phi1 * (Y(5*i) - (eta1 * Y(5*i-1) + Topt_y_0_1))^2 + h_opt_1;
q = (q0_1 - delta1 * Y(5*i-1)) * exp(beta1 * Y(5*i));
F = Y(5*i-4) * a / (1 + a * h * Y(5*i-4));
a_v = amax1 * exp((-(Y(5*i) - (eta1 * Y(5*i-1) + Topt_y_0_1))^2) / (2 * sigma1^2)) * eta1 * (Y(5*i) - (eta1 * Y(5*i-1) + Topt_y_0_1)) / sigma1;
h_v = -2 * phi1 * (Y(5*i) - (eta1 * Y(5*i-1) + Topt_y_0_1)) * eta1;
q_v = -delta1 * exp(beta1 * Y(5*i));
F_v = (a_v * Y(5*i-4) * (1 + a * h * Y(5*i-4)) - (a_v * h * Y(5*i-4) + a * h_v * Y(5*i-4)) * a * Y(5*i-4)) / (1 + a * h * Y(5*i-4))^2;

%% Lista de Ecuaciones parche 1
dY(5*i-4) = Y(5*i-4) * (b - m) - d1 * Y(5*i-4)^2 - Y(5*i-2) * F + suma_disp_presas1 - suma_disp_presas2; %Ecuación población de presa en el parche 1
dY(5*i-3) = (1 - Y(5*i-3)) * G1_x * (b_u - m_u); %Ecuación para el rasgo medio de la presa en el parche 1
dY(5*i-2) = p1 * Y(5*i-2) * F - Y(5*i-2) * q; %Ecuación población de depredador en el parche 1
dY(5*i-1) = (1 - Y(5*i-1)) * G1_y * (p1 * F_v - q_v); %Ecuación para el rasgo medio del deprdador en el parche 1
dY(5*i) = epsilon1; %Temperatura del habitat en el parche 1


 if Y(5*i)<epsilon1*200+19
     dY(5*i) = epsilon1;
 else
     dY(5*i)=0;
 end

end
end



end
