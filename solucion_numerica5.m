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

bmax=1; %[0,1] 1 Priyanga 2015
theta=4; %[1,5]  5 Priyanga 2015
m=5;
mu0=0.03; % 0.2 Priyanga 2015, 0.01 Vasseur chapter book
alpha=0.01; % 0.2 Vasseur chapter book
gamma=0.001; %tiene que ser pequeño
q=0.1; 
T_opt_0=18; %20 Vasseur chapter book
epsilon=0.01; %0.02 and 0.04 Chaparro-Pedraza 2021
Tmax=28;
G=0.01;

P=[bmax theta m mu0 alpha gamma q T_opt_0 epsilon Tmax G];
%% Condiciones iniciales:
x1=5;
x2=0;
x3=19;


x0=[x1 x2 x3];


% Definir intervalo de tiempo
tspan=[0 1000];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi5(t,Y,P),tspan,x0);
    
b_end=bmax*(exp((-(Yv(end,3)-m*Yv(end,2)-T_opt_0)^2)/(2*theta^2)));
T_opt_end=m*Yv(end,2)+T_opt_0;
T_end=Yv(end,3);



figure(1)
subplot(1,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time'),ylabel('Population density','FontSize', 16);
%ylim([0, K]);
set(gca, 'FontSize', 16);    % Tamaño de fuente de los ejes (ticks) y la cuadrícula
hold on
%legend('Population density')
subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time'),ylabel('Mean trait','FontSize', 16);
%legend('mean trait')
%ylim([0, 1]);
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
q2 = bmax;

% Coordenadas de los dos puntos
p3 = T_opt_end;
q3 = 0;
p4 = T_opt_end;
q4 = bmax;

% Definir el rango de valores de T_{h}
T = linspace(0, 40);

% Birth rates function at the beginning and at the end 
r1 = bmax * exp(-((-T_opt_end + T).^2) / (2 * theta^2)); %with adaptive process 
r2 = bmax * exp(-((-T_opt_0 + T).^2) / (2 * theta^2)); %without adaptive process 

% Graficar la función
plot(T, r1, 'LineWidth', 2);  
set(gca, 'FontSize', 16);   
xlabel('Temperature °C','FontSize', 16);                
ylabel('Birth rate','FontSize', 16);                 
hold on 
plot(T, r2, 'LineWidth', 2);  
set(gca, 'FontSize', 16);    
hold on
% Graficar los optimos
plot([p1, p2], [q1, q2],'--', 'LineWidth', 1.5); 
plot([p3, p4], [q3, q4],'--', 'LineWidth', 1.5);  
legend('After','Before','T_{opt,0}','T_{opt,end}')
set(gca, 'FontSize', 16);   



% Mortality rates 

T2=Yv(:,3);

r5 = (mu0 - gamma*Yv(:,2)) .* exp(alpha*Yv(:,3)); %with adaptive process 
r6 = mu0 * exp(alpha*Yv(:,3)); %without adaptive process 

% Birth rates   

r3 = bmax * exp(-((-m*Yv(:,2)-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2)); %with adaptive process
r4 = bmax * exp(-((-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2)); %without adaptive process

% Instrinsic growth 

r7 = bmax * exp(-((-m*Yv(:,2)-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2))-(mu0 - gamma*Yv(:,2)) .* exp(alpha*Yv(:,3)); %with adaptive process
r8 = bmax * exp(-((-T_opt_0 + Yv(:,3)).^2) / (2 * theta^2))-mu0 * exp(alpha*Yv(:,3)); %without adaptive process

figure(3)

subplot(1,3,1),plot(T2,r3,'LineWidth',2);
hold on
plot(T2,r4,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Birth rate','FontSize', 16);                 
set(gca, 'FontSize', 16);    
%legend('with phenotypic change','without phenotypic change')
xlim([x3, Yv(end,3)]);

subplot(1,3,2),plot(T2,r5,'LineWidth',2);
hold on
plot(T2,r6,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Mortality rate','FontSize', 16);                
set(gca, 'FontSize', 16);    
%legend('with phenotypic change','without phenotypic change')
xlim([x3, Yv(end,3)]);

subplot(1,3,3),plot(T2,r7,'LineWidth',2);
hold on
plot(T2,r8,'LineWidth',2);
xlabel('Mean habitat temperature °C (T_{h})' ,'FontSize', 16);                 
ylabel('Instrinsic growth','FontSize', 16);                 
set(gca, 'FontSize', 16);    
%legend('with phenotypic change','without phenotypic change')
xlim([x3, Yv(end,3)]);

tiempo_transcurrido = toc




