clc 
close all
clear all
tic;

N=3; %number of patches
t_custom = linspace(0, 5000, 1000); % Aquí 1000 es el número de puntos de tiempo

Ax=zeros(N); %prey dispersal rate
Ay=zeros(N); %predator dispersal rate 
for k=1:N
    Ax(k,k+1)=0.;
    Ax(k+1,k)=0.;

    Ay(k,k+1)=0.;
    Ay(k+1,k)=0.;
end

bmax=0.5*ones(1,N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=4*ones(1,N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1*ones(1,N); % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001*ones(1,N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01*ones(1,N); %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18*ones(1,N); % Topt PREY -- 20 Vasseur chapter book 2014
mu=3*ones(1,N); % plasticity of the trait of prey 
epsilon=0.03*ones(1,N); % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.01*ones(1,N); % SPEED OF EVOLUTION 

%amax=0.5*ones(1,N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01*ones(1,N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=1*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
%sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.01*ones(1,N); %SPEED OF EVOLUTION 


umbral1 = 1e-5;
umbral2 = 1;

amax_end=1;
sigma_end=8;

amaxx=0:0.01:amax_end;
sigmaa=2:0.05:sigma_end;

m1=length(amaxx);
m2=length(sigmaa);

amax = repmat(amaxx, N, 1);
sigma = repmat(sigmaa, N, 1);

R=cell(1,N);

R1 = zeros(m1, m2);  


for g3 = 1:N
for g1 = 1:m1
for g2 = 1:m2

P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax(:,g1)' phi h_opt p q0 delta beta sigma(:,g2)' Topt_y_0 eta Gy];


x1=20*ones(1,N);
x2=0*ones(1,N);
x3=10*ones(1,N);
x4=0*ones(1,N);
x5=14:(14+N-1);

x0 = [];

 
for l = 1:N


    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)]; 
end

t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi12(t, Y, P), t_custom, x0, options);

if Yv<0
    Yv =0;
end 
if Yv < umbral1
    Yv=0;
end



% what kind of orbit it is
R1=zeros(m1,m2);

total_x = zeros(1,N);
total_y = zeros(1,N);

max_value_x = zeros(1,N);
max_value_y = zeros(1,N);

min_value_x = zeros(1,N);
min_value_y = zeros(1,N);

metric1_x = zeros(1,N);
metric1_y = zeros(1,N);

metric2_x = zeros(1,N);
metric2_y = zeros(1,N);

metric3_x = zeros(1,N);
metric3_y = zeros(1,N);


Topt_x_end=zeros(1,N);
Topt_y_end=zeros(1,N);




for l1=1:N


total_x(l1) = mean(Yv(end-100:end,5*l1-4));
total_y(l1) = mean(Yv(end-100:end,5*l1-2));

max_value_x(l1) = max(Yv(end-100:end,5*l1-4));
max_value_y(l1) = max(Yv(end-100:end,5*l1-2));

min_value_x(l1) = min(Yv(end-100:end,5*l1-4));
min_value_y(l1) = min(Yv(end-100:end,5*l1-2));

metric1_x(l1) = abs (total_x(l1)-Yv(end,5*l1-4));
metric1_y(l1) = abs (total_y(l1)-Yv(end,5*l1-2));

metric2_x(l1) = abs (max_value_x(l1) - min_value_x(l1));
metric2_y(l1) = abs (max_value_y(l1) - min_value_y(l1));

metric3_x(l1) = abs(max_value_x(l1) - Yv(end,5*l1-4));
metric3_y(l1) = abs(max_value_y(l1) - Yv(end,5*l1-2));

if metric1_x(l1)>umbral1 && metric2_x(l1)>umbral2 || metric1_y(l1)>umbral1 && metric2_y(l1)>umbral2 || (metric1_x(l1)>umbral1 && metric3_x(l1)>0.1) || (metric1_y(l1)>umbral1 && metric3_y(l1)>0.1)
R1(l1)=3; % persistence oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) > umbral1   
R1(l1)=2; % persistence not oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) < umbral1   
R1(l1)=1; %just prey persistence
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && (Yv(end,5*l1-4) < umbral1 && Yv(end,5*l1-2) < umbral1)   
R1(l1)=0; %extinction 

end
end

 clear Yv

end 
end

R{1,g3}=R1';

clear R1

end 







toc;