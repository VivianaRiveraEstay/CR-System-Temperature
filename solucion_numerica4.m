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

% TRAILING EDGE

rmax1=0.5;
theta1=3;
m1=7;
K1=20;
T_opt1_0=18;
epsilon1=0.001;
Tmax1=30;
G1=0.01;
d1=0.3;

% THE CORE

rmax2=0.5;
theta2=3;
m2=7;
K2=50;
T_opt2_0=18;
epsilon2=0.001;
Tmax2=25;
G2=0.01;
d2=0.3;

% LEADING EDGE

rmax3=0.5;
theta3=3;
m3=3;
K3=20;
T_opt3_0=18;
epsilon3=0.001;
Tmax3=20;
G3=0.01;
d3=0.3;

P=[rmax1 theta1 m1 K1 T_opt1_0 epsilon1 Tmax1 G1 d1 rmax2 theta2 m2 K2 T_opt2_0 epsilon2 Tmax2 G2 d2 rmax3 theta3 m3 K3 T_opt3_0 epsilon3 Tmax3 G3 d3];
%% Condiciones iniciales:
x1=5;
x2=0;
x3=26;

x4=5;
x5=0;
x6=21;

x7=5;
x8=0;
x9=14;

x0=[x1 x2 x3 x4 x5 x6 x7 x8 x9];


% Definir intervalo de tiempo
tspan=[0 1000];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi4(t,Y,P),tspan,x0);
    
r_end1=rmax1*(exp((-(Yv(end,3)-m1*Yv(end,2)-T_opt1_0)^2)/(2*theta1^2)));
T_opt1_end=m1*Yv(end,2)+T_opt1_0
T_end1=Yv(end,3);


r_end2=rmax2*(exp((-(Yv(end,6)-m2*Yv(end,5)-T_opt2_0)^2)/(2*theta2^2)));
T_opt2_end=m2*Yv(end,5)+T_opt2_0;
T_end2=Yv(end,6);

r_end3=rmax3*(exp((-(Yv(end,9)-m3*Yv(end,8)-T_opt3_0)^2)/(2*theta3^2)));
T_opt3_end=m3*Yv(end,8)+T_opt3_0;
T_end3=Yv(end,9);


figure(1)


subplot(1,3,1),plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature (C°)','FontSize', 14);
hold on
plot(tv,Yv(:,6),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean habitat temperature (C°)','FontSize', 15);
plot(tv,Yv(:,9),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean habitat temperature (C°)','FontSize', 15);
legend('TE', 'TC', 'LE')
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula




subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
hold on
plot(tv,Yv(:,5),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
plot(tv,Yv(:,8),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
legend('TE', 'TC', 'LE')
ylim([0, 1]);
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula




subplot(1,3,3),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Population density','FontSize', 14);
hold on
plot(tv,Yv(:,4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Population density','FontSize', 14');
plot(tv,Yv(:,7),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Population density','FontSize', 14);
legend('TE', 'TC', 'LE');
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula



figure(2)

% Coordenadas de los dos puntos
p1_1 = T_opt1_0;
q1_1 = 0;
p2_1 = T_opt1_0;
q2_1 = rmax1;

% Coordenadas de los dos puntos
p3_1 = T_opt1_end;
q3_1 = 0;
p4_1 = T_opt1_end;
q4_1 = rmax2;


% Coordenadas de los dos puntos
p1_2 = T_opt2_0;
q1_2 = 0;
p2_2 = T_opt2_0;
q2_2 = rmax2;

% Coordenadas de los dos puntos
p3_2 = T_opt2_end;
q3_2 = 0;
p4_2 = T_opt2_end;
q4_2 = rmax2;

% Coordenadas de los dos puntos
p1_3 = T_opt3_0;
q1_3 = 0;
p2_3 = T_opt3_0;
q2_3 = rmax3;

% Coordenadas de los dos puntos
p3_3 = T_opt3_end;
q3_3 = 0;
p4_3 = T_opt3_end;
q4_3 = rmax3;




% Definir el rango de valores de x
T = linspace(0, 40);

% Calcular los valores de la función 
r1_before = rmax1 * exp(-((-T_opt1_0 + T).^2) / (2 * theta1^2));
r1_after = rmax1 * exp(-((-T_opt1_end + T).^2) / (2 * theta1^2));

r2_before = rmax2 * exp(-((-T_opt2_0 + T).^2) / (2 * theta2^2));
r2_after = rmax2 * exp(-((-T_opt2_end + T).^2) / (2 * theta2^2));

r3_before = rmax3 * exp(-((-T_opt3_0 + T).^2) / (2 * theta3^2));
r3_after = rmax3 * exp(-((-T_opt3_end + T).^2) / (2 * theta3^2));

% Graficar la función

subplot(1,3,1)
plot(T, r3_before, 'LineWidth', 2);  % Trazar la función
xlabel('Temperature °C','FontSize', 15);                 % Etiqueta del eje x
ylabel('Intrinsic growth','FontSize', 15);                 % Etiqueta del eje y
hold on 
plot(T, r3_after, 'LineWidth', 2);  % Trazar la función
hold on
% Graficar los dos puntos
plot([p1_3, p2_3], [q1_3, q2_3],'--', 'LineWidth', 1.5);  % Trazar la línea
plot([p3_3, p4_3], [q3_3, q4_3],'--', 'LineWidth', 1.5);  % Trazar la línea
title('Leading edge')
legend('After','Before','T_{opt,0}','T_{opt,end}')
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula


subplot(1,3,2)
plot(T, r2_before, 'LineWidth', 2);  % Trazar la función
xlabel('Temperature °C','FontSize', 15);                 % Etiqueta del eje x
ylabel('Intrinsic growth','FontSize', 15);                 % Etiqueta del eje y
hold on 
plot(T, r2_after, 'LineWidth', 2);  % Trazar la función
hold on
% Graficar los dos puntos
plot([p1_2, p2_2], [q1_2, q2_2],'--', 'LineWidth', 1.5);  % Trazar la línea
plot([p3_2, p4_2], [q3_2, q4_2],'--', 'LineWidth', 1.5);  % Trazar la línea
title('The core')
legend('After','Before','T_{opt,0}','T_{opt,end}')
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula


subplot(1,3,3)
plot(T, r1_before, 'LineWidth', 2);  % Trazar la función
xlabel('Temperature °C','FontSize', 15);                 % Etiqueta del eje x
ylabel('Intrinsic growth','FontSize', 15);                 % Etiqueta del eje y
hold on 
plot(T, r1_after, 'LineWidth', 2);  % Trazar la función
hold on
% Graficar los dos puntos
plot([p1_1, p2_1], [q1_1, q2_1],'--', 'LineWidth', 1.5);  % Trazar la línea
plot([p3_1, p4_1], [q3_1, q4_1],'--', 'LineWidth', 1.5);  % Trazar la línea
title('Trailing edge')
legend('After','Before','T_{opt,0}','T_{opt,end}')
set(gca, 'FontSize', 15);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula



tiempo_transcurrido = toc




