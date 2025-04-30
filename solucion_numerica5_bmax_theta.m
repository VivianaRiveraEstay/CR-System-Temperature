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

%bmax=0.8; %[0,1] 1 Priyanga 2015
%theta=4; %[1,5]  5 Priyanga 2015
m=5;
mu0=0.03; % 0.2 Priyanga 2015, 0.01 Vasseur chapter book
alpha=0.01; % 0.2 Vasseur chapter book
gamma=0.001; %tiene que ser pequeño
q=0.05; 
T_opt_0=18; %20 Vasseur chapter book
epsilon=0.01; %0.02 and 0.04 Chaparro-Pedraza 2021
Tmax=29;
G=0.01;


umbral = 1e-6;

bmax_end=2;
theta_end=4;

bmax=0:0.01:bmax_end;
theta=0:0.01:theta_end;

m1=length(bmax);
m2=length(theta);


for i=1:m1
    for j=1:m2

%% Condiciones iniciales:
P=[bmax(i) theta(j) m mu0 alpha gamma q T_opt_0 epsilon Tmax G];

x1=5;
x2=0;
x3=19;

x0=[x1 x2 x3];

% Definir intervalo de tiempo
tspan=[0 1000];

%% Simulacion del Modelo
options = odeset('AbsTol', 1e-8, 'RelTol', 1e-6);
[tv, Yv] = ode45(@(t, Y) vivi5(t, Y, P), tspan, x0, options);
%[tv,Yv]=ode45(@(t,Y) vivi5(t,Y,P),tspan,x0);

    R1(i,j)=Yv(end,1);
% Ajustar valores pequeños o negativos
    R1(R1< umbral) = 0;

    clear Yv

    
    end 
end 

figure(1);
[X, Y] = meshgrid(bmax, theta);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(jet);
caxis([min(R1(:)), max(R1(:))]);
clim([min(R1(:)), max(R1(:))]);
colorbar;
ax = gca;
ax.FontSize = 20;
xlim([0, bmax_end]);
ylim([0, theta_end]);
axis square;
xticks([0, 0.5, 1, 1.5 2]);
yticks([0, 1, 2, 3, 4]);
xlabel('b_{max}');  
ylabel('\theta');  
set(gca, 'FontSize', 20);   




tiempo_transcurrido = toc




