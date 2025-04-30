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
%theta=0.9;
%m=8;
K=20;
T_opt_0=18;
epsilon=0.01;
Tmax=25;
%G=0.01;

umbral = 1e-6;

m_end=20;
G_end=0.5;

m=0:0.01:m_end;
G=0:0.01:G_end;

m1=length(m);
m2=length(G);

theta=[0.5 0.75 1];

R=cell(1,length(theta));

% Inicializar matrices para almacenar resultados y colores
R1 = zeros(m1, m2);


for s=1:length(theta)
for i=1:m1
    for j=1:m2

P=[rmax theta(s) m(i) K T_opt_0 epsilon Tmax G(j)];
%% Condiciones iniciales:
x1=5;
x2=0;
x3=20;


x0=[x1 x2 x3];


% Definir intervalo de tiempo
tspan=[0 1000];

%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi3(t,Y,P),tspan,x0);

    R1(i,j)=Yv(end,1);
% Ajustar valores pequeños o negativos
    R1(R1< umbral) = 0;
    R1(R1>100) = K;

clear Yv

    end 
end 

R{1,s}=R1;

clear R1
end


max1=max(max(R{1,1}));
min1=min(min(R{1,1}));
max2=max(max(R{1,2}));
min2=min(min(R{1,2}));
max3=max(max(R{1,3}));
min3=min(min(R{1,3}));

% Crear la figura
figure(1);

subplot(1,3,1)
[X, Y] = meshgrid(m, G);
contourf(X, Y, R{1,1}', 2000, 'LineStyle', 'none');
colormap(jet)
caxis([min([min1 min2 min3]) max([max1 max2 max3])]);
ax = gca;
ax.FontSize = 14;
xlim([0, m_end]);
ylim([0, G_end]);
axis square;
xticks([0, 5, 10, 15, 20]);
yticks([0, 0.5, 1, 1.5, 2]);
xlabel('m');  
ylabel('G');  
hold on 
colorbar
set(gca, 'FontSize', 15);   

subplot(1,3,2)
[X, Y] = meshgrid(m, G);
contourf(X, Y, R{1,2}', 2000, 'LineStyle', 'none');
colormap(jet)
caxis([min([min1 min2 min3]) max([max1 max2 max3])]);
ax = gca;
ax.FontSize = 14;
xlim([0, m_end]);
ylim([0, G_end]);
axis square;
xticks([0, 5, 10, 15, 20]);
yticks([0, 0.5, 1, 1.5, 2]);
xlabel('m');  
ylabel('G');  
hold on 
colorbar
set(gca, 'FontSize', 15); 



subplot(1,3,3)
[X, Y] = meshgrid(m, G);
contourf(X, Y, R{1,3}', 2000, 'LineStyle', 'none');
colormap(jet)
caxis([min([min1 min2 min3]) max([max1 max2 max3])]);
ax = gca;
ax.FontSize = 14;
xlim([0, m_end]);
ylim([0, G_end]);
axis square;
xticks([0, 5, 10, 15, 20]);
yticks([0, 0.5, 1, 1.5, 2]);
xlabel('m');  
ylabel('G');
hold on 
colorbar
set(gca, 'FontSize', 15); 



tiempo_transcurrido = toc
