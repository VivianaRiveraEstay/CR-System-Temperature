clc 
close all
clear all
tic;

% This code give the cell R, which have matrix in the parameter spece (Topt_x,Topt_y)

format long
N=15; %number of patches
umbral1 = 1e-5;
umbral2 = 0.8;

Ax=zeros(N);
Ay=zeros(N);
for k=1:N
    Ax(k,k+1)=0.1;
    Ax(k+1,k)=0.1;

    Ay(k,k+1)=0.1;
    Ay(k+1,k)=0.1;
end

bmax=0.5*ones(1,N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=5*ones(1,N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1*ones(1,N); % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001*ones(1,N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01*ones(1,N); %COEF INTRAS COMPETITION -- K0=90
%Topt_x_0=18*ones(1,N); % Topt PREY -- 20 Vasseur chapter book 2014
mu=3*ones(1,N); % plasticity of the trait of prey 
epsilon=0.03*ones(1,N); % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.0*ones(1,N); % SPEED OF EVOLUTION 

amax=0.5*ones(1,N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01*ones(1,N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=0.5*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
%Topt_y_0=16*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.0*ones(1,N); %SPEED OF EVOLUTION 

umbral1 = 1e-5;
umbral2 = 1;

Topt_x_0_end=26;
Topt_y_0_end=26;

Topt_x_00=12:0.5:Topt_x_0_end;
Topt_y_00=12:0.5:Topt_y_0_end;

m1=length(Topt_x_00);
m2=length(Topt_y_00);

for l3=1:m1
Topt_x_000(l3,:) = repmat(Topt_x_00(l3), 1, N); 
Topt_y_000(l3,:) = repmat(Topt_y_00(l3), 1, N);
end


R=cell(m1,m2); 
D_y=cell(m1,m2);
D_x=cell(m1,m2);


for g1 = 1:m1
for g2 = 1:m2

Topt_x_0 = Topt_x_000(g1,:);
Topt_y_0 = Topt_y_000(g2,:);

P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy ];
%% Condiciones iniciales:



x1=20*ones(1,N);
x2=0*ones(1,N);
x3=10*ones(1,N);
x4=0*ones(1,N);
x5=12:(12+N-1);

x0 = [];

for l = 1:N
    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)];
end



t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);
[tv, Yv] = ode45(@(t, Y) vivi_dispersal(t, Y, P), t_custom, x0, options);

% Primera condición: si Yv < 0, entonces Yv = 0
Yv(Yv < 0) = 0;

% Segunda condición: si Yv < umbral1, entonces Yv = 0
Yv(Yv < umbral1) = 0;

R1=zeros(1,N);
x=zeros(1,N);
y=zeros(1,N);


for l1=1:N

if numel(Yv) >= 501

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


else


total_x(l1) = NaN;
            total_y(l1) = NaN;
            max_value_x(l1) = NaN;
            max_value_y(l1) = NaN;
            min_value_x(l1) = NaN;
            min_value_y(l1) = NaN;
            metric1_x(l1) = NaN;
            metric1_y(l1) = NaN;
            metric2_x(l1) = NaN;
            metric2_y(l1) = NaN;
            metric3_x(l1) = NaN;
            metric3_y(l1) = NaN;

end


if metric1_x(l1)>umbral1 && metric2_x(l1)>umbral2 || metric1_y(l1)>umbral1 && metric2_y(l1)>umbral2 || (metric1_x(l1)>umbral1 && metric3_x(l1)>0.1) || (metric1_y(l1)>umbral1 && metric3_y(l1)>0.1)
R1(1,l1)=3; % persistence oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) > umbral1   
R1(1,l1)=2; % persistence not oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) < umbral1   
R1(1,l1)=1; %just prey persistence
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && (Yv(end,5*l1-4) < umbral1 && Yv(end,5*l1-2) < umbral1)   
R1(1,l1)=0; %extinction 

end
end

R1;
Yv=Yv(end-299:end,:);
for l2=1:N

if R1(1,l2) == 3
    %x(1,l2) = (max(Yv(:,5*l2-4)) + min(Yv(:,5*l2-4)))/2;
    %y(1,l2) = (max(Yv(:,5*l2-2))+ min(Yv(:,5*l2-2)))/2;

    x(1,l2) = mean(Yv(:,5*l2-4));
    y(1,l2) = mean(Yv(:,5*l2-2));

else % if R1 is not equal to 3 
    x(1,l2) = Yv(end,5*l2-4);
    y(1,l2) = Yv(end,5*l2-2);
end
end


D_y{g1,g2} = x;
D_x{g1,g2} = y;
R{g1,g2} = R1;

clear R1
clear x;
clear y;
clear Yv;

end
end



 %clear Yv



toc



