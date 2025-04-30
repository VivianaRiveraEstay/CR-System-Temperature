%This code give the numeric solution for the predator-prey system that
%depends on temperature and also include adaptation in both

clc 
close all
clear all
tic;


%PREY PARAMETERS

bmax=0.5; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=5; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01; % TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu=3; % plasticity of the trait of prey 
epsilon=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.0; % SPEED OF EVOLUTION 


%PREDATOR PARAMETERS

amax=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=0.5; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01; % TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3; % BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3; % plasticity of the trait of predator
Gy=0.0; %SPEED OF EVOLUTION 




umbral1 = 1e-5;
umbral2 = 1;


P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy];

x1=20;
x2=0;
x3=10;
x4=0;
x5=13;

x0=[x1 x2 x3 x4 x5];


t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi8(t, Y, P), t_custom, x0, options);

% Primera condición: si Yv < 0, entonces Yv = 0
Yv(Yv < 0) = 0;

% Segunda condición: si Yv < umbral1, entonces Yv = 0
Yv(Yv < umbral1) = 0;

plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
hold on
plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 30]);
set(gca, 'FontSize', 20); 





 
% subplot(1,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% legend('Prey', 'Predator')
% xlim([0, 5000]); 
% ylim([0, 30]);
% set(gca, 'FontSize', 20); 
% 
% subplot(1,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean trait','FontSize', 14);
% hold on
% plot(tv,Yv(:,4),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
% legend('Prey', 'Predator')
% xlim([0, 5000]); 
% ylim([0, 1]);
% set(gca, 'FontSize', 20); 
% 
% subplot(1,3,3),plot(tv,Yv(:,5),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature','FontSize', 14);
% xlim([0, 5000]); 
% set(gca, 'FontSize', 20); 




%identify oscilations

total_x = mean(Yv(end-100:end,1));
total_y = mean(Yv(end-100:end,3));

max_value_x = max(Yv(end-100:end,1));
max_value_y = max(Yv(end-100:end,3));

min_value_x = min(Yv(end-100:end,1));
min_value_y = min(Yv(end-100:end,3));

metric1_x=abs (total_x-Yv(end,1));
metric1_y=abs (total_y-Yv(end,3));

metric2_x= abs (max_value_x - min_value_x);
metric2_y= abs (max_value_y - min_value_y);

metric3_x=abs(max_value_x - Yv(end,1));
metric3_y=abs(max_value_y - Yv(end,3));

if metric1_x>umbral1 && metric2_x>umbral2 || metric1_y>umbral1 && metric2_y>umbral2 || (metric1_x>umbral1 && metric3_x>0.2) || (metric1_y>umbral1 && metric3_y>0.2)
R1=3; % persistence oscillation
elseif (metric1_x<umbral1 && metric1_y<umbral1 || metric2_x<umbral2 && metric2_y<umbral2) && Yv(end,1) > umbral1 && Yv(end,3) > umbral1   
R1=2; % persistence not oscillation
elseif (metric1_x<umbral1 && metric1_y<umbral1 || metric2_x<umbral2 && metric2_y<umbral2) && Yv(end,1) > umbral1 && Yv(end,3) < umbral1   
R1=1; %just prey persistence
elseif (metric1_x<umbral1 && metric1_y<umbral1 || metric2_x<umbral2 && metric2_y<umbral2) && (Yv(end,1) < umbral1 && Yv(end,3) < umbral1)   
R1=0; %extinction 

end

 
R1

toc;