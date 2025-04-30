%Catalina Chaparro-Pedraza 2021
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

bmax=1;
tau=3;
sigma2=0.01;
K=100;
mu0=15;
mu1=2;
A=-1;
epsilon=0.001;
Emax=23;

P=[bmax tau sigma2 K mu0 mu1 A epsilon Emax];
%% Condiciones iniciales:
x1=9.45;
x2=18;
x3=20;


x0=[x1 x2 x3];


% Definir intervalo de tiempo
tspan=[0 300];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi(t,Y,P),tspan,x0);
    
  
figure(1)
subplot(1,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time'),ylabel('Density');
hold on
legend('Population density')
subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time'),ylabel('Trait value');
legend('mean trait')
subplot(1,3,3),plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time'),ylabel('Trait value');
legend('Environmental variable')
saveas(gcf,'figure1','jpg')



tiempo_transcurrido = toc



% Definir la media y la desviación estándar de la distribución original
media_original = x2; % Cambia el valor según la media original
desviacion = sigma2; % Cambia el valor según la desviación estándar

% Definir el rango de valores para x
x = -1:0.1:1; % Cambia el rango según tus preferencias

% Calcular los valores de la distribución normal original
y_original = normpdf(x, media_original, desviacion);

% Aumentar la media
aumento_media = Yv(end,2); % Cambia el valor según el aumento deseado
media_nueva = media_original + aumento_media;

% Calcular los valores de la nueva distribución normal
y_nueva = normpdf(x, media_nueva, desviacion);


figure(2)
% Graficar ambas distribuciones normales
plot(x, y_original, 'LineWidth', 2);
hold on;
plot(x, y_nueva, 'LineWidth', 2);
title('Distribución Normal con Media Aumentada');
xlabel('Valor');
ylabel('Densidad de Probabilidad');
legend('Distribución Original', 'Distribución con Media Aumentada', 'Location', 'northwest');
hold off;