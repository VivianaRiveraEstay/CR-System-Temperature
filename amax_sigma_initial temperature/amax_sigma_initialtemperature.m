

addpath('/Users/vivianarivera/Documents/PASANTIA/Code1_temperature');

clc 
close all
clear all
tic;

format long

%PREY PARAMETERS

bmax=0.5; %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=4; % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1; % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001; % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01; %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18; % Topt PREY -- 20 Vasseur chapter book 2014
mu=3; % plasticity of the trait of prey 
epsilon=0.03; % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.0; % SPEED OF EVOLUTION 

%PREDATOR PARAMETERS

%amax=0.5; % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01; % TEMPERATURE SENSITIVITY OF HANDLING TIME 
h_opt=1; % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1; % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01; %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001; %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01; %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
%sigma=3; %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3; % plasticity of the trait of predator
Gy=0.0; %SPEED OF EVOLUTION 


x1=20; 
x2=0;
x3=10;
x4=0;
x5=19;

umbral1 = 1e-5;
umbral2 = 1;

amax_end=1;
sigma_end=8;

amax=0:0.01:amax_end;
sigma=2:0.05:sigma_end;

m1=length(amax);
m2=length(sigma);


R1 = zeros(m1, m2);  

total_x = zeros(m1, m2);
total_y = zeros(m1, m2);
max_value_x = zeros(m1, m2);
max_value_y = zeros(m1, m2);
min_value_x = zeros(m1, m2);
min_value_y = zeros(m1, m2);
metric1_x= zeros(m1, m2);
metric1_y = zeros(m1, m2);
metric2_x = zeros(m1, m2);
metric2_y = zeros(m1, m2);
metric3_x = zeros(m1, m2);
metric3_y = zeros(m1, m2);


% time interval
tspan=[0 5000];



for i=1:m1
for j=1:m2

x0=[x1 x2 x3 x4 x5];
   
P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax(i) phi h_opt p q0 delta beta sigma(j) Topt_y_0 eta Gy];

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi8(t, Y, P), tspan, x0, options);


if numel(Yv) >= 501

            total_x(i, j) = mean(Yv(end-100:end, 1));
            total_y(i, j) = mean(Yv(end-100:end, 3));
            max_value_x(i, j) = max(Yv(end-100:end, 1));
            max_value_y(i, j) = max(Yv(end-100:end, 3));
            min_value_x(i, j) = min(Yv(end-100:end, 1));
            min_value_y(i, j) = min(Yv(end-100:end, 3));
            metric1_x(i, j) = abs(total_x(i, j) - Yv(end, 1));
            metric1_y(i, j) = abs(total_y(i, j) - Yv(end, 3));
            metric2_x(i, j) = abs(max_value_x(i, j) - min_value_x(i, j));
            metric2_y(i, j) = abs(max_value_y(i, j) - min_value_y(i, j));
            metric3_x(i,j)=abs(max_value_x(i,j) - Yv(end,1));
            metric3_y(i,j)=abs(max_value_y(i,j) - Yv(end,3));
    
          
        else
            % Handle the case when Yv doesn't have enough elements
            total_x(i, j) = NaN;
            total_y(i, j) = NaN;
            max_value_x(i, j) = NaN;
            max_value_y(i, j) = NaN;
            min_value_x(i, j) = NaN;
            min_value_y(i, j) = NaN;
            metric1_x(i, j) = NaN;
            metric1_y(i, j) = NaN;
            metric2_x(i, j) = NaN;
            metric2_y(i, j) = NaN;
            metric3_x(i, j) = NaN;
            metric3_y(i, j) = NaN;

end


if metric1_x(i,j)>umbral1 && metric2_x(i,j)>umbral2 || metric1_y(i,j)>umbral1 && metric2_y(i,j)>umbral2 || (metric3_x(i,j)>0.2 && metric1_x(i,j)>umbral1 ) || (metric3_y(i,j)>0.2 && metric1_y(i,j)>umbral1)
R1(i,j)=3; % persistence oscillation
elseif (metric1_x(i,j)<umbral1 && metric1_y(i,j)<umbral1 || metric2_x(i,j)<umbral2 && metric2_y(i,j)<umbral2) && Yv(end,1) > umbral1 && Yv(end,3) > umbral1   
R1(i,j)=2; % persistence not oscillation
elseif (metric1_x(i,j)<umbral1 && metric1_y(i,j)<umbral1 || metric2_x(i,j)<umbral2 && metric2_y(i,j)<umbral2) && Yv(end,1) > umbral1 && Yv(end,3) < umbral1   
R1(i,j)=1; %just prey persistence
elseif (metric1_x(i,j)<umbral1 && metric1_y(i,j)<umbral1 || metric2_x(i,j)<umbral2 && metric2_y(i,j)<umbral2) && Yv(end,1) < umbral1 && Yv(end,3) < umbral1   
R1(i,j)=0; %extinction 

end

 clear Yv

end
end





color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

contourLevels = [0, 1, 2, 3]; % Para tus datos discretos de 0 a 3


color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]

% Asigna la paleta de colores personalizada
colormap(color_map_pastel);


figure(1);
[X, Y] = meshgrid(amax, sigma);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([0, amax_end]);
ylim([2, sigma_end]);
axis square;
xticks([0, 0.5, 1]);
yticks([2, 4, 6, 8]);
xlabel('a_{max}');  
ylabel('\sigma');  
set(gca, 'FontSize', 20); 




