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

rmax=0.2;
theta=1;
m=5;
K=20;
T_opt_0=18;
epsilon=0.01;
Tmax=25;
G=0.01;

P=[rmax theta m K T_opt_0 epsilon Tmax G];
%% Condiciones iniciales:
x1=5;
x2=0;
x3=20;


x0=[x1 x2 x3];


% Definir intervalo de tiempo
tspan=[0 1000];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi3(t,Y,P),tspan,x0);
    
r_end=rmax*(exp((-(Yv(end,3)-m*Yv(end,2)-T_opt_0)^2)/(2*theta^2)));
T_opt_end=m*Yv(end,2)+T_opt_0;
T_end=Yv(end,3);



figure(1)
subplot(1,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time'),ylabel('Population density','FontSize', 16);
ylim([0, K]);
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
hold on
%legend('Population density')
subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time'),ylabel('Mean trait','FontSize', 16);
%legend('mean trait')
ylim([0, 1]);
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
subplot(1,3,3),plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time'),ylabel('Mean habitat temperature','FontSize', 16);
%legend('Mean habitat temperature')
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
saveas(gcf,'figure1','jpg')


figure(2)

% Coordenadas de los dos puntos
p1 = T_opt_0;
q1 = 0;
p2 = T_opt_0;
q2 = rmax;


% Coordenadas de los dos puntos
p3 = T_opt_end;
q3 = 0;
p4 = T_opt_end;
q4 = rmax;


% Definir el rango de valores de x
T = linspace(0, 40);

% Calcular r antes y despues
r1 = rmax * exp(-((-T_opt_0 + T).^2) / (2 * theta^2)); %antes
r2 = rmax * exp(-((-T_opt_end + T).^2) / (2 * theta^2)); %despues

% Graficar la función
plot(T, r1, 'LineWidth', 2);  % Trazar la función
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
xlabel('Temperature °C','FontSize', 16);                 % Etiqueta del eje x
ylabel('Intrinsic growth','FontSize', 16);                 % Etiqueta del eje y
hold on 
plot(T, r2, 'LineWidth', 2);  % Trazar la función
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
hold on
% Graficar los dos puntos
plot([p1, p2], [q1, q2],'--', 'LineWidth', 1.5);  % Trazar la línea
plot([p3, p4], [q3, q4],'--', 'LineWidth', 1.5);  % Trazar la línea
legend('After','Before','T_{opt,0}','T_{opt,end}')
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula


figure(3)

T2=Yv(:,3);

% Calcular los valores de la función y = x^2
r3 = rmax * exp(-((-m*Yv(:,2)-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2));
r4 = rmax * exp(-((-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2));

plot(T2,r3,'LineWidth',2);
hold on
plot(T2,r4,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 % Etiqueta del eje x
ylabel('Intrinsic growth','FontSize', 16);                 % Etiqueta del eje y
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
legend('with phenotypic change','with out phenotypic change')
xlim([x3, Tmax]);


tiempo_transcurrido = toc




