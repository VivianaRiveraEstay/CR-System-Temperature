% En este codigo graficamos la solucion numerica de una ecuacion
% diferencial, utilizado la funcion ODE45, con distintas condiciones iniciales.
%Solucion vivi
%Fijacion de Parametros:
clc 
close all
clear all
tic;
%% Parametros
format long

%Leading edge

bmax1=1;
theta1=4;
m1=5;
mu0_1=0.01;
alpha1=0.01;
gamma1=0.0001; %tiene que ser pequeño
q1=0.01;
T_opt_0_1=10;
epsilon1=0.01;
Tmax1=25;
G1=0.01;

%The Core

bmax2=1;
theta2=4;
m2=5;
mu0_2=0.01;
alpha2=0.01;
gamma2=0.0001; %tiene que ser pequeño
q2=0.01;
T_opt_0_2=18;
epsilon2=0.01;
Tmax2=30;
G2=0.01;

%Trealing edge

bmax3=1;
theta3=4;
m3=5;
mu0_3=0.01;
alpha3=0.01;
gamma3=0.0001; %tiene que ser pequeño
q3=0.01;
T_opt_0_3=22;
epsilon3=0.01;
Tmax3=40;
G3=0.01;

%dispersal parameters

d1=0.3;
d2=0.3;
d3=0.3;
d4=0.3;
d5=0.3;
d6=0.3;

P=[bmax1 theta1 m1 mu0_1 alpha1 gamma1 q1 T_opt_0_1 epsilon1 Tmax1 G1 bmax2 theta2 m2 mu0_2 alpha2 gamma2 q2 T_opt_0_2 epsilon2 Tmax2 G2 bmax3 theta3 m3 mu0_3 alpha3 gamma3 q3 T_opt_0_3 epsilon3 Tmax3 G3 d1 d2 d3 d4 d5 d6];
%% Condiciones iniciales:
x1=10;
x2=0;
x3=12;

x4=10;
x5=0;
x6=16;

x7=10;
x8=0;
x9=26;

x0=[x1 x2 x3 x4 x5 x6 x7 x8 x9];


% Definir intervalo de tiempo
tspan=[0 1500];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi6(t,Y,P),tspan,x0);
    
b_end1=bmax1*(exp((-(Yv(end,3)-m1*Yv(end,2)-T_opt_0_1)^2)/(2*theta1^2)));
T_opt_end1=m1*Yv(end,2)+T_opt_0_1;
T_end1=Yv(end,3);


b_end2=bmax2*(exp((-(Yv(end,6)-m2*Yv(end,5)-T_opt_0_2)^2)/(2*theta2^2)));
T_opt_end2=m2*Yv(end,5)+T_opt_0_2;
T_end2=Yv(end,6);

b_end3=bmax3*(exp((-(Yv(end,9)-m3*Yv(end,8)-T_opt_0_3)^2)/(2*theta3^2)));
T_opt_end3=m3*Yv(end,8)+T_opt_0_3;
T_end3=Yv(end,9);


