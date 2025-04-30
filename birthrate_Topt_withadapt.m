%RATES OF THE MODEL WITH ADAPTATION

clc 
close all
clear all
tic;
addpath '/Users/vivianarivera/Documents/PASANTIA/Code1_temperature'

format long

%PREY PARAMETERS

bmax=1; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=5; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01; %COEF INTRAS COMPETITION -- K0=90
%Topt_x_0=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu=2; % plasticity of the trait of prey 
%epsilon=0.02; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Tmax=28; %MAX TEMPERATURE GIVEN THAT ENVIRONMENTAL WARMING 
Gx=0.01; % SPEED OF EVOLUTION 

%PREDATOR PARAMETERS

amax=1; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=2; % plasticity of the trait of predator
Gy=0.01; %SPEED OF EVOLUTION 


epsilon_end=0.05;
Topt_x_0_end=26;

epsilon=0:0.005:epsilon_end;
Topt_x_0=12:1:Topt_x_0_end;

m1=length(Topt_x_0);
m2=length(epsilon);

R1 = zeros(m1, m2);  



for i=1:m1
for j=1:m2

   
P=[bmax theta m0 alpha gamma c Topt_x_0(i) mu epsilon(j) Tmax Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy];
%% Initial conditions:

x1=20; 
x2=0;
x3=10;
x4=0;
x5=19;


x0=[x1 x2 x3 x4 x5];


% time interval
tspan=[0 5000];

%% Simulation of the model
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi8(t, Y, P), tspan, x0, options);

R1(i,j)=bmax*exp(-(epsilon(j)*200+19-(mu*Yv(end,2)+Topt_x_0(i)))^2/(2*theta^2)); %birth rate
 
clear Yv

end
end

toc 


figure(1);
[X, Y] = meshgrid(Topt_x_0, epsilon);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(jet);
caxis([min(R1(:)), max(R1(:))]);
clim([min(R1(:)), max(R1(:))]);
colorbar;
ax = gca;
ax.FontSize = 24;
xlim([12, Topt_x_0_end]);
ylim([0, epsilon_end]);
axis square;
xticks([12, 14, 16, 18, 20, 22, 24, 26]);
yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
%xlabel('\theta');  
%ylabel('\epsilon');  
set(gca, 'FontSize', 24);   

