%this code simulate the persistence of species in 

clc 
close all
clear all
tic;

format long

%PREY PARAMETERS

%bmax=1; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
%theta=3; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu=10; % plasticity of the trait of prey 
epsilon=0.004; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Tmax=23; %MAX TEMPERATURE GIVEN THAT ENVIRONMENTAL WARMING 
Gx=0.01; % SPEED OF EVOLUTION 

%PREDATOR PARAMETERS

amax=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01; % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=10; % plasticity of the trait of predator
Gy=0.01; %SPEED OF EVOLUTION 

umbral = 1e-6;

bmax_end=1;
theta_end=4;

bmax=0:0.01:bmax_end;
theta=0:0.01:theta_end;

m1=length(bmax);
m2=length(theta);

for i=1:m1
for j=1:m2

P=[bmax(i) theta(j) m0 alpha gamma c Topt_x_0 mu epsilon Tmax Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy];
%% Initial conditions:

x1=20; 
x2=0;
x3=10;
x4=0;
x5=19;


x0=[x1 x2 x3 x4 x5];


% time interval
tspan=[0 2000];

%% Simulation of the model
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi8(t, Y, P), tspan, x0, options);

%PREY
    R1(i,j)=Yv(end,1);
% Adjusting small or negative values
    R1(R1< umbral) = 0;

%PREDATOR
        R2(i,j)=Yv(end,3);
% Adjusting small or negative values
    R2(R2< umbral) = 0;


    clear Yv
 

end
end

figure(1);

subplot(1,2,1),
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

subplot(1,2,2),
[X, Y] = meshgrid(bmax, theta);
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(jet);
caxis([min(R2(:)), max(R2(:))]);
clim([min(R2(:)), max(R2(:))]);
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



toc;