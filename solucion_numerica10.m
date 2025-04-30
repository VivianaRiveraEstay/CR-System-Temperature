%This code give the numeric solution for the predator-prey system that
%depends on temperature and also include adaptation in both

clc 
close all
clear all
tic;

format long

%Patch 1

bmax1=0.5; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta1=4; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0_1=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha1=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma1=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c1=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0_1=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu1=3; % plasticity of the trait of prey 
epsilon1=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx1=0.01; % SPEED OF EVOLUTION 

amax1=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi1=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt1=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p1=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0_1=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta1=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta1=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma1=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0_1=18; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta1=3; % plasticity of the trait of predator
Gy1=0.01; %SPEED OF EVOLUTION 

%Patch 2

bmax2=0.5; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta2=4; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0_2=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha2=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma2=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c2=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0_2=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu2=3; % plasticity of the trait of prey 
epsilon2=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx2=0.01; % SPEED OF EVOLUTION 

amax2=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi2=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt2=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p2=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0_2=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta2=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta2=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma2=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0_2=18; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta2=3; % plasticity of the trait of predator
Gy2=0.01; %SPEED OF EVOLUTION 


%Patch 3

bmax3=0.5; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta3=4; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0_3=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha3=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma3=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c3=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0_3=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu3=3; % plasticity of the trait of prey 
epsilon3=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx3=0.01; % SPEED OF EVOLUTION 

amax3=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi3=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt3=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p3=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0_3=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta3=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta3=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma3=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0_3=18; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta3=3; % plasticity of the trait of predator
Gy3=0.01; %SPEED OF EVOLUTION 



%dispersal parameters

disx1=0.;
disx2=0.;
disx3=0.;
disx4=0.;
dis5=0.;
dis6=0.;


umbral1 = 1e-5;



P=[bmax1 theta1 m0_1 alpha1 gamma1 c1 Topt_x_0_1 mu1 epsilon1 Gx1 amax1 phi1 h_opt1 p1 q0_1 delta1 beta1 sigma1 Topt_y_0_1 eta1 Gy1 bmax2 theta2 m0_2 alpha2 gamma2 c2 Topt_x_0_2 mu2 epsilon2 Gx2 amax2 phi2 h_opt2 p2 q0_2 delta2 beta2 sigma2 Topt_y_0_2 eta2 Gy2 bmax3 theta3 m0_3 alpha3 gamma3 c3 Topt_x_0_3 mu3 epsilon3 Gx3 amax3 phi3 h_opt3 p3 q0_3 delta3 beta3 sigma3 Topt_y_0_3 eta3 Gy3 disx1 disx2 disx3 disx4 dis5 dis6];
%% Condiciones iniciales:

x1=20;
x2=0;
x3=10;
x4=0;
x5=21;

x6=20;
x7=0;
x8=10;
x9=0;
x10=22;

x11=20;
x12=0;
x13=10;
x14=0;
x15=23;


x0=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15];


t_custom = linspace(0, 5000, 1000);

%% Simulacion del Modelo
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi10(t, Y, P), t_custom, x0, options);

if Yv<0
    Yv =0;
end 

if Yv < umbral1
    Yv=0;
end
 

toc;

subplot(3,3,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
hold on
plot(tv,Yv(:,3),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 30]);
set(gca, 'FontSize', 20); 

subplot(3,3,2),plot(tv,Yv(:,2),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean trait','FontSize', 14);
hold on
plot(tv,Yv(:,4),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 1]);
set(gca, 'FontSize', 20); 

subplot(3,3,3),plot(tv,Yv(:,5),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature','FontSize', 14);
xlim([0, 5000]); 
set(gca, 'FontSize', 20); 

%Patch2

subplot(3,3,4),plot(tv,Yv(:,6),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
hold on
plot(tv,Yv(:,8),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 30]);
set(gca, 'FontSize', 20); 

subplot(3,3,5),plot(tv,Yv(:,7),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean trait','FontSize', 14);
hold on
plot(tv,Yv(:,9),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 1]);
set(gca, 'FontSize', 20); 

subplot(3,3,6),plot(tv,Yv(:,10),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature','FontSize', 14);
xlim([0, 5000]); 
set(gca, 'FontSize', 20);

%Patch3

subplot(3,3,7),plot(tv,Yv(:,11),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
hold on
plot(tv,Yv(:,13),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 30]);
set(gca, 'FontSize', 20); 

subplot(3,3,8),plot(tv,Yv(:,12),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean trait','FontSize', 14);
hold on
plot(tv,Yv(:,14),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Mean trait','FontSize', 15);
legend('Prey', 'Predator')
xlim([0, 5000]); 
ylim([0, 1]);
set(gca, 'FontSize', 20); 

subplot(3,3,9),plot(tv,Yv(:,15),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Mean habitat temperature','FontSize', 14);
xlim([0, 5000]); 
set(gca, 'FontSize', 20);




toc;