figure(1)
subplot(1,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time'),ylabel('Population density','FontSize', 16);
hold on
plot(tv,Yv(:,4),'LineWidth',2)
hold on
plot(tv,Yv(:,7),'LineWidth',2)
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
legend('LE', 'TH', 'TE')

subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time'),ylabel('Mean trait','FontSize', 16);
hold on
plot(tv,Yv(:,5),'LineWidth',2)
hold on
plot(tv,Yv(:,8),'LineWidth',2)
legend('LE', 'TH', 'TE')
ylim([0, 1]);
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula

subplot(1,3,3),plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time'),ylabel('Mean habitat temperature','FontSize', 16);
hold on
plot(tv,Yv(:,6),'LineWidth',2)
hold on
plot(tv,Yv(:,9),'LineWidth',2)
legend('LE', 'TH', 'TE')
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
saveas(gcf,'figure1','jpg')



% Coordenadas de los dos puntos
p1_1 = T_opt_0_1;
q1_1 = 0;
p2_1 = T_opt_0_1;
q2_1 = bmax1;

% Coordenadas de los dos puntos
p1_2 = T_opt_0_2;
q1_2 = 0;
p2_2 = T_opt_0_2;
q2_2 = bmax1;

% Coordenadas de los dos puntos
p1_3 = T_opt_0_3;
q1_3 = 0;
p2_3 = T_opt_0_3;
q2_3 = bmax1;

% Coordenadas de los dos puntos
p3_1 = T_opt_end1;
q3_1 = 0;
p4_1 = T_opt_end1;
q4_1 = bmax1;

% Coordenadas de los dos puntos
p3_2 = T_opt_end2;
q3_2 = 0;
p4_2 = T_opt_end2;
q4_2 = bmax2;

% Coordenadas de los dos puntos
p3_3 = T_opt_end3;
q3_3 = 0;
p4_3 = T_opt_end3;
q4_3 = bmax3;

% Definir el rango de valores de T_{h}
T = linspace(0, 40);

% Birth rates function at the beginning and at the end 
r1_1 = bmax1 * exp(-((-T_opt_end1 + T).^2) / (2 * theta1^2)); %with adaptive process 
r2_1 = bmax1 * exp(-((-T_opt_0_1 + T).^2) / (2 * theta1^2)); %without adaptive process 

r1_2 = bmax2 * exp(-((-T_opt_end2 + T).^2) / (2 * theta2^2)); %with adaptive process 
r2_2 = bmax2 * exp(-((-T_opt_0_2 + T).^2) / (2 * theta2^2)); %without adaptive process 

r1_3 = bmax3 * exp(-((-T_opt_end3 + T).^2) / (2 * theta3^2)); %with adaptive process 
r2_3 = bmax3 * exp(-((-T_opt_0_3 + T).^2) / (2 * theta3^2)); %without adaptive process 

figure(2)

subplot(2,1,1),plot(T, r2_1, 'LineWidth', 2);  
set(gca, 'FontSize', 16);   
xlabel('Temperature °C','FontSize', 16);                
ylabel('Birth rate','FontSize', 16);                 
hold on 
plot(T, r2_2, 'LineWidth', 2);  
set(gca, 'FontSize', 16);    
hold on 
plot(T, r2_3, 'LineWidth', 2);  
set(gca, 'FontSize', 16);   
hold on
% Graficar los optimos
plot([p1_1, p2_1], [q1_1, q2_1],'--', 'LineWidth', 1.5); 
plot([p1_2, p2_2], [q1_2, q2_2],'--', 'LineWidth', 1.5);  
plot([p1_3, p2_3], [q1_3, q2_3],'--', 'LineWidth', 1.5);  
legend('LE','TC','TE','T_{opt,0}')
set(gca, 'FontSize', 16);   

subplot(2,1,2),plot(T, r1_1, 'LineWidth', 2);  
set(gca, 'FontSize', 16);   
xlabel('Temperature °C','FontSize', 16);                
ylabel('Birth rate','FontSize', 16);                 
hold on 
plot(T, r1_2, 'LineWidth', 2);  
set(gca, 'FontSize', 16);    
hold on 
plot(T, r1_3, 'LineWidth', 2);  
set(gca, 'FontSize', 16);   
hold on
% Graficar los optimos
plot([p3_1, p4_1], [q3_1, q4_1],'--', 'LineWidth', 1.5); 
plot([p3_2, p4_2], [q3_2, q4_2],'--', 'LineWidth', 1.5);  
plot([p3_3, p4_3], [q3_3, q4_3],'--', 'LineWidth', 1.5);  
legend('LE','TC','TE','T_{opt,0}')
set(gca, 'FontSize', 16);

figure(3) % Mortality rates 

T2_1=Yv(:,3);
T2_2=Yv(:,6);
T2_3=Yv(:,9);



r5_1 = (mu0_1 - gamma1*Yv(:,2)) .* exp(alpha1*Yv(:,3)); %with adaptive process 
r6_1 = mu0_1 * exp(alpha1*Yv(:,3)); %without adaptive process 

r5_2 = (mu0_2 - gamma2*Yv(:,5)) .* exp(alpha2*Yv(:,6)); %with adaptive process 
r6_2 = mu0_2 * exp(alpha2*Yv(:,6)); %without adaptive process 

r5_3 = (mu0_3 - gamma3*Yv(:,8)) .* exp(alpha3*Yv(:,9)); %with adaptive process 
r6_3 = mu0_3 * exp(alpha3*Yv(:,9)); %without adaptive process

subplot(1,3,1),plot(T2_1,r5_1,'LineWidth',2);
hold on
plot(T2_1,r6_1,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Mortality rate','FontSize', 16);                
set(gca, 'FontSize', 16);    
legend('with phenotypic change','without phenotypic change')
title('LE')
xlim([x3, Yv(end,3)]);

subplot(1,3,2),plot(T2_2,r5_2,'LineWidth',2);
hold on
plot(T2_2,r6_2,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Mortality rate','FontSize', 16);                
set(gca, 'FontSize', 16);    
legend('with phenotypic change','without phenotypic change')
title('TC')
xlim([x6, Yv(end,6)]);

subplot(1,3,3),plot(T2_3,r5_3,'LineWidth',2);
hold on
plot(T2_3,r6_3,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Mortality rate','FontSize', 16);                
set(gca, 'FontSize', 16);    
legend('with phenotypic change','without phenotypic change')
title('TE')
xlim([x9, Yv(end,9)]);


figure(4) % Birth rates   

r3_1 = bmax1 * exp(-((-m1*Yv(:,2)-T_opt_0_1 + Yv(:,3)).^2) / (2 * theta1^2)); %with adaptive process
r4_1 = bmax1 * exp(-((-T_opt_0_1 + Yv(:,3)).^2) / (2 * theta1^2)); %without adaptive process

r3_2 = bmax2 * exp(-((-m2*Yv(:,5)-T_opt_0_2 + Yv(:,6)).^2) / (2 * theta2^2)); %with adaptive process
r4_2 = bmax2 * exp(-((-T_opt_0_2 + Yv(:,6)).^2) / (2 * theta2^2)); %without adaptive process

r3_3 = bmax3 * exp(-((-m3*Yv(:,8)-T_opt_0_3 + Yv(:,9)).^2) / (2 * theta3^2)); %with adaptive process
r4_3 = bmax3 * exp(-((-T_opt_0_3 + Yv(:,9)).^2) / (2 * theta3^2)); %without adaptive process

subplot(1,3,1),plot(T2_1,r3_1,'LineWidth',2);
hold on
plot(T2_1,r4_1,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 % Etiqueta del eje x
ylabel('Birth rate','FontSize', 16);                 % Etiqueta del eje y
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
legend('with phenotypic change','without phenotypic change')
title('LE')
xlim([x3, Yv(end,3)]);

subplot(1,3,2),plot(T2_2,r3_2,'LineWidth',2);
hold on
plot(T2_2,r4_2,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 % Etiqueta del eje x
ylabel('Birth rate','FontSize', 16);                 % Etiqueta del eje y
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
legend('with phenotypic change','without phenotypic change')
title('TC')
xlim([x6, Yv(end,6)]);

subplot(1,3,3),plot(T2_3,r3_3,'LineWidth',2);
hold on
plot(T2_3,r4_3,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 % Etiqueta del eje x
ylabel('Birth rate','FontSize', 16);                 % Etiqueta del eje y
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
legend('with phenotypic change','without phenotypic change')
title('TE')
xlim([x9, Yv(end,9)]);


tiempo_transcurrido = toc




