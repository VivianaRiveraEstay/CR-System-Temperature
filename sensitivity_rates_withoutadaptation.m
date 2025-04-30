%this code graph the temperature dependent rates

clc 
close all
clear all
tic;

format long

%PREY PARAMETERS

bmax=1; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
%theta=5; % BREADTH OF BIRTH RATE FUNCTION-- [1,8]  5 Priyanga 2015
m0=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
%alpha=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu=10; % plasticity of the trait of prey 
%epsilon=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Tmax=25; %MAX TEMPERATURE GIVEN THAT ENVIRONMENTAL WARMING 
Gx=0.0; % SPEED OF EVOLUTION 

%PREDATOR PARAMETERS

amax=1; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
%phi=0.01; % TEMPERATURE SENSITIVITY OF HANDLING TIME 
h_opt=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
%beta=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
%sigma=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=10; % plasticity of the trait of predator
Gy=0.0; %SPEED OF EVOLUTION 



theta_end=8;
epsilon_end=0.05;
sigma_end=8;
phi_end=0.01;
alpha_end=0.1;
beta_end=0.1;

theta=2:0.01:theta_end;
epsilon=0:0.0001:epsilon_end;
sigma=2:0.01:sigma_end;
phi=0:0.0001:phi_end;
alpha=0:0.001:0.1;
beta=0:0.001:0.1;

m1=length(theta);
m2=length(epsilon);
m3=length(sigma);
m4= length(phi);
m5= length(alpha);

R1 = zeros(m1, m2);  
R2 = zeros(m3, m2);
R3 = zeros(m4, m2);
R4 = zeros(m5,m2);
R5 = zeros (m5,m2);



x1=20; 
x2=0;
x3=10;
x4=0;
x5=19;


for i=1:m1
for j=1:m2

   

R1(i,j)=bmax*exp(-(epsilon(j)*200+19-Topt_x_0)^2/(2*theta(i)^2)); %birth rate
R2(i,j)=amax*exp(-(epsilon(j)*200+19-Topt_y_0)^2/(2*sigma(i)^2)); %attack rate


end
end


for k=1:m4
for j=1:m2

   
R3(k,j)=phi(k)*(epsilon(j)*200+19-Topt_y_0)^2+h_opt; %handling time


end
end

for l=1:m5
for j=1:m2

   
R4(l,j)=m0*exp(alpha(l)*((epsilon(j)*200+19-Topt_x_0)));
R5(l,j)=q0*exp(beta(l)*((epsilon(j)*200+19-Topt_y_0)));

end
end


%Birth rate
figure(1);

[X, Y] = meshgrid(theta, epsilon);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(flipud(jet));
caxis([min(R1(:)), max(R1(:))]);
colorbar;
ax = gca;
ax.FontSize = 30;
xlim([2, theta_end]);
ylim([0, epsilon_end]);
axis square;
xticks([2, 4, 6, 8]);
yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
%xlabel('\theta');  
%ylabel('\epsilon');  
set(gca, 'FontSize', 30);
   


%Mortality rate
% figure(2)
% [X, Y] = meshgrid(alpha, epsilon);
% contourf(X, Y, R4', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R4(:)), max(R4(:))]);
% clim([min(R4(:)), max(R4(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 24;
% xlim([0, alpha_end]);
% ylim([0, epsilon_end]);
% axis square;
% xticks([0, 0.05, 0.1]);
% yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
% xlabel('\alpha');  
% ylabel('\epsilon');   
% set(gca, 'FontSize', 24); 


figure(3);

%Attack rate
[X, Y] = meshgrid(sigma, epsilon);
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(flipud(jet));
caxis([min(R2(:)), max(R2(:))]);
clim([min(R2(:)), max(R2(:))]);
colorbar;
ax = gca;
ax.FontSize = 30;
xlim([2, sigma_end]);
ylim([0, epsilon_end]);
axis square;
xticks([2, 4, 6, 8]);
yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
%xlabel('\sigma'); 
%ylabel('\epsilon');   
set(gca, 'FontSize', 30); 

%Handling time
figure(4)
[X, Y] = meshgrid(phi, epsilon);
contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(jet);
caxis([min(R3(:)), max(R3(:))]);
clim([min(R3(:)), max(R3(:))]);
colorbar;
ax = gca;
ax.FontSize = 30;
xlim([0, phi_end]);
ylim([0, epsilon_end]);
axis square;
xticks([0, 0.005, 0.01]);
yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
%xlabel('\phi');  
%ylabel('\epsilon');   
set(gca, 'FontSize', 30); 

%Mortality rate
% figure(5)
% [X, Y] = meshgrid(beta, epsilon);
% contourf(X, Y, R5', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R5(:)), max(R5(:))]);
% clim([min(R5(:)), max(R5(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 24;
% xlim([0, beta_end]);
% ylim([0, epsilon_end]);
% axis square;
% xticks([0, 0.05, 0.1]);
% yticks([0, 0.01, 0.02, 0.03, 0.04, 0.05]);
% xlabel('\beta');  
% ylabel('\epsilon');   
% set(gca, 'FontSize', 24); 
